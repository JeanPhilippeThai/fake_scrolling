#!/usr/bin/env python3
"""Build and query this app's registry database: every ID of its docs and every link between them.

The docs are the source of truth. The database is an index built from them, never edited: change
the file, and the next command rebuilds it.

    registry_db.py build             rebuild .registry/registry.db from the docs
    registry_db.py check [CHECK...]  run the shipped checks (all, or those named, e.g. L3-02)
        --since REV                  also compare with the docs at git revision REV (G-03)
    registry_db.py impact ID...      everything a change to these IDs can reach, nearest first
    registry_db.py where ID...       where each ID is defined and every line that cites it
    registry_db.py query SQL         run one read-only SQL query
    registry_db.py schema            list the tables and views with their columns
    registry_db.py diff BASE HEAD    IDs and links added, removed or changed between two docs folders,
                                     then G-03: exits 1 when an ID is gone without being retired

Every command except build and diff first rebuilds the database when a doc changed since it was built.
Docs are read from docs/ and claude_docs/ at the repo root: *.yaml files, and the ```yaml blocks of
*.md files, joined in order so that a YAML split over several blocks parses as one. A flow (prompt 5)
is prose, not YAML: it is defined by a Markdown heading that starts with its ID ("## FL-01 Connexion"),
and its section cites the pages, features and entities it links to.
"""
import argparse
import datetime
import hashlib
import io
import json
import os
import re
import sqlite3
import subprocess
import sys
import tarfile
import tempfile
from pathlib import Path

try:
    import yaml
except ImportError:
    sys.exit("registry_db.py needs PyYAML: pip install pyyaml")

HERE = Path(__file__).resolve().parent
CHECKS_FILE = HERE / "checks.sql"
DEFAULT_DOCS = ["docs", "claude_docs"]
DB_REL = Path(".registry") / "registry.db"
PLATFORMS = ("web", "desktop", "mobile")
CANONICAL = "canonical"

# Kind of each ID, most specific prefix first, so that SM-E-03 is never read as E-03.
KINDS = [
    ("state_model", r"SM-E-\d{2,}"),
    ("nfr", r"NFR-(?:\d{3}|X)-\d+"),
    ("rule", r"BR-(?:\d{3}|X)-\d+"),
    ("criterion", r"AC-(?:\d{3}|X)-\d+"),
    ("table", r"TB-\d{2,}"),
    ("data_flow", r"DF-\d{2,}"),
    ("flow", r"FL-\d{2,}"),
    ("component", r"C-[WDM]?\d{2,}-\d{2,}"),
    ("page_state", r"P-[WDM]?\d{2,}\.[a-z]{1,2}"),
    ("page", r"P-[WDM]?\d{2,}"),
    ("variant", r"F-\d{3,}\.[a-z]{1,2}"),
    ("feature", r"F-\d{3,}"),
    ("entity", r"E-\d{2,}"),
    ("role", r"R-\d{2,}"),
    ("decision", r"D-\d{2,}"),
    ("node", r"N-\d{2,}"),
    ("question", r"Q-\d{2,}"),
    ("workaround", r"W-\d{2,}"),
    ("task", r"T-\d{3,}"),
]
KIND_RES = [(k, re.compile(p)) for k, p in KINDS]
MENTION_RE = re.compile(r"(?<![\w-])(?:" + "|".join(p for _, p in KINDS) + r")(?![\w-])")
# A format template copied from a prompt is not data. It is a YAML block where a placeholder ID is a
# value (`stockage: N-xx`, not a quoted sentence or a comment that names one), or where every `nom:`
# is empty.
PLACEHOLDER_RE = re.compile(r"(?<![\w-])(?:P-[WDM]?|F-|E-|R-|D-|TB-|N-|DF-|FL-|C-|SM-E-)(?:x{2,3}|NNN?)(?![\w])")
QUOTED_RE = re.compile(r"\"(?:[^\"\\]|\\.)*\"|'(?:[^']|'')*'")
COMMENT_RE = re.compile(r"(?:^|\s)#.*$")
EMPTY_NOM_RE = re.compile(r"^\s*(?:-\s*)?nom\s*:\s*$")
FULL_NOM_RE = re.compile(r"^\s*(?:-\s*)?nom\s*:\s*\S")


def is_template(block):
    bare = [COMMENT_RE.sub("", QUOTED_RE.sub('""', line)) for line in block.splitlines()]
    if any(PLACEHOLDER_RE.search(line) for line in bare):
        return True
    return any(EMPTY_NOM_RE.match(l) for l in bare) and not any(FULL_NOM_RE.match(l) for l in bare)
FENCE_OPEN_RE = re.compile(r"^(`{3,}|~{3,})\s*([\w-]*)\s*$")
ID_LINE_RE = re.compile(r"^\s*(?:-\s*)?(?:id|page)\s*:\s*['\"]?([A-Z][\w.-]*)")
ARCHIVE_RE = re.compile(r"archiv", re.I)
HEADING_RE = re.compile(r"^(#{1,6})\s+(.*?)\s*#*\s*$")
# A flow's heading starts with its ID, after an optional "Flow": "## FL-01 Connexion", "### Flow FL-02 : Purge".
FLOW_HEADING_RE = re.compile(r"^(?:\*\*)?(?:flow\s+)?(FL-\d{2,})(?![\w-])(?:\*\*)?[\s:·.–—-]*(.*)$", re.I)
NAME_TRIM = " \t\"'«»“”*:·–—-"
# The link from a flow to each kind of ID its section cites.
FLOW_RELS = {"page": "flow_page", "page_state": "flow_page", "feature": "flow_feature", "variant": "flow_feature",
             "entity": "flow_entity", "role": "flow_role", "decision": "flow_decision", "flow": "flow_flow"}

# Direction of each link for the impact walk: 1 when a change to `source` can affect `target`,
# 0 when it is the other way round. Links not listed here (aliases) stay out of the `links` view.
REL_DIRECTION = {
    "page_state": 1, "page_feature": 0, "feature_page": 1, "feature_role": 0, "feature_entity": 0,
    "entity_feature": 1, "variant_feature": 0, "variant_page": 1, "variant_role": 0,
    "decision_cites": 1, "table_entity": 0, "table_store": 0, "column_reference": 0,
    "node_role": 0, "data_flow_source": 0, "data_flow_target": 0, "data_flow_entity": 0,
    "data_flow_feature": 0, "data_flow_flow": 0, "contract_role": 0, "component_page": 0,
    "component_feature": 0, "component_table": 0, "component_data_flow": 0,
    "component_condition": 0, "flow_page": 0, "flow_feature": 0, "flow_entity": 0, "flow_role": 0,
    "flow_decision": 0, "flow_flow": 0, "flow_cites": 0,
}

