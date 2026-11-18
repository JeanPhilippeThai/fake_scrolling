---
name: promote-newest-claude-files
description: Make the newest import the current version - replace ./claude_design and ./claude_docs with ./newest_claude_design and ./newest_claude_docs. Use when the user asks to promote, adopt or accept the newest design or docs, usually after compare-newest-current-claude-files.
---

# Promote the newest design and docs to current

- Newest: `./newest_claude_design/` and `./newest_claude_docs/`, written by the `import-design-and-docs-artifact` skill.
- Current: `./claude_design/` and `./claude_docs/`, what the app is built from and what the doc tests read.

The current folders have exactly the layout of the newest ones, described in the import skill: a current folder is only ever a copy of an import, made by this skill. Never fill or edit one by hand: `compare-newest-current-claude-files` matches files by path, so another layout makes it report every file as removed and added again.

Run this only when the user asks for it: it replaces what the app is built from.

## 1. Check

1. A newest folder that is missing or empty is left out: its current folder stays as it is. If both are, say that the import has not run, and stop.
2. `git status --porcelain -- claude_design claude_docs`. If it lists changes that are not committed, they would be lost: show them and ask the user before going on.
3. `python3 .claude/skills/compare-newest-current-claude-files/diff_report.py | grep -E '^(# |ADDED|REMOVED|CHANGED|UNCHANGED)'` and show the user the result in a few lines: what is about to change.
   If a current folder exists in another layout (most files REMOVED and ADDED under other paths), say so: the replacement fixes it.

## 2. Replace

For each pair whose newest folder holds files:

```bash
rm -rf claude_design && cp -R newest_claude_design claude_design
rm -rf claude_docs && cp -R newest_claude_docs claude_docs
```

Keep the `newest_` folders: the next import rebuilds them.

## 3. Verify

Run the `diff_report.py` command of step 1 again. For each promoted pair it must list no ADDED, REMOVED or CHANGED file. If it lists one, copy again.

## 4. Report

Answer in two or three lines: which folders were replaced, how many files changed, and that the `README.md` and `INDEX.md` inside the current folders now describe them.
Do not commit: the user decides when the new current version is committed.
