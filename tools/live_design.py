#!/usr/bin/env python3
"""Live preview of claude_design/ as it is on origin/main.

    python3 tools/live_design.py          # then open http://localhost:8765

Files are read straight from git (`origin/main:claude_design/...`), so the
preview does not depend on the branch checked out or on uncommitted edits.
origin/main is fetched every few seconds; when it moves, open pages reload.
"""
import argparse
import mimetypes
import posixpath
import subprocess
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import unquote, urlsplit

REPO = Path(__file__).resolve().parent.parent

RELOAD_SNIPPET = """
<script>
(() => {
  const badge = document.createElement('div');
  badge.style.cssText = 'position:fixed;right:8px;bottom:8px;z-index:99999;' +
    'padding:4px 8px;border-radius:6px;background:#1c1c1ccc;color:#fff;' +
    'font:12px system-ui,sans-serif;pointer-events:none';
  document.addEventListener('DOMContentLoaded', () => document.body.append(badge));
  let seen = null;
  async function check() {
    try {
      const rev = await (await fetch('/__rev', {cache: 'no-store'})).json();
      badge.textContent = '%REF% ' + rev.sha.slice(0, 7) + ' - ' + rev.subject +
        (rev.error ? ' (fetch failed: ' + rev.error + ')' : '');
      if (seen && seen !== rev.sha) location.reload();
      seen = rev.sha;
    } catch (e) {
      badge.textContent = 'preview server unreachable';
    }
  }
  check();
  setInterval(check, 2000);
})();
</script>
"""


def git(*args):
    return subprocess.run(
        ["git", "-C", str(REPO), *args], capture_output=True, check=False
    )


class State:
    def __init__(self, remote, branch, folder):
        self.remote, self.branch, self.folder = remote, branch, folder
        self.ref = f"{remote}/{branch}"
        self.error = ""

    def rev(self):
        out = git("log", "-1", "--format=%H%n%s", self.ref).stdout.decode().splitlines()
        sha, subject = (out + ["", ""])[:2]
        return {"sha": sha, "subject": subject, "error": self.error}

    def fetch_forever(self, interval):
        while True:
            result = git("fetch", "--quiet", self.remote, self.branch)
            self.error = (
                "" if result.returncode == 0
                else (result.stderr.decode().strip().splitlines() or ["?"])[-1]
            )
            time.sleep(interval)


class Handler(BaseHTTPRequestHandler):
    state: State

    def do_GET(self):
        path = unquote(urlsplit(self.path).path)
        if path == "/__rev":
            import json
            return self.send(200, "application/json", json.dumps(self.state.rev()).encode())

        rel = posixpath.normpath(path).lstrip("/")
        if rel in ("", "."):
            rel = "index.html"
        elif path.endswith("/"):
            rel += "/index.html"
        if rel.startswith(".."):
            return self.send(404, "text/plain", b"not found")

        blob = git("show", f"{self.state.ref}:{self.state.folder}/{rel}")
        if blob.returncode != 0:
            return self.send(404, "text/plain", f"not on {self.state.ref}: {rel}".encode())

        body = blob.stdout
        ctype = mimetypes.guess_type(rel)[0] or "application/octet-stream"
        # Only top-level page loads get the reload script: artboards fetch their
        # own source, which must stay byte-identical to what is in git.
        if ctype == "text/html" and self.headers.get("Sec-Fetch-Dest") == "document":
            body += RELOAD_SNIPPET.replace("%REF%", self.state.ref).encode()
        self.send(200, ctype, body)

    def send(self, code, ctype, body):
        self.send_response(code)
        self.send_header("Content-Type", ctype + ("; charset=utf-8" if ctype.startswith("text/") else ""))
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):
        pass


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--port", type=int, default=8765)
    parser.add_argument("--remote", default="origin")
    parser.add_argument("--branch", default="main")
    parser.add_argument("--folder", default="claude_design")
    parser.add_argument("--interval", type=float, default=10, help="seconds between fetches")
    args = parser.parse_args()

    state = State(args.remote, args.branch, args.folder)
    Handler.state = state
    threading.Thread(target=state.fetch_forever, args=(args.interval,), daemon=True).start()
    server = ThreadingHTTPServer(("127.0.0.1", args.port), Handler)
    print(f"Live {state.ref}:{args.folder} at http://localhost:{args.port} (Ctrl+C to stop)")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