SCHEMA = """
CREATE TABLE meta(key TEXT PRIMARY KEY, value TEXT);
CREATE TABLE sources(path TEXT, part TEXT, content TEXT, scope TEXT, note TEXT);
CREATE TABLE docs(path TEXT PRIMARY KEY, scope TEXT, archived INT);
CREATE TABLE defs(scope TEXT, id TEXT, kind TEXT, expected_kind TEXT, path TEXT, line INT, name TEXT, data TEXT, number TEXT);
CREATE TABLE refs(scope TEXT, source TEXT, rel TEXT, target TEXT, path TEXT);
CREATE TABLE aliases(kind TEXT, id TEXT, platform TEXT, alias TEXT, path TEXT, partial INT DEFAULT 0, retired INT DEFAULT 0);
CREATE TABLE alias_decisions(scope TEXT, id TEXT, decision TEXT, path TEXT);
CREATE TABLE retired(scope TEXT, id TEXT, decision TEXT, path TEXT);
CREATE TABLE roles(scope TEXT, id TEXT, name TEXT, reach TEXT, path TEXT);
CREATE TABLE pages(scope TEXT, id TEXT, name TEXT, platform TEXT, path TEXT);
CREATE TABLE features(scope TEXT, id TEXT, name TEXT, operations TEXT, path TEXT);
CREATE TABLE feature_platforms(scope TEXT, feature TEXT, platform TEXT);
CREATE TABLE variants(scope TEXT, id TEXT, feature TEXT, difference TEXT, own_access INT, path TEXT);
CREATE TABLE variant_platforms(scope TEXT, variant TEXT, platform TEXT);
CREATE TABLE entities(scope TEXT, id TEXT, name TEXT, path TEXT);
CREATE TABLE entity_fields(scope TEXT, entity TEXT, field TEXT);
CREATE TABLE decisions(scope TEXT, id TEXT, subject TEXT, choice TEXT, reason TEXT, path TEXT);
CREATE TABLE data_tables(id TEXT, name TEXT, type TEXT, store TEXT, entity TEXT, reason TEXT, path TEXT);
CREATE TABLE table_columns(table_id TEXT, name TEXT, type TEXT, key TEXT, reference TEXT, required INT);
CREATE TABLE nodes(id TEXT, type TEXT, name TEXT, role TEXT, model TEXT, path TEXT);
CREATE TABLE data_flows(id TEXT, source TEXT, target TEXT, protocol TEXT, sensitive INT, path TEXT);
CREATE TABLE page_contracts(page TEXT, name TEXT, path TEXT);
CREATE TABLE components(id TEXT, page TEXT, accessible_name TEXT, type TEXT, feature TEXT, path TEXT);
CREATE TABLE component_columns(component TEXT, column_ref TEXT, mode TEXT);
CREATE TABLE component_conditions(component TEXT, mode TEXT, condition TEXT);
CREATE TABLE flows(scope TEXT, id TEXT, name TEXT, path TEXT, line INT, end_line INT);
CREATE TABLE missing(path TEXT, line INT, text TEXT);
CREATE TABLE mentions(scope TEXT, id TEXT, kind TEXT, path TEXT, line INT, written TEXT);
CREATE TABLE problems(path TEXT, line INT, message TEXT);
CREATE TABLE rel_direction(rel TEXT PRIMARY KEY, forward INT);
CREATE VIEW ids AS SELECT scope, id, kind, MIN(path) AS path, MIN(line) AS line, MIN(name) AS name
  FROM defs GROUP BY scope, id, kind;
CREATE VIEW links AS SELECT DISTINCT
  CASE d.forward WHEN 1 THEN r.source ELSE r.target END AS source,
  CASE d.forward WHEN 1 THEN r.target ELSE r.source END AS target,
  r.rel AS rel
  FROM refs r JOIN rel_direction d ON d.rel = r.rel WHERE r.scope = 'canonical';
-- An ID out of its kind's format, defined twice, or written with other digits (D-01 and D-001):
-- L3-01 reads the registry's rows (registry = 1), G-01 the others.
CREATE VIEW id_problems AS
  WITH d AS (SELECT *, expected_kind IN ('role','page','feature','variant','entity','decision') AS registry FROM defs)
  SELECT scope, id,
    'a ' || expected_kind || ' whose ID ' || CASE kind WHEN 'unknown' THEN 'has no known format' ELSE 'reads as a ' || kind END AS problem,
    path, line, registry
  FROM d WHERE kind != expected_kind AND NOT (expected_kind = 'page' AND kind = 'page_state')
  UNION ALL
  SELECT scope, id, 'defined ' || COUNT(*) || ' times', GROUP_CONCAT(DISTINCT path), MIN(line), registry
  FROM d GROUP BY scope, id, registry HAVING COUNT(*) > 1
  UNION ALL
  SELECT scope, GROUP_CONCAT(DISTINCT id), 'the same ID written with different digits: an ID is a number',
    GROUP_CONCAT(DISTINCT path), MIN(line), registry
  FROM d GROUP BY scope, number, registry HAVING COUNT(DISTINCT id) > 1;
CREATE INDEX refs_source ON refs(scope, source);
CREATE INDEX refs_target ON refs(scope, target);
CREATE INDEX defs_id ON defs(scope, id);
CREATE INDEX mentions_id ON mentions(id);
"""


def id_number(id_):
    """An ID compared as a number: D-01 and D-001 are both D-1, the same ID."""
    return re.sub(r"\d+", lambda m: str(int(m.group())), id_)


def id_key(id_):
    """Sorts IDs by number: D-200 before D-1000."""
    return [(0, int(part), "") if part.isdigit() else (1, 0, part) for part in re.split(r"(\d+)", id_ or "")]


def kind_of(id_):
    for kind, rx in KIND_RES:
        if rx.fullmatch(id_):
            return kind
    return None


def as_list(v):
    if v is None:
        return []
    if isinstance(v, (list, tuple)):
        return list(v)
    return [v]


