#!/usr/bin/env python3
"""Make downloaded Design canvases viewable offline.

Usage:
  build_viewer.py <design_dir> --missing-blobs   print the /_blob/ ids still to download, one per line
  build_viewer.py <design_dir>                   wire the canvases and write the viewer pages

<design_dir> holds one folder per canvas, each a copy of the canvas's published files:
  <design_dir>/<canvas>/project/canvas.json, <canvas>/project/*.dc.html,
  <canvas>/artifact-type/dc-runtime.js
and the uploaded assets, shared by all canvases, saved by id: <design_dir>/_blob/<id>.<ext>

The build copies dc-runtime.js as support.js next to every .dc.html (the artboards load
./support.js), points /_blob/<id> at the saved file, and writes <canvas>/index.html (the
artboards laid out as on the canvas, each one live) and <design_dir>/index.html (the list).
Serve <design_dir> as the web root: the artboards fetch themselves and /_blob/ is absolute.
"""
import html
import json
import re
import shutil
import sys
from pathlib import Path

BLOB = re.compile(r"/_blob/([0-9a-f]{32})(?![0-9a-f.])")


def canvases(root):
    return sorted(p.parent.parent for p in root.glob("*/project/canvas.json"))


def artboard_files(canvas):
    return sorted((canvas / "project").rglob("*.dc.html"))


def missing_blobs(root):
    have = {p.name.split(".")[0] for p in (root / "_blob").glob("*")}
    wanted = set()
    for canvas in canvases(root):
        for f in artboard_files(canvas):
            wanted.update(BLOB.findall(f.read_text(encoding="utf-8")))
        for f in (canvas / "project").rglob("*.css"):
            wanted.update(BLOB.findall(f.read_text(encoding="utf-8")))
    return sorted(wanted - have)


def wire(root, canvas):
    runtime = canvas / "artifact-type" / "dc-runtime.js"
    if not runtime.exists():
        sys.exit(f"{runtime} is missing: download artifact-type/dc-runtime.js first")
    blobs = {p.name.split(".")[0]: p.name for p in (root / "_blob").glob("*")}
    dirs = set()
    for f in artboard_files(canvas):
        dirs.add(f.parent)
        text = f.read_text(encoding="utf-8")
        new = BLOB.sub(lambda m: "/_blob/" + blobs.get(m.group(1), m.group(1)), text)
        if new != text:
            f.write_text(new, encoding="utf-8")
    for d in dirs:
        shutil.copyfile(runtime, d / "support.js")


