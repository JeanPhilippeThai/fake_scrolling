#!/usr/bin/env python3
"""Know what claude.ai holds, file by file, so that the design cycle never loses work.

The repo's claude_design/ is the official design and claude.ai is where the next version is
drawn (workflow_docs/method/describe.md, "The design cycle"). Each exchange leaves a stamp: the
hash of every file as claude.ai held it.

- A canvas folder (one with a project/ folder) has <canvas>/.claude-ai.json: its URL and the
  hashes of its project/ files.
- A docs folder has <folder>/.claude-ai.json: the hashes of its files.

    claude_sync.py stamp <folder> [--url <canvas>=<URL> ...]   after an import, or a publish
    claude_sync.py status [<folder> ...]                        repo changes not on claude.ai
    claude_sync.py check-promote                                would promoting lose them?
    claude_sync.py check-remote <canvas dir> <remote dir>       did claude.ai change since?
    claude_sync.py plan <canvas dir>                            the files a publish must send

Each check exits 1 when it finds something, 0 when it is safe.
"""
import argparse
import datetime
import hashlib
import json
import sys
from pathlib import Path

STAMP = ".claude-ai.json"
PAIRS = [("claude_design", "newest_claude_design"), ("claude_docs", "newest_claude_docs")]
GENERATED = {"support.js", "README.md", "INDEX.md", STAMP}


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def is_canvas(path):
    return (path / "project").is_dir()


def units(folder):
    """The units a folder holds: each canvas, or the folder itself for docs."""
    if not folder.is_dir():
        return []
    canvases = sorted(p for p in folder.iterdir() if p.is_dir() and is_canvas(p))
    return canvases or [folder]


def tracked(unit):
    """Path -> hash of the files claude.ai holds for this unit."""
    if is_canvas(unit):
        root = unit / "project"
        return {f"project/{p.relative_to(root)}": digest(p) for p in sorted(root.rglob("*")) if p.is_file()}
    out = {}
    for p in sorted(unit.rglob("*")):
        rel = p.relative_to(unit)
        if p.is_file() and p.name not in GENERATED and "__pycache__" not in rel.parts:
            out[str(rel)] = digest(p)
    return out


def read_stamp(unit):
    path = unit / STAMP
    if not path.is_file():
        return None
    return json.loads(path.read_text(encoding="utf-8"))


