# How to work in this repo (shared by every app)

Copied from workflow_claude by its sync: change it there, never here. The app's `CLAUDE.md` includes it with the line `@.claude/workflow-claude-rules.md`, and adds only what is the app's own: what the app is, its links, where its files are.

## Start of a session

1. In the main checkout, run `git pull --ff-only origin main` first (name the branch: a plain `git pull` fails when `main` has no single upstream). Claude Code loads the skills from the checkout a session starts in, so a checkout behind `main` runs old skills.
2. Then work in your own worktree, never in the main checkout: `git fetch && git worktree add .claude/worktrees/<branch> -b <branch> origin/main`, and work only inside it. Worktree commands may need to run outside the sandbox.
3. `workflow_docs/` and the skills listed in `.claude/skills/.workflow_claude` come from workflow_claude: never edit them here. The method starts at `workflow_docs/method.md`; read only the part the task needs.

## How to work

- Product choices are the owner's: propose, with your recommendation first, and ask. Everything else: decide, act, and say what you did.
- One fact in one place, with its ID; link to it instead of copying it.
- IDs are never renumbered. An ID is a number: `D-01` and `D-001` are the same ID.
- Repo, code, commits and pull requests are in English. The docs and the app's copy are in the app's language.

## The design and the docs

The repo's `claude_design/` is the official design; claude.ai is where the next version is drawn. One round of the design cycle (`workflow_docs/method/describe.md`, "The design cycle"):

1. The owner draws on claude.ai.
2. `import-design-and-docs-artifact`, `compare-newest-current-claude-files`, then `promote-newest-claude-files`.
3. The doc tests (`what-are-the-next-docs-prompts`) list what is missing.
4. Claude draws what is missing in `claude_design/`.
5. `publish-claude-design` sends it back to claude.ai. Never skip it: the next import would undo the drawing, and promotion refuses it.

The docs are edited in their Claude Doc first (one edit call takes at most 64 operations), then imported and promoted. Never edit `claude_docs/` by hand. Before landing a docs change, `python3 .claude/skills/registry-db/registry_db.py check` must exit 0; the CI runs it too.

## Landing a task

1. One branch per task. When it is done, without asking: commit the files by name (never `git add -A`), push, `gh pr create`, then `gh pr checks --watch` and `gh pr view --comments`.
2. Green: `gh pr merge --squash --delete-branch`. Red, or a comment to address: fix it on the branch and check again.
3. After merging: remove your worktree, delete the merged local branches, and `git pull --ff-only origin main` in the main checkout. Then say it in capitals: `PR #12 MERGED INTO MAIN.`

## Messages

Short and clear. Blockers and surprises first. End every task with, skipping the empty parts: **Done** (with links) · **Verified** (what was tested, what was not) · **Needs a decision** (with your recommendation) · **Next steps** (who does what).
