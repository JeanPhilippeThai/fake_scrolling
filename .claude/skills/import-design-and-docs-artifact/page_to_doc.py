#!/usr/bin/env python3
"""Turn a plain HTML artifact page into a doc file for LLMs.

Usage: page_to_doc.py <page.html> <out path without extension>

A page that keeps its content as YAML in a <pre> or <script> block (one whose id, class,
type or data-lang mentions "yaml" or "yml") is saved as <out>.yaml: that block, unescaped,
byte for byte. With several such blocks, the longest is kept.
Any other page is saved as <out>.md: its visible text, with headings, list items and <pre>
blocks kept.
Prints the path written.
"""
import re
import sys
from html.parser import HTMLParser
from pathlib import Path

YAML_HINT = re.compile(r"ya?ml", re.I)
HINT_ATTRS = ("id", "class", "type", "data-lang", "data-language")
HIDDEN = {"script", "style", "template", "noscript", "svg", "head"}
BLOCKS = {"p", "div", "section", "article", "header", "footer", "main", "nav", "aside", "ul", "ol",
          "table", "tr", "blockquote", "figure", "figcaption", "details", "summary", "dl", "dt", "dd"}
HEADINGS = {"h1": "# ", "h2": "## ", "h3": "### ", "h4": "#### ", "h5": "##### ", "h6": "###### "}


class Page(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.yaml_blocks = []
        self.title = ""
        self.out = []
        self._yaml = None  # (tag, depth, chunks) while inside a YAML block
        self._hidden = 0
        self._pre = 0
        self._in_title = False

    def handle_starttag(self, tag, attrs):
        if self._yaml:
            if tag == self._yaml[0]:
                self._yaml[1] += 1
            return
        if tag in ("pre", "script"):
            hints = " ".join(v or "" for k, v in attrs if k in HINT_ATTRS)
            if YAML_HINT.search(hints):
                self._yaml = [tag, 1, []]
                return
        if tag == "title":
            self._in_title = True
        if tag in HIDDEN:
            self._hidden += 1
            return
        if self._hidden:
            return
        if tag == "pre":
            self._pre += 1
            self.out.append("\n\n```\n")
        elif tag in HEADINGS:
            self.out.append("\n\n" + HEADINGS[tag])
        elif tag == "li":
            self.out.append("\n- ")
        elif tag == "br":
            self.out.append("\n")
        elif tag in ("td", "th"):
            self.out.append(" | ")
        elif tag in BLOCKS:
            self.out.append("\n\n")

    def handle_endtag(self, tag):
        if self._yaml:
            if tag == self._yaml[0]:
                self._yaml[1] -= 1
                if self._yaml[1] == 0:
                    self.yaml_blocks.append("".join(self._yaml[2]))
                    self._yaml = None
            return
        if tag == "title":
            self._in_title = False
        if tag in HIDDEN:
            self._hidden = max(0, self._hidden - 1)
            return
        if self._hidden:
            return
        if tag == "pre" and self._pre:
            self._pre -= 1
            self.out.append("\n```\n\n")
        elif tag in HEADINGS or tag in BLOCKS:
            self.out.append("\n\n")

    def handle_data(self, data):
        if self._yaml:
            self._yaml[2].append(data)
        elif self._in_title:
            self.title += data
        elif not self._hidden:
            self.out.append(data if self._pre else re.sub(r"\s+", " ", data))


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    src, stem = Path(sys.argv[1]), sys.argv[2]
    page = Page()
    page.feed(src.read_text(encoding="utf-8"))
    page.close()
    blocks = [b for b in page.yaml_blocks if b.strip()]
    if blocks:
        out = Path(stem + ".yaml")
        text = max(blocks, key=len).strip("\n") + "\n"
        if len(blocks) > 1:
            print(f"note: {len(blocks)} YAML blocks in the page, kept the longest", file=sys.stderr)
    else:
        out = Path(stem + ".md")
        body = "".join(page.out)
        body = re.sub(r"[ \t]+\n", "\n", body)
        body = re.sub(r"\n[ \t]+(?=[^\n])", "\n", body) if "```" not in body else body
        body = re.sub(r"\n{3,}", "\n\n", body).strip()
        title = page.title.strip()
        text = (f"# {title}\n\n" if title and not body.startswith("# ") else "") + body + "\n"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(text, encoding="utf-8")
    print(out)


if __name__ == "__main__":
    main()
