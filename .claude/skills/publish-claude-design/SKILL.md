---
name: publish-claude-design
description: Publish the repo's design (./claude_design) back to its Claude Design canvases on claude.ai, so that the next round of drawing starts from the checked version - step 5 of the method's design cycle. Refuses when claude.ai changed since the last import. Use when the user asks to publish, push or send the design back to claude.ai, and after Claude has drawn screens in the repo.
---

# Publish the repo's design to claude.ai

The repo's `claude_design/` is the official design: the method has checked it, and Claude draws in it what was missing. claude.ai is where the next version is drawn. This skill is step 5 of the design cycle (`workflow_docs/method/describe.md`, "The design cycle"): it sends the repo's version back to claude.ai, so that nothing drawn in the repo is lost at the next import.

Docs are not published: a doc is always edited in its Claude Doc first, then imported. A changed file under `claude_docs/` is a mistake to redo in the Claude Doc.

Script: `python3 .claude/skills/publish-claude-design/claude_sync.py`. Each canvas folder holds `.claude-ai.json`, written by the import: the canvas URL and the hash of every `project/` file as claude.ai held it.

## 1. What changed in the repo

`claude_sync.py status claude_design`

- A canvas "same as claude.ai" needs nothing.
- A canvas with no stamp has never been imported with this skill's stamps: import it and promote it first.
- Changed, added or removed files are what this skill publishes. Show them to the user in a few lines.

Publish from the branch that changed the design, right before landing it, so that the new stamps land in the same pull request.

## 2. Check that claude.ai did not change since

For each canvas to publish, with `<url>` from its `.claude-ai.json`:

1. `Artifact(action: "list", scope: "files", url: "<url>")`. Keep the paths under `project/`.
2. `Artifact(action: "read", url: "<url>", paths: [those paths], out_dir: "$TMPDIR/remote/<canvas>")`. Do not Read them back.
3. `claude_sync.py check-remote claude_design/<canvas> $TMPDIR/remote/<canvas>`

If it reports a change, someone drew on claude.ai since the last import, and publishing would overwrite it. Stop and tell the user what changed on each side: the drawing on claude.ai has to be imported and merged with the repo's changes by hand, with them.

## 3. Publish

1. `claude_sync.py plan claude_design/<canvas> --stage <scratchpad>/stage/<canvas>`, `<scratchpad>` being the session's scratchpad directory (the Artifact tool publishes only from it or from the working directory). It copies the changed and added files into the stage in claude.ai's form: without the viewer's `support.js`, and with each `/_blob/<id>.<ext>` link back to `/_blob/<id>`, as claude.ai writes it. It prints the `url`, the `root` (the stage) and the `files` map: each changed or added file mapped to itself, each removed file to `null`. Never publish from `claude_design/` itself: its files are wired for the local viewer.
2. A file that points to a new uploaded image (`/_blob/<id>` that claude.ai does not hold) needs that image uploaded first: `Artifact(action: "publish", url, asset: true, file_path: "claude_design/_blob/<id>")`, then the file's reference replaced by the URL it returns. If unsure, ask.
3. `Artifact(action: "publish", url: "<url>", root: "<root>", files: <files>)`. If it is refused because claude.ai changed, go back to step 2. Never pass `force`.

## 4. Record it

1. `claude_sync.py stamp claude_design/<canvas>`: the stamp now says that claude.ai holds the repo's version.
2. Check it: read the published paths again into `$TMPDIR/after/<canvas>` as in step 2, and `claude_sync.py check-remote claude_design/<canvas> $TMPDIR/after/<canvas>` must report no change.
3. Commit the `.claude-ai.json` files with the design change.

## 5. Report

Two or three lines: the canvases published, how many files each, and the link to each canvas. Say that the next drawing on claude.ai starts from this version.