def canvas_page(canvas):
    index = json.loads((canvas / "project" / "canvas.json").read_text(encoding="utf-8"))
    boards = index.get("boards", {})
    order = [b for b in index.get("order", []) if b in boards] + sorted(
        b for b in boards if b not in index.get("order", [])
    )
    pages = index.get("pages") or [{"id": None, "name": ""}]
    first_page = pages[0]["id"]
    notes = {k: n for k, n in index.get("notes", {}).items() if n.get("kind") == "title1"}

    sections = []
    for page in pages:
        pid = page["id"]
        on_page = [b for b in order if boards[b].get("page", first_page) == pid]
        page_notes = [n for n in notes.values() if n.get("page", first_page) == pid]
        if not on_page:
            continue
        xs = [boards[b]["x"] for b in on_page] + [n["x"] for n in page_notes]
        ys = [boards[b]["y"] - 40 for b in on_page] + [n["y"] for n in page_notes]
        x0, y0 = min(xs), min(ys)
        width = max(boards[b]["x"] + boards[b]["w"] for b in on_page) - x0
        height = max(boards[b]["y"] + boards[b]["h"] for b in on_page) - y0
        items = []
        for n in page_notes:
            items.append(
                f'<div class="note" style="left:{n["x"] - x0}px;top:{n["y"] - y0}px;'
                f'max-width:{n.get("maxW", 2000)}px">{html.escape(n["text"])}</div>'
            )
        for b in on_page:
            e = boards[b]
            src = "project/" + b
            title = html.escape(e.get("title") or b)
            items.append(
                f'<a class="name" href="{html.escape(src)}" target="_blank" '
                f'style="left:{e["x"] - x0}px;top:{e["y"] - y0 - 32}px">{title} ↗</a>'
                f'<iframe src="{html.escape(src)}" title="{title}" loading="lazy" '
                f'style="left:{e["x"] - x0}px;top:{e["y"] - y0}px;width:{e["w"]}px;'
                f'height:{e["h"]}px;border-radius:{e.get("radius", 0)}px"></iframe>'
            )
        heading = f"<h2>{html.escape(page['name'])}</h2>" if page["name"] else ""
        sections.append(
            f'{heading}<div class="frame" data-w="{width}" data-h="{height}">'
            f'<div class="board" style="width:{width}px;height:{height}px">{"".join(items)}</div></div>'
        )

    title = html.escape(index.get("title") or canvas.name)
    return f"""<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>{title}</title>
<style>
:root{{--bg:#ecebe7;--fg:#1c1c1c;--muted:#5e5e5b}}
@media (prefers-color-scheme:dark){{:root{{--bg:#1f1f1e;--fg:#ecebe7;--muted:#a3a29d}}}}
body{{margin:0;background:var(--bg);color:var(--fg);font:14px system-ui,sans-serif}}
header{{position:sticky;top:0;z-index:2;display:flex;gap:16px;align-items:center;flex-wrap:wrap;padding:10px 16px;background:var(--bg);border-bottom:1px solid #8884}}
header h1{{font-size:16px;margin:0}} header a{{color:inherit}}
h2{{font-size:15px;margin:24px 16px 8px}}
.frame{{overflow:hidden;margin:16px}}
.board{{position:relative;transform-origin:0 0}}
.board iframe{{position:absolute;border:0;background:#fff;box-shadow:0 1px 4px #0003}}
.name{{position:absolute;color:var(--muted);font-size:20px;text-decoration:none;white-space:nowrap}}
.note{{position:absolute;font-size:72px;font-weight:700;line-height:1.1}}
</style></head><body>
<header><a href="../index.html">← All designs</a><h1>{title}</h1>
<label>Zoom <select id="zoom"><option value="fit">Fit width</option><option>0.25</option><option>0.5</option><option>0.75</option><option>1</option></select></label>
<span style="color:var(--muted)">Each artboard is live: click, type, follow its links. A name opens it alone.</span></header>
{"".join(sections)}
<script>
const zoom = document.getElementById("zoom");
function apply() {{
  for (const f of document.querySelectorAll(".frame")) {{
    const w = +f.dataset.w, h = +f.dataset.h;
    const s = zoom.value === "fit" ? Math.min(1, (innerWidth - 32) / w) : +zoom.value;
    f.firstElementChild.style.transform = `scale(${{s}})`;
    f.style.width = w * s + "px"; f.style.height = h * s + "px";
  }}
}}
zoom.onchange = apply; addEventListener("resize", apply); apply();
</script></body></html>
"""


def root_page(root, found):
    rows = []
    for canvas in found:
        index = json.loads((canvas / "project" / "canvas.json").read_text(encoding="utf-8"))
        name = html.escape(index.get("title") or canvas.name)
        rows.append(
            f'<li><a href="{html.escape(canvas.name)}/index.html">{name}</a> '
            f'<span>{len(index.get("boards", {}))} artboards</span></li>'
        )
    return f"""<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Designs</title>
<style>
:root{{--bg:#fafaf8;--fg:#1c1c1c;--muted:#5e5e5b}}
@media (prefers-color-scheme:dark){{:root{{--bg:#1f1f1e;--fg:#ecebe7;--muted:#a3a29d}}}}
body{{margin:0;padding:24px 16px;background:var(--bg);color:var(--fg);font:16px system-ui,sans-serif}}
a{{color:inherit}} li{{margin:8px 0}} span{{color:var(--muted);font-size:14px}}
</style></head><body><h1>Designs</h1><ul>{"".join(rows)}</ul></body></html>
"""


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    root = Path(sys.argv[1])
    if "--missing-blobs" in sys.argv[2:]:
        print("\n".join(missing_blobs(root)))
        return
    found = canvases(root)
    if not found:
        sys.exit(f"no <canvas>/project/canvas.json under {root}")
    (root / "_blob").mkdir(exist_ok=True)
    for canvas in found:
        wire(root, canvas)
        (canvas / "index.html").write_text(canvas_page(canvas), encoding="utf-8")
    (root / "index.html").write_text(root_page(root, found), encoding="utf-8")
    left = missing_blobs(root)
    print(f"{len(found)} canvas(es) built in {root}")
    if left:
        print("assets still missing: " + " ".join(left))


if __name__ == "__main__":
    main()
