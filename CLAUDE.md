# CLAUDE.md

## Git workflow
- Always create the branch from `origin/main` (`git fetch && git switch -c <branch> origin/main`), never from local `main`.
- Keep `main` linear: one branch per task, rebase on `origin/main`, squash-merge (`gh pr merge --squash --delete-branch`).
- When a task is done, without asking: commit, push, open a PR, then check its CI and comments (`gh pr checks --watch`, `gh pr view --comments`).
- If it's green, merge. If not, fix it on the branch right away and check again.
- After merging, delete the branch locally too (`git switch main && git pull && git branch -D <branch>`), plus any other local branch already merged.
- Once merged, say it in ALL CAPS, e.g. `PR #12 MERGED INTO MAIN.`

## Messages
- Be clear and short. End every task with a summary in this order, skipping any empty part:
  - **Done**: what was changed, with links to the files or the PR.
  - **Verified**: what was tested and the result; say plainly what was not tested or what failed.
  - **Needs a decision**: each open question, with your recommendation.
  - **Next steps**: what comes next, and who does it (you or the owner).
- Put anything that blocks or surprises (a failure, a skipped step, an assumption you made) at the top, not buried in the text.
