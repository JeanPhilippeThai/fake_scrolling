#!/usr/bin/env python3
"""Write the file a Claude Docs export returned, from the tool result the client saved to disk.

Usage: decode_export.py <saved tool result> <out file>

The saved result may be the export's JSON itself, or a list of content blocks whose text holds
that JSON. The script finds `data.bytes_b64` wherever it is, decodes it, writes <out>, and prints
the byte count to compare with `data.bytes`. Needs only python3 (no jq).
"""
import base64
import json
import sys


def find(node):
    """The first mapping that holds `bytes_b64`, searching nested values and JSON strings."""
    if isinstance(node, dict):
        if isinstance(node.get("bytes_b64"), str):
            return node
        for value in node.values():
            hit = find(value)
            if hit:
                return hit
    elif isinstance(node, list):
        for value in node:
            hit = find(value)
            if hit:
                return hit
    elif isinstance(node, str) and "bytes_b64" in node:
        start = node.find("{")
        if start >= 0:
            try:
                return find(json.loads(node[start:]))
            except ValueError:
                return None
    return None


def main():
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    with open(sys.argv[1], encoding="utf-8") as f:
        raw = f.read()
    try:
        tree = json.loads(raw)
    except ValueError:
        tree = raw
    data = find(tree)
    if not data:
        sys.exit(f"no bytes_b64 found in {sys.argv[1]}")
    content = base64.b64decode(data["bytes_b64"])
    with open(sys.argv[2], "wb") as f:
        f.write(content)
    expected = data.get("bytes")
    print(f"wrote {len(content)} bytes to {sys.argv[2]}" + (f" (export says {expected})" if expected is not None else ""))
    if expected is not None and expected != len(content):
        sys.exit("size mismatch: export again")


if __name__ == "__main__":
    main()
