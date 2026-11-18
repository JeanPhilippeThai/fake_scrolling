# CLAUDE.md

## Git workflow
- Always create the branch from `origin/main` (`git fetch && git switch -c <branch> origin/main`), never from local `main`.
- Keep `main` linear: one branch per task, rebase on `origin/main`, squash-merge (`gh pr merge --squash --delete-branch`).
- When a task is done, without asking: commit, push, open a PR, then check its CI and comments (`gh pr checks --watch`, `gh pr view --comments`).
- If it's green, merge. If not, fix it on the branch right away and check again.
- After merging, delete the branch locally too (`git switch main && git pull && git branch -D <branch>`), plus any other local branch already merged.
- Once merged, say it in ALL CAPS, e.g. `PR #12 MERGED INTO MAIN.`