def text(v):
    if v is None:
        return None
    if isinstance(v, (list, dict)):
        return json.dumps(v, ensure_ascii=False, default=str)
    return str(v)


RANGE_WORD_RE = re.compile(r"\s+(?:à|au|to)\s+$")
NUMBERED_RE = re.compile(r"^(.*-)(\d+)$")


def cited_ids(line):
    """The IDs a text cites. An ID followed by "…" or "..." is a format example (D-01…), not a
    citation. A range of one kind ("R-01 à R-07", "F-024 to F-035") cites every ID in it."""
    out, prev = [], None
    for m in MENTION_RE.finditer(line):
        rest = line[m.end():m.end() + 3]
        if rest.startswith("…") or rest.startswith("..."):
            prev = None
            continue
        id_ = m.group(0)
        if prev and RANGE_WORD_RE.search(line[prev.end():m.start()]):
            a, b = NUMBERED_RE.match(prev.group(0)), NUMBERED_RE.match(id_)
            if a and b and a.group(1) == b.group(1) and 0 < int(b.group(2)) - int(a.group(2)) <= 200:
                width = len(a.group(2))
                out += [f"{a.group(1)}{n:0{width}d}" for n in range(int(a.group(2)) + 1, int(b.group(2)))]
        out.append(id_)
        prev = m
    return out


def ids_in(v):
    """Every ID cited in a value, however nested: a list, a dict or free text."""
    out = []
    if isinstance(v, dict):
        for x in v.values():
            out += ids_in(x)
    elif isinstance(v, (list, tuple)):
        for x in v:
            out += ids_in(x)
    elif v is not None:
        out += cited_ids(str(v))
    return out


def repo_root():
    try:
        out = subprocess.run(["git", "rev-parse", "--show-toplevel"], capture_output=True, text=True, check=True)
        return Path(out.stdout.strip())
    except (subprocess.CalledProcessError, FileNotFoundError):
        return Path.cwd()


def git_head(root):
    try:
        out = subprocess.run(["git", "-C", str(root), "rev-parse", "--short", "HEAD"], capture_output=True, text=True, check=True)
        return out.stdout.strip()
    except (subprocess.CalledProcessError, FileNotFoundError):
        return ""


def doc_files(root, docs):
    files = []
    for d in docs:
        base = root / d
        if not base.is_dir():
            continue
        for p in sorted(base.rglob("*")):
            if p.is_file() and p.suffix.lower() in (".md", ".yaml", ".yml"):
                files.append(p)
    return files


def fingerprint(root, docs):
    h = hashlib.sha256()
    for p in (Path(__file__).resolve(), CHECKS_FILE):
        h.update(p.name.encode())
        h.update(p.read_bytes())
    for p in doc_files(root, docs):
        h.update(str(p.relative_to(root)).encode())
        h.update(p.read_bytes())
    h.update(json.dumps(docs).encode())
    return h.hexdigest()[:16]


def yaml_blocks(lines):
    """Top-level ```yaml blocks of a Markdown file, as (first line number, text)."""
    blocks, i = [], 0
    while i < len(lines):
        m = FENCE_OPEN_RE.match(lines[i])
        if not m:
            i += 1
            continue
        fence, lang = m.group(1), m.group(2).lower()
        j = i + 1
        while j < len(lines) and not (lines[j].strip().startswith(fence[0] * len(fence)) and lines[j].strip().strip(fence[0]) == ""):
            j += 1
        if lang in ("yaml", "yml"):
            blocks.append((i + 2, "\n".join(lines[i + 1:j])))
        i = j + 1
    return blocks


def md_headings(lines):
    """Headings of a Markdown file outside fenced blocks, as (line number, level, text, last line of
    its section): the section runs to the next heading of the same or a higher level."""
    heads, fence = [], None
    for n, line in enumerate(lines, 1):
        stripped = line.strip()
        if fence:
            if stripped.startswith(fence) and stripped.strip(fence[0]) == "":
                fence = None
            continue
        m = FENCE_OPEN_RE.match(stripped)
        if m:
            fence = m.group(1)
            continue
        m = HEADING_RE.match(line)
        if m:
            heads.append([n, len(m.group(1)), m.group(2), len(lines)])
    for i, h in enumerate(heads):
        nxt = next((g for g in heads[i + 1:] if g[1] <= h[1]), None)
        if nxt:
            h[3] = nxt[0] - 1
    return [tuple(h) for h in heads]


def is_registry(doc):
    return isinstance(doc, dict) and ("pages" in doc or "features" in doc)


def platform_words(name):
    return [p for p in PLATFORMS if re.search(rf"(?<![a-z]){p}(?![a-z])", name, re.I)]


