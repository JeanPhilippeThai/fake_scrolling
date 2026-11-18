#!/usr/bin/env python3
"""Live preview of the claude_design/ of several projects, as each is on origin/main.

    python3 .claude/skills/preview-live-designs/live_design.py            # every project next to this one
    python3 .claude/skills/preview-live-designs/live_design.py ~/a ~/b    # these projects only

Then open http://localhost:8765: the list of projects, each one a link to its own preview.

A path is a git repo, or a folder whose children are git repos. With no path, the folder
holding this repo is used, so this repo and its neighbours are all previewed at once.

Files are read straight from git (`origin/main:claude_design/...`), so a preview does not
depend on the branch checked out or on uncommitted edits. Each project's origin/main is
fetched every few seconds; when it moves, the open pages of that project reload.

Each project gets its own port (the list's port + 1, + 2, ... in name order) because a
design must be served as the web root: its pages link to `/_blob/...`.
"""
import argparse
import json
import mimetypes
import os
import posixpath
import subprocess
import sys
import threading
import time
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import unquote, urlsplit

GIT_ENV = {**os.environ, "GIT_TERMINAL_PROMPT": "0"}

# Appended to every top-level page of a project: shows which commit is on screen,
# links back to the list, and reloads the page when the commit changes.
RELOAD_SNIPPET = """
<script>
(() => {
  const badge = document.createElement('a');
  badge.href = location.protocol + '//' + location.hostname + ':%HUB_PORT%/';
  badge.title = 'All projects';
  badge.style.cssText = 'position:fixed;right:8px;bottom:8px;z-index:99999;' +
    'padding:4px 8px;border-radius:6px;background:#1c1c1ccc;color:#fff;' +
    'font:12px system-ui,sans-serif;text-decoration:none';
  document.addEventListener('DOMContentLoaded', () => document.body.append(badge));
  let seen = null;
  async function check() {
    try {
      const rev = await (await fetch('/__rev', {cache: 'no-store'})).json();
      badge.textContent = rev.name + ' ' + rev.ref + ' ' + rev.sha.slice(0, 7) + ' - ' +
        rev.subject + (rev.error ? ' (fetch failed: ' + rev.error + ')' : '');
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

HUB_PAGE = """<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Live designs</title>
<style>
:root{--bg:#fafaf8;--fg:#1c1c1c;--muted:#5e5e5b;--line:#8884}
@media (prefers-color-scheme:dark){:root{--bg:#1f1f1e;--fg:#ecebe7;--muted:#a3a29d}}
body{margin:0;padding:24px 16px;background:var(--bg);color:var(--fg);font:16px system-ui,sans-serif}
h1{font-size:22px;margin:0 0 4px} p{color:var(--muted);margin:0 0 16px;font-size:14px}
ul{list-style:none;padding:0;margin:0;max-width:720px}
li{padding:12px 0;border-top:1px solid var(--line)}
a{color:inherit;font-weight:600} .off{color:var(--muted)}
small{display:block;color:var(--muted);font-size:13px;margin-top:2px;overflow-wrap:anywhere}
.err{color:#c0392b}
</style></head><body>
<h1>Live designs</h1>
<p id="sub"></p>
<ul id="list"></ul>
<script>
const list = document.getElementById('list'), sub = document.getElementById('sub');
function el(tag, text, cls) {
  const e = document.createElement(tag);
  if (text) e.textContent = text;
  if (cls) e.className = cls;
  return e;
}
async function check() {
  let projects;
  try {
    projects = await (await fetch('/__projects', {cache: 'no-store'})).json();
  } catch (e) {
    sub.textContent = 'preview server unreachable';
    return;
  }
  sub.textContent = projects.length + ' project(s). Each preview follows its remote branch and reloads when it moves.';
  list.replaceChildren(...projects.map(p => {
    const li = el('li');
    if (p.has_design) {
      const a = el('a', p.name);
      a.href = location.protocol + '//' + location.hostname + ':' + p.port + '/';
      li.append(a);
      li.append(el('small', p.ref + ' ' + p.sha.slice(0, 7) + ' - ' + p.subject));
    } else {
      li.append(el('span', p.name, 'off'));
      li.append(el('small', p.sha ? 'no ' + p.folder + '/ on ' + p.ref : p.ref + ' not found'));
    }
    if (p.error) li.append(el('small', 'fetch failed: ' + p.error, 'err'));
    return li;
  }));
}
check();
setInterval(check, 2000);
</script></body></html>
"""


def git(repo, *args, timeout=None):
    try:
        return subprocess.run(
            ["git", "-C", str(repo), *args],
            capture_output=True, check=False, env=GIT_ENV, timeout=timeout,
        )
    except subprocess.TimeoutExpired:
        return subprocess.CompletedProcess(args, 1, b"", b"timed out")


def repo_root(path):
    """The top folder of the git repo holding `path`, or None."""
    out = git(path, "rev-parse", "--show-toplevel")
    return Path(out.stdout.decode().strip()).resolve() if out.returncode == 0 else None


def find_repos(paths):
    """Each path is a git repo, or a folder whose children are git repos."""
    repos = []
    for path in paths:
        path = Path(path).expanduser().resolve()
        if not path.is_dir():
            sys.exit(f"{path} is not a folder")
        candidates = [path] if repo_root(path) == path else sorted(
            p for p in path.iterdir() if p.is_dir() and not p.name.startswith(".")
        )
        for p in candidates:
            if repo_root(p) == p and p not in repos:
                repos.append(p)
    return repos


class Project:
    def __init__(self, repo, port, remote, branch, folder):
        self.repo, self.name, self.port = repo, repo.name, port
        self.remote, self.branch, self.folder = remote, branch, folder
        self.ref = f"{remote}/{branch}"
        self.error = ""
        self.sha = self.subject = ""
        self.has_design = False
        self.refresh()

    def refresh(self):
        out = git(self.repo, "log", "-1", "--format=%H%n%s", self.ref).stdout.decode().splitlines()
        self.sha, self.subject = (out + ["", ""])[:2]
        self.has_design = bool(self.sha) and git(
            self.repo, "cat-file", "-e", f"{self.ref}:{self.folder}"
        ).returncode == 0

    def status(self):
        return {
            "name": self.name, "port": self.port, "ref": self.ref, "folder": self.folder,
            "sha": self.sha, "subject": self.subject, "error": self.error,
            "has_design": self.has_design,
        }

    def fetch_forever(self, interval):
        while True:
            result = git(self.repo, "fetch", "--quiet", self.remote, self.branch, timeout=60)
            self.error = (
                "" if result.returncode == 0
                else (result.stderr.decode(errors="replace").strip().splitlines() or ["?"])[-1]
            )
            self.refresh()
            time.sleep(interval)


class Handler(BaseHTTPRequestHandler):
    def send(self, code, ctype, body):
        self.send_response(code)
        self.send_header("Content-Type", ctype + ("; charset=utf-8" if ctype.startswith("text/") else ""))
        self.send_header("Content-Length", str(len(body)))
        self.send_header("Cache-Control", "no-store")
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):
        pass


class HubHandler(Handler):
    projects: list

    def do_GET(self):
        path = urlsplit(self.path).path
        if path == "/__projects":
            body = json.dumps([p.status() for p in self.projects]).encode()
            return self.send(200, "application/json", body)
        if path in ("/", "/index.html"):
            return self.send(200, "text/html", HUB_PAGE.encode())
        self.send(404, "text/plain", b"not found")


class ProjectHandler(Handler):
    project: Project
    hub_port: int

    def do_GET(self):
        project = self.project
        path = unquote(urlsplit(self.path).path)
        if path == "/__rev":
            return self.send(200, "application/json", json.dumps(project.status()).encode())

        rel = posixpath.normpath(path).lstrip("/")
        if rel in ("", "."):
            rel = "index.html"
        elif path.endswith("/"):
            rel += "/index.html"
        if rel.startswith(".."):
            return self.send(404, "text/plain", b"not found")

        blob = git(project.repo, "show", f"{project.ref}:{project.folder}/{rel}")
        if blob.returncode != 0:
            return self.send(404, "text/plain", f"not on {project.ref}: {project.folder}/{rel}".encode())

        body = blob.stdout
        ctype = mimetypes.guess_type(rel)[0] or "application/octet-stream"
        # Only top-level page loads get the reload script: artboards fetch their
        # own source, which must stay byte-identical to what is in git.
        if ctype == "text/html" and self.headers.get("Sec-Fetch-Dest") == "document":
            body += RELOAD_SNIPPET.replace("%HUB_PORT%", str(self.hub_port)).encode()
        self.send(200, ctype, body)


def serve(host, port, handler, **attrs):
    try:
        return ThreadingHTTPServer((host, port), type(handler.__name__, (handler,), attrs))
    except OSError as e:
        sys.exit(f"cannot listen on {host}:{port}: {e.strerror}. Stop the other preview, or pass --port.")


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("paths", nargs="*", help="git repos, or folders of git repos (default: the folder holding this repo)")
    parser.add_argument("--port", type=int, default=8765, help="port of the list; project N is on port + N")
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--remote", default="origin")
    parser.add_argument("--branch", default="main")
    parser.add_argument("--folder", default="claude_design")
    parser.add_argument("--interval", type=float, default=10, help="seconds between fetches")
    args = parser.parse_args()

    paths = args.paths
    if not paths:
        here = repo_root(Path(__file__).resolve().parent) or Path.cwd().resolve()
        paths = [here.parent]
    repos = sorted(find_repos(paths), key=lambda p: p.name.lower())
    if not repos:
        sys.exit("no git repo found in: " + " ".join(map(str, paths)))

    projects = [
        Project(repo, args.port + n, args.remote, args.branch, args.folder)
        for n, repo in enumerate(repos, start=1)
    ]
    hub = serve(args.host, args.port, HubHandler, projects=projects)
    for project in projects:
        server = serve(args.host, project.port, ProjectHandler, project=project, hub_port=args.port)
        threading.Thread(target=server.serve_forever, daemon=True).start()
        threading.Thread(target=project.fetch_forever, args=(args.interval,), daemon=True).start()

    print(f"Live designs at http://localhost:{args.port} (Ctrl+C to stop)")
    for project in projects:
        state = "" if project.has_design else f"  (no {project.folder}/ on {project.ref} yet)"
        print(f"  {project.name}: http://localhost:{project.port}{state}")
    sys.stdout.flush()
    try:
        hub.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
