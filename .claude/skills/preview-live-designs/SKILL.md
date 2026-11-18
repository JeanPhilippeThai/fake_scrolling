---
name: preview-live-designs
description: Start a local live preview of the claude_design/ of this project and of every project next to it, each as it is on origin/main, reloading when a branch moves. Use when the user asks to see, preview, open or visualize the design or UI/UX of one or several projects.
---

# Preview the designs of several projects, live

`live_design.py` serves the `claude_design/` of several projects at once:

- http://localhost:8765 lists the projects, with the commit each preview shows.
- Each project is on its own port, 8766 and up in name order, because a design is served as the web root: its pages link to `/_blob/...`.

Files are read straight from git, at `origin/main:claude_design/`, so a preview does not depend on the branch checked out or on uncommitted edits. Each project's `origin/main` is fetched every 10 seconds; when it moves, the open pages of that project reload. A badge at the bottom right of every page names the project and the commit, and links back to the list.

It shows only what is merged on `origin/main`. To look at an import that is not committed, serve `newest_claude_design/` as the `import-design-and-docs-artifact` skill says.

## 1. Choose the projects

With no argument, the projects are every git repo in the folder holding this repo: this one and its neighbours. A repo with no `claude_design/` on `origin/main` is listed, greyed out, and becomes a link as soon as one lands.

Pass paths only when the user names projects or another folder. A path is a git repo, or a folder whose children are git repos.

## 2. Start it

Run it in the background, so it keeps serving after your answer:

```bash
python3 .claude/skills/preview-live-designs/live_design.py [paths...]
```

Options: `--port 8765` (the list; project N is on port + N), `--remote origin`, `--branch main`, `--folder claude_design`, `--interval 10` (seconds between fetches), `--host 127.0.0.1`.

If a port is taken, the script says which one: a preview is probably already running, so give the user its URL instead of starting a second one. Otherwise pass another `--port`.

In a sandbox, a server started by a command is not reachable from the user's browser: start it outside the sandbox and say so, or give the user the command to run in their own terminal.

## 3. Report

Give the user the URL of the list and the lines the script printed, one per project. Say which projects have no design on `origin/main` yet, and any fetch that fails (the list shows it in red: the preview then shows the last commit fetched).