class Builder:
    def __init__(self, root, docs, db_path, fp=None):
        self.root, self.docs, self.db_path, self.fp = root, docs, db_path, fp
        self.file_scope = {}
        self.id_lines = {}

    def rel(self, p):
        return str(p.relative_to(self.root))

    # -- writing rows -------------------------------------------------------------------------
    def row(self, table, *values):
        self.db.execute(f"INSERT INTO {table} VALUES ({','.join('?' * len(values))})", values)

    def problem(self, path, msg, line=None):
        self.row("problems", path, line, msg)

    def define(self, scope, id_, expected, path, name=None, data=None, line=None):
        if not isinstance(id_, str) or not id_.strip():
            self.problem(path, f"a {expected} has no id: {text(data)[:120] if data else ''}")
            return None
        id_ = id_.strip()
        line = line or self.id_lines.get(path, {}).get(id_)
        self.row("defs", scope, id_, kind_of(id_) or "unknown", expected, path, line, text(name), text(data), id_number(id_))
        return id_

    def ref(self, scope, source, rel, targets, path):
        for t in as_list(targets):
            if t is None or t == "":
                continue
            # One token is an ID as written, even in a format the method does not know (P-01.c);
            # a sentence or a nested value gives every ID it cites.
            single = isinstance(t, (str, int)) and len(str(t).split()) == 1
            for tid in ([str(t).strip()] if single else ids_in(t)):
                self.row("refs", scope, source, rel, tid, path)

    def alias(self, kind, id_, item, scope, path, retired=0):
        """An item's old IDs: `alias`, `alias_partiel` (a split, prompt 10) and `alias_decision` (a merge)."""
        def pairs(value):
            if value is None or value == {} or value == "":
                return []
            if isinstance(value, dict):
                return [(str(pl), str(o)) for pl, old in value.items() for o in as_list(old)]
            return [(None, str(o)) for o in as_list(value)]
        for platform, old in pairs(item.get("alias")):
            self.row("aliases", kind, id_, platform, old, path, 0, retired)
        for platform, old in pairs(item.get("alias_partiel")):
            hit = self.db.execute("UPDATE aliases SET partial = 1 WHERE id = ? AND alias = ? AND platform IS ?",
                                  (id_, old, platform)).rowcount
            if not hit:
                self.row("aliases", kind, id_, platform, old, path, 1, retired)
        for dec in as_list(item.get("alias_decision")):
            self.row("alias_decisions", scope, id_, text(dec), path)

    # -- reading the docs ---------------------------------------------------------------------
    def build(self):
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        ignore = self.db_path.parent / ".gitignore"
        if not ignore.exists():
            ignore.write_text("# Built by .claude/skills/registry-db from the docs; never committed.\n*\n")
        tmp = self.db_path.with_suffix(".tmp")
        if tmp.exists():
            tmp.unlink()
        self.db = sqlite3.connect(tmp)
        self.db.executescript("PRAGMA journal_mode=OFF; PRAGMA synchronous=OFF; BEGIN;" + SCHEMA + "COMMIT;")
        self.db.executemany("INSERT INTO rel_direction VALUES (?,?)", REL_DIRECTION.items())

        files = doc_files(self.root, self.docs)
        parsed = []
        for p in files:
            path = self.rel(p)
            try:
                raw = p.read_text(encoding="utf-8")
            except UnicodeDecodeError:
                self.problem(path, "not UTF-8 text")
                continue
            lines = raw.splitlines()
            self.id_lines[path] = {}
            for n, line in enumerate(lines, 1):
                m = ID_LINE_RE.match(line)
                if m:
                    self.id_lines[path].setdefault(m.group(1), n)
            if p.suffix.lower() in (".yaml", ".yml"):
                blocks = [(1, raw)]
            else:
                blocks = yaml_blocks(lines)
            skip_lines = set()
            data_text = []
            for first, block in blocks:
                if is_template(block):
                    n = block.count("\n") + 1
                    skip_lines.update(range(first, first + n))
                    self.row("sources", path, f"line {first}", "template", None, "format template from a prompt: not read as data")
                else:
                    data_text.append(block)
            doc = None
            if data_text:
                try:
                    doc = yaml.safe_load("\n".join(data_text))
                except yaml.YAMLError as e:
                    mark = getattr(e, "problem_mark", None)
                    self.problem(path, f"YAML does not parse: {getattr(e, 'problem', e)}"
                                 + (" (in the YAML blocks joined, line %d)" % (mark.line + 1) if mark else ""))
            parsed.append((p, path, raw, lines, doc, skip_lines))

        # An app with an archived per-platform registry targets several platforms.
        multi = any(is_registry(d) and self.is_archive(path, lines)
                    for _, path, _, lines, d, _ in parsed)

        canonical_registries = []
        for p, path, raw, lines, doc, skip in parsed:
            scope = self.scope_of(path, lines, doc, multi)
            self.file_scope[path] = scope
            if isinstance(doc, dict):
                self.load(doc, path, scope, lines)
                if scope == CANONICAL and is_registry(doc):
                    canonical_registries.append(path)
            elif doc is not None:
                self.problem(path, "the YAML is not a mapping of sections (roles, pages, features, …)")
            if p.suffix.lower() == ".md":
                self.load_flows(path, scope, lines, skip)
            # A doc named or titled "archive" is frozen history: kept, never held to the current IDs.
            self.row("docs", path, scope, int(self.is_archive(path, lines)))
            # Every ID cited. After the merge, a live doc cites canonical IDs only, inventories included.
            for n, line in enumerate(lines, 1):
                if n in skip:
                    continue
                for m in cited_ids(line):
                    self.row("mentions", scope, m, kind_of(m), path, n, m)
        if len(canonical_registries) > 1:
            self.problem(", ".join(canonical_registries),
                         "more than one canonical registry: archive the per-platform ones (name them with 'archive' and their platform)")

        meta = {
            "built_at": datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="seconds"),
            "commit": git_head(self.root),
            "fingerprint": self.fp or fingerprint(self.root, self.docs),
            "docs": json.dumps(self.docs),
            "multi_platform": "1" if multi else "0",
        }
        self.db.executemany("INSERT INTO meta VALUES (?,?)", meta.items())
        self.db.commit()
        self.db.close()
        os.replace(tmp, self.db_path)
        return meta

    @staticmethod
    def title(lines):
        return next((l for l in lines[:15] if l.startswith("# ")), "")

    def is_archive(self, path, lines):
        """An archived per-platform registry says so in its file name or its title."""
        return bool(ARCHIVE_RE.search(Path(path).name) or ARCHIVE_RE.search(self.title(lines)))

    def scope_of(self, path, lines, doc, multi):
        words = platform_words(Path(path).name)
        if is_registry(doc) and self.is_archive(path, lines):
            if len(words) == 1:
                return words[0]
            title = platform_words(self.title(lines))
            if len(set(title)) == 1:
                return title[0]
            plats = {pg.get("plateforme") for pg in doc.get("pages") or [] if isinstance(pg, dict)}
            if len(plats) == 1 and None not in plats:
                return str(plats.pop())
            self.problem(path, "archived registry whose platform is unclear: put web, desktop or mobile in its file name")
            return "unknown"
        return CANONICAL

    def load(self, doc, path, scope, lines):
        sections = []
        if any(k in doc for k in ("roles", "pages", "features", "entites", "decisions", "ids_retires")):
            self.load_registry(doc, path, scope)
            sections.append("registry")
        if "tables" in doc:
            self.load_data_model(doc, path)
            sections.append("data_model")
        if "noeuds" in doc or "flux" in doc:
            self.load_data_flows(doc, path)
            sections.append("data_flows")
        if "page" in doc and "composants" in doc:
            self.load_contract(doc, path, lines)
            sections.append("page_contract")
        if not sections:
            sections.append("other")
        for s in sections:
            self.row("sources", path, "yaml", s, scope, None)

    def items(self, doc, key, path):
        out = []
        for it in as_list(doc.get(key)):
            if isinstance(it, dict):
                out.append(it)
            else:
                self.problem(path, f"an item of `{key}` is not a mapping: {text(it)[:120]}")
        return out

    def load_registry(self, doc, path, scope):
        for r in self.items(doc, "roles", path):
            rid = self.define(scope, r.get("id"), "role", path, r.get("nom"), r)
            if rid:
                self.row("roles", scope, rid, text(r.get("nom")), text(r.get("portee")), path)
                self.alias("role", rid, r, scope, path)
        for pg in self.items(doc, "pages", path):
            pid = self.define(scope, pg.get("id"), "page", path, pg.get("nom"), pg)
            if pid:
                self.row("pages", scope, pid, text(pg.get("nom")), text(pg.get("plateforme")), path)
                self.ref(scope, pid, "page_feature", pg.get("features"), path)
                self.alias("page", pid, pg, scope, path)
                if kind_of(pid) == "page_state":
                    # A state belongs to its page: a change to the page can reach it.
                    self.row("refs", scope, pid.split(".")[0], "page_state", pid, path)
        for f in self.items(doc, "features", path):
            fid = self.define(scope, f.get("id"), "feature", path, f.get("nom"), {k: v for k, v in f.items() if k != "variantes"})
            if not fid:
                continue
            self.row("features", scope, fid, text(f.get("nom")), text(f.get("operations")), path)
            for plat in as_list(f.get("plateformes")):
                self.row("feature_platforms", scope, fid, str(plat))
            self.ref(scope, fid, "feature_page", f.get("pages"), path)
            self.ref(scope, fid, "feature_role", f.get("acces"), path)
            self.ref(scope, fid, "feature_entity", f.get("entites"), path)
            self.alias("feature", fid, f, scope, path)
            for v in as_list(f.get("variantes")):
                if not isinstance(v, dict):
                    self.problem(path, f"a variant of {fid} is not a mapping: {text(v)[:120]}")
                    continue
                vid = self.define(scope, v.get("id"), "variant", path, v.get("difference"), v)
                if not vid:
                    continue
                self.row("variants", scope, vid, fid, text(v.get("difference")), 1 if "acces" in v else 0, path)
                for plat in as_list(v.get("plateforme")):
                    self.row("variant_platforms", scope, vid, str(plat))
                self.row("refs", scope, vid, "variant_feature", fid, path)
                self.ref(scope, vid, "variant_page", v.get("pages"), path)
                self.ref(scope, vid, "variant_role", v.get("acces"), path)
                self.alias("variant", vid, v, scope, path)
        for e in self.items(doc, "entites", path):
            eid = self.define(scope, e.get("id"), "entity", path, e.get("nom"), e)
            if not eid:
                continue
            self.row("entities", scope, eid, text(e.get("nom")), path)
            for fld in as_list(e.get("champs", e.get("champs_visibles"))):
                self.row("entity_fields", scope, eid, text(fld))
            self.ref(scope, eid, "entity_feature", e.get("utilisee_par"), path)
            self.alias("entity", eid, e, scope, path)
        for d in self.items(doc, "decisions", path):
            did = self.define(scope, d.get("id"), "decision", path, d.get("sujet"), d)
            if not did:
                continue
            self.row("decisions", scope, did, text(d.get("sujet")), text(d.get("choix")), text(d.get("raison")),
                     path)
            cited = ids_in({k: v for k, v in d.items() if k not in ("id", "alias", "alias_partiel")})
            self.ref(scope, did, "decision_cites", sorted(set(cited) - {did}), path)
            self.alias("decision", did, d, scope, path)
        for r in self.items(doc, "ids_retires", path):
            # No `id`: an old per-platform ID retired before the merge, never canonical.
            rid = text(r.get("id"))
            if not rid and not r.get("alias"):
                self.problem(path, f"an entry of ids_retires has neither id nor alias: {text(r)[:120]}")
                continue
            if rid:
                self.row("retired", scope, rid, text(r.get("decision")), path)
            olds = ids_in(r.get("alias"))
            self.alias(kind_of(rid or (olds[0] if olds else "")) or "unknown", rid, r, scope, path, retired=1)

    def load_data_model(self, doc, path):
        s = CANONICAL
        for t in self.items(doc, "tables", path):
            tid = self.define(s, t.get("id"), "table", path, t.get("nom"), {k: v for k, v in t.items() if k != "colonnes"})
            if not tid:
                continue
            self.row("data_tables", tid, text(t.get("nom")), text(t.get("type")), text(t.get("stockage")),
                     text(t.get("entite")), text(t.get("raison")), path)
            self.ref(s, tid, "table_entity", [x for x in ids_in(t.get("entite")) if kind_of(x) == "entity"], path)
            self.ref(s, tid, "table_store", t.get("stockage"), path)
            for c in as_list(t.get("colonnes")):
                if not isinstance(c, dict):
                    self.problem(path, f"a column of {tid} is not a mapping: {text(c)[:120]}")
                    continue
                req = c.get("obligatoire")
                self.row("table_columns", tid, text(c.get("nom")), text(c.get("type")), text(c.get("cle")),
                         text(c.get("reference")), None if req is None else int(bool(req)))
                self.ref(s, tid, "column_reference", [x for x in ids_in(c.get("reference")) if kind_of(x) == "table"], path)

    def load_data_flows(self, doc, path):
        s = CANONICAL
        for n in self.items(doc, "noeuds", path):
            nid = self.define(s, n.get("id"), "node", path, n.get("nom"), n)
            if nid:
                self.row("nodes", nid, text(n.get("type")), text(n.get("nom")), text(n.get("role")),
                         text(n.get("modele")), path)
                self.ref(s, nid, "node_role", n.get("role"), path)
        for f in self.items(doc, "flux", path):
            fid = self.define(s, f.get("id"), "data_flow", path, None, f)
            if not fid:
                continue
            sens = f.get("sensible")
            self.row("data_flows", fid, text(f.get("de")), text(f.get("vers")), text(f.get("protocole")),
                     None if sens is None else int(bool(sens)), path)
            self.ref(s, fid, "data_flow_source", f.get("de"), path)
            self.ref(s, fid, "data_flow_target", f.get("vers"), path)
            self.ref(s, fid, "data_flow_entity", f.get("donnees"), path)
            self.ref(s, fid, "data_flow_feature", f.get("features"), path)
            self.ref(s, fid, "data_flow_flow", f.get("flows"), path)

    def load_flows(self, path, scope, lines, skip):
        """Flows (prompt 5) are prose: a heading that starts with an FL ID defines that flow, and every
        ID its section cites (template blocks aside) is linked to it."""
        found = False
        for first, _, heading, last in md_headings(lines):
            m = FLOW_HEADING_RE.match(heading)
            if not m:
                continue
            fid = m.group(1).upper()
            name = m.group(2).strip(NAME_TRIM) or None
            section = [lines[n - 1] for n in range(first + 1, last + 1) if n not in skip]
            self.define(scope, fid, "flow", path, name, {"nom": name, "texte": "\n".join(section).strip()}, first)
            self.row("flows", scope, fid, name, path, first, last)
            cited = sorted(set(ids_in(section)) - {fid}, key=id_key)
            for kind in sorted({kind_of(c) for c in cited}):
                self.ref(scope, fid, FLOW_RELS.get(kind, "flow_cites"), [c for c in cited if kind_of(c) == kind], path)
            found = True
        if found:
            self.row("sources", path, "markdown", "flows", scope, None)

    def load_contract(self, doc, path, lines):
        s = CANONICAL
        page = text(doc.get("page"))
        self.row("page_contracts", page, text(doc.get("nom")), path)
        self.ref(s, page, "contract_role", doc.get("acces"), path)
        for c in self.items(doc, "composants", path):
            cid = self.define(s, c.get("id"), "component", path, c.get("nom_accessible"), c)
            if not cid:
                continue
            self.row("components", cid, page, text(c.get("nom_accessible")), text(c.get("type")),
                     text(c.get("feature")), path)
            self.row("refs", s, cid, "component_page", page, path)
            self.ref(s, cid, "component_feature", c.get("feature"), path)
            for mode, key in (("read", "lit"), ("write", "ecrit")):
                for col in as_list(c.get(key)):
                    self.row("component_columns", cid, text(col), mode)
                    self.ref(s, cid, "component_table", [x for x in ids_in(col) if kind_of(x) == "table"], path)
            self.ref(s, cid, "component_data_flow", c.get("flux"), path)
            for mode, key in (("visible", "visible_si"), ("enabled", "actif_si")):
                for cond in as_list(c.get(key)):
                    self.row("component_conditions", cid, mode, text(cond))
                    self.ref(s, cid, "component_condition", ids_in(cond), path)
        for n, line in enumerate(lines, 1):
            if "MANQUANT" in line:
                self.row("missing", path, n, line.strip())


