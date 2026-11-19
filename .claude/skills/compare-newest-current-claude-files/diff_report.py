#!/usr/bin/env python3
"""Print what differs between the current and the newest imported design and docs.

Usage: diff_report.py [<repo dir>]   (default: the current directory)

Compares claude_design/ with newest_claude_design/ and claude_docs/ with newest_claude_docs/.
Skips what the import generates (support.js, the runtime, viewer pages, READMEs, INDEX.md),
pretty-prints JSON before diffing (canvas.json is one minified line), drops the
"<!-- Source: ... exported ... -->" line of each doc but reports its rev, and compares
uploaded assets by content only. A removed and an added file imported from the same source (its
source line, its INDEX.md URL, or the same content) are one MOVED file. Prints a file summary,
then one unified diff per changed file, moved ones included.
"""
import difflib
import hashlib
import json
import re
import sys
from pathlib import Path

PAIRS = [("claude_design", "newest_claude_design"), ("claude_docs", "newest_claude_docs")]
MAX_NEW_LINES = 300
SOURCE = re.compile(r"^<!-- Source: (.*?), rev (\S+), exported \S+ -->\n?")


def skipped(rel):
    parts = rel.parts
    return (
        rel.name in {"support.js", "README.md", "INDEX.md", ".claude-ai.json"}
        or "artifact-type" in parts
        or (rel.name == "index.html" and len(parts) <= 2)
        or "__pycache__" in parts
    )


def files(root):
    if not root.is_dir():
        return {}
    return {p.relative_to(root): p for p in root.rglob("*") if p.is_file() and not skipped(p.relative_to(root))}


def text_lines(path):
    if path.parts and "_blob" in path.parts:
        return None
    try:
        text = path.read_text(encoding="utf-8")
    except UnicodeDecodeError:
        return None
    rev = None
    m = SOURCE.match(text)
    if m:
        rev = m.group(2)
        text = text[m.end():]
    if path.suffix == ".json":
        try:
            text = json.dumps(json.loads(text), indent=1, ensure_ascii=False, sort_keys=True) + "\n"
        except ValueError:
            pass
    return text.splitlines(keepends=True), rev


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


URL = re.compile(r"https://claude\.ai/[^\s|)`,]+")


def index_sources(root):
    """Path -> source URL, read from the INDEX.md the import writes: a page has no source line."""
    out = {}
    idx = root / "INDEX.md"
    if idx.is_file():
        for line in idx.read_text(encoding="utf-8").splitlines():
            paths, urls = re.findall(r"`([^`]+)`", line), URL.findall(line)
            if len(paths) == 1 and len(urls) == 1:
                out[Path(paths[0])] = urls[0]
    return out


def source_key(path, rel, index):
    """What a file was imported from: its source line (URL and tab), else its INDEX.md URL,
    else its content, so that a file whose name changed is found again."""
    try:
        first = path.read_text(encoding="utf-8").split("\n", 1)[0] + "\n"
    except UnicodeDecodeError:
        first = ""
    m = SOURCE.match(first)
    if m:
        return ("source", m.group(1))
    if rel in index:
        return ("source", index[rel])
    return ("content", digest(path))


def find_moves(repo, current, newest, old, new, removed, added):
    """Pairs a removed and an added file imported from the same source: the file was renamed."""
    keys_old = {}
    idx = index_sources(repo / current)
    for rel in removed:
        keys_old.setdefault(source_key(old[rel], rel, idx), []).append(rel)
    keys_new = {}
    idx = index_sources(repo / newest)
    for rel in added:
        keys_new.setdefault(source_key(new[rel], rel, idx), []).append(rel)
    return sorted((keys_old[k][0], keys_new[k][0]) for k in keys_old
                  if len(keys_old[k]) == 1 and len(keys_new.get(k, [])) == 1)


def compare(repo, current, newest):
    old, new = files(repo / current), files(repo / newest)
    print(f"# {current}/ -> {newest}/")
    if not old:
        print(f"{current}/ is missing or empty: everything in {newest}/ is new.")
    if not new:
        print(f"{newest}/ is missing or empty: run the import skill first.")
    added = sorted(set(new) - set(old))
    removed = sorted(set(old) - set(new))
    moves = find_moves(repo, current, newest, old, new, removed, added)
    added = [r for r in added if r not in {n for _, n in moves}]
    removed = [r for r in removed if r not in {o for o, _ in moves}]
    diffs = []  # (old path, new path, old lines, new lines); lines None for binary content
    same = 0
    moved_same = set()
    for o, n in [(rel, rel) for rel in sorted(set(old) & set(new))] + moves:
        a, b = text_lines(old[o]), text_lines(new[n])
        if a is None or b is None:
            if digest(old[o]) != digest(new[n]):
                diffs.append((o, n, None, None))
            elif o == n:
                same += 1
            else:
                moved_same.add(o)
            continue
        if a[0] == b[0]:
            if o == n:
                same += 1
            else:
                moved_same.add(o)
            continue
        diffs.append((o, n, a, b))
    for rel in added:
        print(f"ADDED    {rel}")
    for rel in removed:
        print(f"REMOVED  {rel}")
    for o, n in moves:
        print(f"MOVED    {o} -> {n}" + ("  (content unchanged)" if o in moved_same else "  (content changed, diff below)"))
    for o, n, a, b in diffs:
        if o != n:
            continue
        rev = f"  (rev {a[1]} -> {b[1]})" if a and a[1] != b[1] else ""
        print(f"CHANGED  {o}{rev}")
    print(f"UNCHANGED {same} files\n")
    for o, n, a, b in diffs:
        name = o if o == n else f"{o} -> {n}"
        if a is None:
            print(f"## {name}: binary content changed\n")
            continue
        rev = f" (rev {a[1]} -> {b[1]})" if a[1] != b[1] else ""
        out = difflib.unified_diff(a[0], b[0], f"{current}/{o}", f"{newest}/{n}", n=2)
        print(f"## {name}{rev}")
        sys.stdout.writelines(out)
        print()
    if not old:
        return  # all new: the summary is the report, read the files themselves if needed
    for rel in added:
        t = text_lines(new[rel])
        if t:
            print(f"## {rel}: new file, {len(t[0])} lines")
            sys.stdout.writelines(t[0][:MAX_NEW_LINES])
            if len(t[0]) > MAX_NEW_LINES:
                print(f"... {len(t[0]) - MAX_NEW_LINES} more lines in {newest}/{rel}")
            print()


def main():
    repo = Path(sys.argv[1] if len(sys.argv) > 1 else ".")
    for current, newest in PAIRS:
        compare(repo, current, newest)


if __name__ == "__main__":
    main()
