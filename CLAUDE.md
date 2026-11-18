# CLAUDE.md

Fake scrolling: a mobile social-feed app, specified with the method in [workflow_docs/method.md](workflow_docs/method.md). No app code yet: the work is on the design and the docs. Docs are in French; code, commits and PRs in English.

## Where things are
- `claude_design/`: the Claude Design mock-up. View it with the `preview-live-designs` skill.
- `claude_docs/`: the docs. Read `INDEX.md` first. Decisions (D-xxx) and features (F-xxx) live in `registre-canonique.yaml`.
- `claude_skills_output/`: skill reports. `what_are_the_next_docs_prompts_output.md` says what to do next.
- `newest_claude_*/`: gitignored scratch imports from claude.ai.
- `workflow_docs/` and the skills listed in `.claude/skills/.workflow_claude` are synced from `workflow_claude`: don't edit them here.

## Rules
- The repo registry is ahead of claude.ai. Never promote imported docs that would drop repo-only D/F IDs.
- One fact in one place, with an ID; link to it instead of copying it.

## Git workflow
- Work in a worktree, never in the main checkout: `git fetch && git worktree add .claude/worktrees/<branch> -b <branch> origin/main`, then work only inside it.
- One branch per task. Keep `main` linear: rebase on `origin/main`, squash-merge.
- When done, without asking: commit, push, `gh pr create`, then `gh pr checks --watch` and `gh pr view --comments`. Green: `gh pr merge --squash --delete-branch`. Not green: fix on the branch and check again.
- After merging: `git worktree remove .claude/worktrees/<branch>`, `git branch -D <branch>`, `git -C <main checkout> pull`, and delete other merged local branches.
- Then say it in ALL CAPS: `PR #12 MERGED INTO MAIN.`

## Messages
Short and clear. Put blockers and surprises first. End each task with, skipping empty parts:
**Done** (links to files/PR) · **Verified** (what was tested, what was not) · **Needs a decision** (with your recommendation) · **Next steps** (who does what).