# -- commands -----------------------------------------------------------------------------------

def open_db(args):
    db_path = args.root / DB_REL
    fp, fresh = fingerprint(args.root, args.docs), False
    if db_path.exists():
        try:
            con = sqlite3.connect(f"file:{db_path}?mode=ro", uri=True)
            row = con.execute("SELECT value FROM meta WHERE key='fingerprint'").fetchone()
            fresh = row is not None and row[0] == fp
            con.close()
        except sqlite3.Error:
            fresh = False
    if not fresh:
        Builder(args.root, args.docs, db_path, fp).build()
    return read_only(db_path)


def read_only(db_path):
    return prepare(sqlite3.connect(f"file:{db_path}?mode=ro", uri=True))


def prepare(con):
    con.row_factory = sqlite3.Row
    # ORDER BY id COLLATE idnum sorts IDs by number (D-200 before D-1000).
    con.create_collation("idnum", lambda a, b: (id_key(a) > id_key(b)) - (id_key(a) < id_key(b)))
    # idnum(id) is the ID as a number, as defs.number holds it: idnum('D-001') = 'D-1'.
    con.create_function("idnum", 1, lambda s: id_number(s) if s else None, deterministic=True)
    return con


def build_previous(root, docs, rev, tmp):
    """Build the docs as they were at git revision `rev` into tmp/previous.db, for the checks that need: previous."""
    snap = Path(tmp) / "previous"
    snap.mkdir(parents=True)
    git = ["git", "-C", str(root)]
    if subprocess.run([*git, "rev-parse", "--verify", "--quiet", f"{rev}^{{commit}}"], capture_output=True).returncode:
        raise ValueError(f"{rev} is not a commit of this repo")
    present = [d for d in docs if subprocess.run([*git, "cat-file", "-e", f"{rev}:{d}"], capture_output=True).returncode == 0]
    if present:
        tar = subprocess.run([*git, "archive", "--format=tar", rev, *present], capture_output=True, check=True).stdout
        with tarfile.open(fileobj=io.BytesIO(tar)) as t:
            t.extractall(snap, filter="data")
    db_path = Path(tmp) / "previous.db"
    Builder(snap, docs, db_path).build()
    return db_path


