---
name: promote-newest-claude-files
description: Make the newest import the current version - replace ./claude_design and ./claude_docs with ./newest_claude_design and ./newest_claude_docs. Use when the user asks to promote, adopt or accept the newest design or docs, usually after compare-newest-current-claude-files.
---

# Promote the newest design and docs to current

- Newest: `./newest_claude_design/` and `./newest_claude_docs/`, written by the `import-design-and-docs-artifact` skill.
- Current: `./claude_design/` and `./claude_docs/`, what the app is built from and what the doc tests read.

The current folders have exactly the layout of the newest ones, described in the import skill: `compare-newest-current-claude-files` matches files by path, so another layout makes it report every file as removed and added again. Only this skill replaces a current folder. Between two promotions, Claude may draw in `claude_design/` (step 4 of the method's design cycle), and `publish-claude-design` sends those changes to claude.ai before the next import. `claude_docs/` is never edited here: a doc is edited in its Claude Doc, then imported.

Run this only when the user asks for it: it replaces what the app is built from.

## 1. Check

1. A newest folder that is missing or empty is left out: its current folder stays as it is. If both are, say that the import has not run, and stop.
2. `git status --porcelain -- claude_design claude_docs`. If it lists changes that are not committed, they would be lost: show them and ask the user before going on.
3. `python3 .claude/skills/publish-claude-design/claude_sync.py check-promote`. It compares each current folder with what claude.ai held at the last exchange (its `.claude-ai.json`), and refuses when the promotion would undo a repo change that never reached claude.ai. If it refuses, stop and show its list:
   - a design change: publish it first with `publish-claude-design`, then import again;
   - a doc change: make it in the Claude Doc, then import again;
   - if claude.ai changed too, both sides have to be merged by hand with the user.
   A current folder with no stamp yet (before its first stamped import) is refused when it differs from the import. Read the comparison: if none of the differences was made in the repo, run it again with `--first-sync`.
4. Nothing undone without an answer:
   - `python3 .claude/skills/registry-db/registry_db.py diff claude_docs newest_claude_docs > /dev/null` (only when both folders exist) must exit 0. Exit 1 means an ID was removed without being listed in `ids_retires`: stop, and run `compare-newest-current-claude-files`, which asks the owner about it.
   - `python3 .claude/skills/publish-claude-design/claude_sync.py undone`: each item it lists needs the owner's answer in `claude_skills_output/compare_newest_current_claude_files.md` ("Needs your answer"). An item marked "on purpose" must have its decision in the import. If one has no answer, stop and run the comparison first.
5. `python3 .claude/skills/compare-newest-current-claude-files/diff_report.py | grep -E '^(# |ADDED|REMOVED|MOVED|CHANGED|UNCHANGED)'` and show the user the result in a few lines: what is about to change.
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
