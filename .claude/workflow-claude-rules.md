# How to work in this repo (shared by every app)

Copied from workflow_claude by its sync: change it there, never here. The app's `CLAUDE.md` includes it with the line `@.claude/workflow-claude-rules.md`, and adds only what is the app's own: what the app is, its links, where its files are.

## Start of a session

1. In the main checkout, run `git fetch origin main && git merge --ff-only origin/main` first, never `git pull` (an editor's background fetch can rewrite `FETCH_HEAD` under it). Claude Code loads the skills from the checkout a session starts in, so a checkout behind `main` runs old skills.
2. Then work in your own worktree, never in the main checkout: `git fetch && git worktree add .claude/worktrees/<branch> -b <branch> origin/main`, and work only inside it. Worktree commands may need to run outside the sandbox. The app's `.gitignore` lists `.claude/worktrees/`.
3. `workflow_docs/` and the skills listed in `.claude/skills/.workflow_claude` come from workflow_claude: never edit them here. The method starts at `workflow_docs/method.md`; read only the part the task needs.

## How to work

- Product choices are the owner's: anything that changes what the app is or does (the registry, a decision, the design, a rule of a feature). Propose it with your recommendation first, and ask. Everything else (tooling, file layout, wording of a report, the order of the work): decide, act, and say what you did. This rule wins over any older rule or memory that says to apply your own recommendation without asking.
- One fact in one place, with its ID; link to it instead of copying it.
- IDs are never renumbered. An ID is a number: `D-01` and `D-001` are the same ID.
- Repo, code, commits and pull requests are in English. The docs and the app's copy are in the app's language.

## The design and the docs

The repo's `claude_design/` is the design's source of truth, not claude.ai: claude.ai is only where the next version is drafted. When the two differ, the repo is right, and what is only on claude.ai is not part of the design until it is imported and promoted. The docs are the other way round: their source of truth is their Claude Doc. One round of the design cycle (`workflow_docs/method/describe.md`, "The design cycle"):

1. The owner draws on claude.ai.
2. `import-design-and-docs-artifact`, `compare-newest-current-claude-files`, then `promote-newest-claude-files`. When the owner removed or changed on claude.ai what the repo drew, or removed an ID, the comparison asks them whether it was on purpose: never guess, and never promote before they answer.
3. The doc tests (`what-are-the-next-docs-prompts`) list what is missing.
4. Claude draws what is missing in `claude_design/`.
5. `publish-claude-design` sends it back to claude.ai. Never skip it: the next import would undo the drawing, and promotion refuses it.

The docs are edited in their Claude Doc first (one edit call takes at most 64 operations), then imported and promoted. Never edit `claude_docs/` by hand. Before landing a docs change, `python3 .claude/skills/registry-db/registry_db.py check` must exit 0; the CI runs it too.

## Landing a task

1. One branch per task. When it is done, without asking: commit the files by name (never `git add -A`), push, `gh pr create`, then `gh pr checks --watch` and `gh pr view --comments`.
2. Green: `gh pr merge --squash --delete-branch`. Red, or a comment to address: fix it on the branch and check again.
3. After merging: remove your worktree, delete the merged local branches, and `git fetch origin main && git merge --ff-only origin/main` in the main checkout. Then say it in capitals: `PR #12 MERGED INTO MAIN.`

## Messages

Short and clear. Blockers and surprises first. End every task with, skipping the empty parts: **Done** (with links) · **Verified** (what was tested, what was not) · **Needs a decision** (with your recommendation) · **Next steps** (who does what).