def md_table(rows, cols=None, limit=None):
    if not rows:
        return "(no rows)\n"
    cols = cols or list(rows[0].keys())
    out = ["| " + " | ".join(cols) + " |", "|" + " --- |" * len(cols)]
    shown = rows if limit is None else rows[:limit]
    for r in shown:
        out.append("| " + " | ".join("" if r[c] is None else str(r[c]).replace("|", "\\|").replace("\n", " ") for c in cols) + " |")
    if limit is not None and len(rows) > limit:
        out.append(f"\n… and {len(rows) - limit} more rows (add --all to see them)")
    return "\n".join(out) + "\n"


def cmd_build(args):
    meta = Builder(args.root, args.docs, args.root / DB_REL).build()
    con = read_only(args.root / DB_REL)
    print(f"Built {DB_REL} from {', '.join(args.docs)} at commit {meta['commit'] or '-'} (fingerprint {meta['fingerprint']}).")
    rows = con.execute("SELECT scope, kind, COUNT(DISTINCT id) AS n FROM defs GROUP BY scope, kind ORDER BY scope, kind").fetchall()
    print(md_table(rows))
    rows = con.execute("SELECT path, content, scope, note FROM sources WHERE content != 'other' ORDER BY path").fetchall()
    print("Read as data:\n" + md_table(rows))
    probs = con.execute("SELECT path, line, message FROM problems").fetchall()
    if probs:
        print("Problems:\n" + md_table(probs))
        return 1
    return 0


