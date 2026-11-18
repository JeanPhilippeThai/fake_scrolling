#!/usr/bin/env python3
"""Print what differs between the current and the newest imported design and docs.

Usage: diff_report.py [<repo dir>]   (default: the current directory)

Compares claude_design/ with newest_claude_design/ and claude_docs/ with newest_claude_docs/.
Skips what the import generates (support.js, the runtime, viewer pages, READMEs, INDEX.md),
pretty-prints JSON before diffing (canvas.json is one minified line), drops the
"<!-- Source: ... exported ... -->" line of each doc but reports its rev, and compares
uploaded assets by content only. Prints a file summary, then one unified diff per changed file.
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
        rel.name in {"support.js", "README.md", "INDEX.md"}
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


def compare(repo, current, newest):
    old, new = files(repo / current), files(repo / newest)
    print(f"# {current}/ -> {newest}/")
    if not old:
        print(f"{current}/ is missing or empty: everything in {newest}/ is new.")
    if not new:
        print(f"{newest}/ is missing or empty: run the import skill first.")
    added = sorted(set(new) - set(old))
    removed = sorted(set(old) - set(new))
    diffs = []
    same = 0
    for rel in sorted(set(old) & set(new)):
        a, b = text_lines(old[rel]), text_lines(new[rel])
        if a is None or b is None:
            if digest(old[rel]) != digest(new[rel]):
                diffs.append((rel, None, None))
            else:
                same += 1
            continue
        if a[0] == b[0]:
            same += 1
            continue
        diffs.append((rel, a, b))
    for rel in added:
        print(f"ADDED    {rel}")
    for rel in removed:
        print(f"REMOVED  {rel}")
    for rel, a, b in diffs:
        rev = f"  (rev {a[1]} -> {b[1]})" if a and a[1] != b[1] else ""
        print(f"CHANGED  {rel}{rev}")
    print(f"UNCHANGED {same} files\n")
    for rel, a, b in diffs:
        if a is None:
            print(f"## {rel}: binary content changed\n")
            continue
        out = difflib.unified_diff(a[0], b[0], f"{current}/{rel}", f"{newest}/{rel}", n=2)
        print(f"## {rel}")
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