def write_stamp(unit, url=None):
    old = read_stamp(unit) or {}
    synced = datetime.datetime.now(datetime.timezone.utc).isoformat(timespec="seconds")
    stamp = {"synced": synced, "files": tracked(unit)}
    if is_canvas(unit):
        stamp = {"url": url or old.get("url"), **stamp}
    (unit / STAMP).write_text(json.dumps(stamp, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    return stamp


def changes(base, now):
    """(changed, added, removed) from one path -> hash map to another."""
    return (sorted(p for p in now if p in base and base[p] != now[p]),
            sorted(p for p in now if p not in base),
            sorted(p for p in base if p not in now))


def show(label, ch):
    changed, added, removed = ch
    for name, paths in (("changed", changed), ("added", added), ("removed", removed)):
        for p in paths:
            print(f"  {name:8} {label}/{p}")


def cmd_stamp(args):
    urls = dict(u.split("=", 1) for u in args.url)
    for unit in units(Path(args.folder)):
        stamp = write_stamp(unit, urls.get(unit.name))
        where = f" ({stamp['url']})" if stamp.get("url") else ""
        print(f"stamped {unit}{where}: {len(stamp['files'])} files")
        if is_canvas(unit) and not stamp.get("url"):
            print(f"  no URL for {unit.name}: pass --url {unit.name}=<canvas URL>")
            return 1
    return 0


def cmd_status(args):
    found = 0
    for folder in args.folders:
        for unit in units(Path(folder)):
            stamp = read_stamp(unit)
            if stamp is None:
                print(f"{unit}: no stamp, so what claude.ai holds is unknown. The next import and promotion write one.")
                found = 1
                continue
            ch = changes(stamp["files"], tracked(unit))
            if any(ch):
                print(f"{unit}: changed in the repo since claude.ai last matched it ({stamp['synced']}):")
                show(unit, ch)
                found = 1
            else:
                print(f"{unit}: same as claude.ai at the last exchange ({stamp['synced']})")
    return found


def cmd_check_promote(args):
    lost = 0
    for current, newest in PAIRS:
        cur, new = Path(current), Path(newest)
        if not new.is_dir() or not any(new.rglob("*")):
            continue  # nothing imported: promotion leaves this folder as it is
        for unit in units(cur):
            twin = new / unit.relative_to(cur) if unit != cur else new
            now = tracked(unit)
            incoming = tracked(twin) if twin.is_dir() else {}
            stamp = read_stamp(unit)
            if stamp is None:
                differing = sum(len(c) for c in changes(incoming, now))
                if differing and not args.first_sync:
                    print(f"{unit}: no stamp, so nobody knows whether its {differing} files that differ from the import"
                          " were changed in the repo. Compare them; if none was, promote with --first-sync.")
                    lost = 1
                continue
            fresh = read_stamp(twin) if twin.is_dir() else None
            if fresh and fresh["synced"] < stamp["synced"] and incoming != now:
                print(f"{unit}: the import ({fresh['synced']}) is older than the last exchange with claude.ai"
                      f" ({stamp['synced']}), a publish most likely. Import again before promoting.")
                lost = 1
                continue
            changed, added, removed = changes(stamp["files"], now)
            at_risk = [p for p in changed + added if incoming.get(p) != now[p]]
            at_risk += [p for p in removed if p in incoming]
            if at_risk:
                print(f"{unit}: promoting would undo {len(at_risk)} repo changes that were never published to claude.ai:")
                for p in at_risk:
                    print(f"  {unit}/{p}")
                lost = 1
    if lost:
        print("\nStop. Design: publish them first (publish-claude-design), then import again. "
              "Docs: make the same change in the Claude Doc, then import again. "
              "If claude.ai changed too, merge the two by hand with the owner.")
    else:
        print("Safe: promoting loses no repo change.")
    return lost


def cmd_check_remote(args):
    unit, remote = Path(args.canvas), Path(args.remote)
    stamp = read_stamp(unit)
    if stamp is None:
        print(f"{unit}: no stamp. Import and promote first, so that the repo knows what claude.ai holds.")
        return 1
    root = remote / "project"
    there = {f"project/{p.relative_to(root)}": digest(p) for p in sorted(root.rglob("*")) if p.is_file()} if root.is_dir() else {}
    ch = changes(stamp["files"], there)
    if any(ch):
        print(f"{unit}: claude.ai changed since the last exchange ({stamp['synced']}). Publishing would overwrite it:")
        show("claude.ai", ch)
        print("Stop. Import and compare it first; if the repo changed too, merge the two by hand with the owner.")
        return 1
    print(f"{unit}: claude.ai still holds what it held at the last exchange ({stamp['synced']}).")
    return 0


def cmd_plan(args):
    unit = Path(args.canvas)
    stamp = read_stamp(unit)
    if stamp is None:
        print(f"{unit}: no stamp", file=sys.stderr)
        return 1
    changed, added, removed = changes(stamp["files"], tracked(unit))
    files = {p: p for p in changed + added}
    files.update({p: None for p in removed})
    print(json.dumps({"url": stamp.get("url"), "root": str(unit), "files": files}, indent=1, ensure_ascii=False))
    return 0


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)
    s = sub.add_parser("stamp")
    s.add_argument("folder")
    s.add_argument("--url", action="append", default=[], help="<canvas folder name>=<canvas URL>")
    st = sub.add_parser("status")
    st.add_argument("folders", nargs="*", default=["claude_design", "claude_docs"])
    cp = sub.add_parser("check-promote")
    cp.add_argument("--first-sync", action="store_true", help="no stamp yet, and the owner confirmed nothing was changed in the repo")
    cr = sub.add_parser("check-remote")
    cr.add_argument("canvas")
    cr.add_argument("remote")
    pl = sub.add_parser("plan")
    pl.add_argument("canvas")
    args = ap.parse_args()
    return {"stamp": cmd_stamp, "status": cmd_status, "check-promote": cmd_check_promote,
            "check-remote": cmd_check_remote, "plan": cmd_plan}[args.cmd](args)


if __name__ == "__main__":
    sys.exit(main())