def load_checks():
    """The blocks of checks.sql, each opened by its `-- check:` header."""
    checks = []
    for block in re.split(r"(?m)^(?=--\s*check:)", CHECKS_FILE.read_text(encoding="utf-8")):
        meta, sql = {}, []
        for line in block.splitlines():
            m = re.match(r"--\s*(\w+):\s*(.*)$", line)
            if m and not sql:
                meta[m.group(1)] = m.group(2).strip()
            elif line.strip() and not line.startswith("--"):
                sql.append(line)
        if "check" in meta:
            meta["id"] = meta["check"]
            meta["sql"] = "\n".join(sql).rstrip().rstrip(";")
            checks.append(meta)
    return sorted(checks, key=lambda c: check_order(c["id"]))


def check_order(cid):
    m = re.match(r"([A-Z]+)(\d*)-(\d+)", cid)
    if not m:
        return (9, 0, 0, cid)
    group = {"BUILD": 0, "L": 1, "B": 2, "G": 3}.get(m.group(1), 4)
    layer = int(m.group(2) or 0)
    return (group, -layer if m.group(1) == "B" else layer, int(m.group(3)), cid)


def contents(con):
    return {r[0] for r in con.execute("SELECT DISTINCT content FROM sources")}


def run_checks(con, wanted=None):
    have = contents(con)
    if any(r[1] == "prev" for r in con.execute("PRAGMA database_list")):
        have.add("previous")
    multi = con.execute("SELECT value FROM meta WHERE key='multi_platform'").fetchone()[0] == "1"
    # Flows are written one at a time (prompt 5); step 8 starts once they all exist.
    if "flows" in have and have & {"data_model", "data_flows"}:
        have.add("flows_done")
    results = []
    for c in load_checks():
        if wanted and c["id"] not in wanted:
            continue
        needs = [n.strip() for n in c.get("needs", "").split(",") if n.strip()]
        reason = None
        special = ("multi_platform", "previous", "flows_done")
        for n in needs:
            if n == "multi_platform" and not multi:
                reason = "the app has one platform"
            elif n == "previous" and n not in have:
                reason = "no previous version to compare with: pass --since <git revision>"
            elif n == "flows_done" and n not in have:
                reason = ("no flows in the docs yet" if "flows" not in have else
                          "step 5 is in progress: the flows are complete once the data model or the data flows exist")
            elif n not in special and n not in have:
                reason = f"no {n.replace('_', ' ')} in the docs yet"
        if reason:
            results.append((c, "not reached", reason, []))
            continue
        try:
            rows = con.execute(c["sql"]).fetchall()
        except sqlite3.Error as e:
            results.append((c, "error", str(e), []))
            continue
        if c["id"].startswith("L3-"):
            # An archived registry passed L3 before the merge, by the rules then (L4-01): L3 is canonical only.
            rows = [r for r in rows if not gates_not(r)]
        results.append((c, "findings" if rows else "passed", None, rows))
    return results


def gates_not(row):
    """A row from a frozen per-platform archive is shown but never fails the build."""
    return "scope" in row.keys() and row["scope"] != CANONICAL


def cmd_check(args):
    con = open_db(args)
    meta = dict(con.execute("SELECT key, value FROM meta").fetchall())
    with tempfile.TemporaryDirectory() as tmp:
        if args.since:
            try:
                prev = build_previous(args.root, args.docs, args.since, tmp)
            except (ValueError, subprocess.CalledProcessError) as e:
                print(f"--since {args.since}: {e}", file=sys.stderr)
                return 2
            con.execute("ATTACH DATABASE ? AS prev", (f"file:{prev}?mode=ro",))
        results = run_checks(con, set(args.checks) or None)
        con.close()
    failed = False
    print(f"# Registry checks\n\nDatabase built from the docs at commit {meta.get('commit') or '-'}, "
          f"fingerprint {meta.get('fingerprint')}: it matches the docs as they are now (L0-03 passed).\n")
    if args.since:
        print(f"Compared with the docs at {args.since} for the checks that need the previous version.\n")
    print("| Check | How | Severity | Result |\n| --- | --- | --- | --- |")
    for c, status, reason, rows in results:
        res = {"passed": "passed", "not reached": f"not reached: {reason}", "error": f"error: {reason}"}.get(status, f"{len(rows)} rows")
        archived = sum(1 for r in rows if gates_not(r))
        if archived:
            res += f" ({archived} from archived registries)"
        print(f"| {c['id']} | {c.get('how', '')} | {c.get('severity', '')} | {res} |")
        if status == "error" or (status == "findings" and c.get("how") == "Query" and archived < len(rows)):
            failed = True
    for c, status, reason, rows in results:
        if status != "findings":
            continue
        print(f"\n## {c['id']} · {c.get('severity', '')} · {c.get('title', '')}\n")
        if c.get("how") != "Query":
            print("Each row is a lead to read, not yet a finding.\n")
        print(md_table(rows, limit=None if args.all else args.limit))
    unshipped = [x for x in (args.checks or []) if x not in {c["id"] for c, *_ in results}]
    if unshipped:
        print(f"\nNo query is shipped for {', '.join(unshipped)}: check it by reading.")
    if args.no_fail:
        return 0
    return 1 if failed else 0


def cmd_impact(args):
    con = open_db(args)
    seen = {i: 0 for i in args.ids}
    frontier = list(args.ids)
    depth = 0
    while frontier and (args.depth is None or depth < args.depth):
        depth += 1
        nxt = []
        q = "SELECT DISTINCT target FROM links WHERE source IN (%s)" % ",".join("?" * len(frontier))
        for (t,) in con.execute(q, frontier):
            if t not in seen:
                seen[t] = depth
                nxt.append(t)
        frontier = nxt
    rows = []
    for id_, d in sorted(seen.items(), key=lambda x: (x[1], kind_of(x[0]) or "", id_key(x[0]))):
        r = con.execute("SELECT kind, path, line, name FROM ids WHERE scope='canonical' AND id=?", (id_,)).fetchone()
        rows.append({"depth": d, "id": id_, "kind": r["kind"] if r else kind_of(id_), "name": r["name"] if r else "(not defined)",
                     "where": f"{r['path']}:{r['line'] or ''}" if r else ""})
    print(f"# Impact of {', '.join(args.ids)}\n\nDepth 0 is what you change; depth 1 is linked to it directly, and so on.\n")
    print(md_table(rows, ["depth", "id", "kind", "name", "where"]))
    q = "SELECT path, COUNT(*) AS lines, GROUP_CONCAT(DISTINCT id) AS ids FROM mentions WHERE scope='canonical' AND id IN (%s) GROUP BY path ORDER BY lines DESC" % ",".join("?" * len(seen))
    print("Files that cite them:\n" + md_table(con.execute(q, list(seen)).fetchall()))
    return 0


def cmd_where(args):
    con = open_db(args)
    for id_ in args.ids:
        print(f"## {id_}\n")
        print("Defined in:\n" + md_table(con.execute("SELECT scope, kind, path, line, name FROM defs WHERE id=?", (id_,)).fetchall()))
        print("Linked to:\n" + md_table(con.execute(
            "SELECT scope, rel, target AS id FROM refs WHERE source=? UNION ALL SELECT scope, rel || ' (from)', source FROM refs WHERE target=?",
            (id_, id_)).fetchall()))
        print("Cited on:\n" + md_table(con.execute("SELECT path, GROUP_CONCAT(line) AS lines FROM mentions WHERE id=? GROUP BY path", (id_,)).fetchall()))
    return 0


def cmd_query(args):
    con = open_db(args)
    try:
        rows = con.execute(args.sql).fetchall()
    except sqlite3.Error as e:
        print(f"SQL error: {e}", file=sys.stderr)
        return 2
    print(md_table(rows))
    return 0


def cmd_schema(args):
    con = open_db(args)
    for name, typ in con.execute("SELECT name, type FROM sqlite_master WHERE type IN ('table','view') ORDER BY type, name"):
        cols = [r[1] for r in con.execute(f"PRAGMA table_info({name})")]
        n = con.execute(f"SELECT COUNT(*) FROM {name}").fetchone()[0]
        print(f"{typ} {name}({', '.join(cols)}) · {n} rows")
    return 0


def cmd_diff(args):
    out = {}
    with tempfile.TemporaryDirectory() as tmp:
        for side in ("base", "head"):
            folder = Path(getattr(args, side))
            if not folder.is_absolute():
                folder = args.root / folder
            if not folder.is_dir():
                print(f"{folder} is not a folder", file=sys.stderr)
                return 2
            db_path = Path(tmp) / side / "registry.db"
            Builder(folder.parent, [folder.name], db_path).build()
            con = sqlite3.connect(db_path)
            defs = {}
            for scope, id_, kind, name, data in con.execute("SELECT scope, id, kind, name, data FROM defs"):
                defs[(scope, id_)] = (kind, name, json.loads(data) if data else {})
            refs = set(con.execute("SELECT scope, source, rel, target FROM refs"))
            out[side] = (defs, refs)
            con.close()
        # G-03 on the head, with the base as its previous version: IDs gone without being retired.
        con = prepare(sqlite3.connect(Path(tmp) / "head" / "registry.db"))
        con.execute("ATTACH DATABASE ? AS prev", (str(Path(tmp) / "base" / "registry.db"),))
        (g03, status, reason, gone), = run_checks(con, {"G-03"})
        con.close()
    (bd, br), (hd, hr) = out["base"], out["head"]
    print(f"# Registry diff: {args.base} → {args.head}\n")
    added = sorted(set(hd) - set(bd), key=lambda k: (k[0], id_key(k[1])))
    removed = sorted(set(bd) - set(hd), key=lambda k: (k[0], id_key(k[1])))
    changed = []
    for k in sorted(set(bd) & set(hd)):
        b, h = bd[k][2], hd[k][2]
        keys = sorted(x for x in set(b) | set(h) if b.get(x) != h.get(x))
        if keys:
            changed.append((k, keys))
    def line(k, d):
        return f"- `{k[1]}` ({d[k][0]}, {k[0]}): {d[k][1] or ''}"
    print(f"## Added IDs ({len(added)})\n" + "\n".join(line(k, hd) for k in added) + "\n")
    print(f"## Removed IDs ({len(removed)})\n" + "\n".join(line(k, bd) for k in removed) + "\n")
    print(f"## Changed IDs ({len(changed)})\n" + "\n".join(f"- `{k[1]}` ({k[0]}): {', '.join(keys)}" for k, keys in changed) + "\n")
    la, lr = sorted(hr - br), sorted(br - hr)
    print(f"## Added links ({len(la)})\n" + "\n".join(f"- {s} {src} —{rel}→ {t}" for s, src, rel, t in la) + "\n")
    print(f"## Removed links ({len(lr)})\n" + "\n".join(f"- {s} {src} —{rel}→ {t}" for s, src, rel, t in lr) + "\n")
    if status == "error":
        print(f"G-03 could not run: {reason}", file=sys.stderr)
        return 2
    print(f"## {g03['id']}: removed without being retired ({len(gone)})\n")
    if gone:
        print("An ID is never reused: each one must be listed in the registry's ids_retires with the decision"
              " that retired it, or come back. Ask the owner which.\n")
        print(md_table(gone))
        return 1
    return 0


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--root", type=Path, default=None, help="the app repo (default: the git repo around the current folder)")
    ap.add_argument("--docs", nargs="+", default=DEFAULT_DOCS, help="docs folders, relative to the root (default: docs claude_docs)")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("build")
    c = sub.add_parser("check")
    c.add_argument("checks", nargs="*")
    c.add_argument("--limit", type=int, default=50, help="rows shown per check (default 50)")
    c.add_argument("--all", action="store_true", help="show every row")
    c.add_argument("--no-fail", action="store_true", help="exit 0 even when a check finds rows")
    c.add_argument("--since", metavar="REV", help="git revision of the previous version of the docs, for G-03 (IDs gone without being retired)")
    i = sub.add_parser("impact")
    i.add_argument("ids", nargs="+")
    i.add_argument("--depth", type=int, default=None)
    w = sub.add_parser("where")
    w.add_argument("ids", nargs="+")
    q = sub.add_parser("query")
    q.add_argument("sql")
    sub.add_parser("schema")
    d = sub.add_parser("diff")
    d.add_argument("base")
    d.add_argument("head")
    args = ap.parse_args()
    args.root = (args.root or repo_root()).resolve()
    cmds = {"build": cmd_build, "check": cmd_check, "impact": cmd_impact, "where": cmd_where,
            "query": cmd_query, "schema": cmd_schema, "diff": cmd_diff}
    return cmds[args.cmd](args)


if __name__ == "__main__":
    sys.exit(main())
