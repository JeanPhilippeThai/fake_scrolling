# Build the app

Part of [the method](../method.md). Snapshot of the "Build" tab of the Claude Doc ["Building apps with Claude: the method"](https://claude.ai/artifact/CNNN4eUxaLSfQh2ohtNAP4), revision 13, taken on 2026-11-19.

Steps 9 and 10, narrow and deep: how Claude works on the repo, the loop for one feature, and what happens when the description changes after code exists. Read this part at the start of every coding session. "The description" means everything decided in [Describe the app](describe.md) and [Code structure](code-structure.md): the registry, flows, state models and system design.

## Working with Claude

Claude starts every session with no memory of the last one. `CLAUDE.md` is its map: what the project is, where each source of truth lives, how to work. Keep it short, and keep it pointing to the docs instead of copying them. Start every session from the main checkout, up to date with git pull --ff-only origin main, before opening a task's worktree: Claude Code loads the skills from the checkout the session starts in, so a checkout behind main runs old skills.

The loop for one feature (step 10):

1. **Check:** open pull requests, the feature's `questions_ouvertes` and app-wide questions that block the task, the task's row in the backlog.
2. **Detail:** write the feature's spec for this feature only, starting from its components in the page contracts (rules, criteria with their proof blocks, data, API calls, events). A contract that still holds a MANQUANT stops the feature here, citing its `F`, `FL`, `E` and `D` IDs.
3. **Tests first:** turn the feature's acceptance criteria into tests named after their IDs.
4. **Build:** small steps, one idea at a time, inside the feature's folder. Each step is explained in the chat or the pull request, never in a code comment.
5. **Prove it:** drive the real app with the `app` command on every platform the feature is on (web, desktop, iOS, Android), follow each proof block, check the snapshot, save the screenshots (see [Verification](verification.md)). A failing proof goes back to step 4.
6. **Fix the docs:** if the code proved a doc wrong, update it in the same pull request. A change to the description follows "When the design changes" below: listed first, applied only after your OK, recorded as a decision.
7. **Ship:** all checks green, import bans included, proofs passing on every platform the feature is on, then a pull request with the screenshots attached. Merging deploys the feature with its flag off; releasing it is step 11, in [Release and watch](release.md). The merge also updates the task's status in the backlog.

Recommended defaults, to adapt per project and write into its `CLAUDE.md`:

- No feature without a registry entry (`F`) and a backlog row.
- Claude never changes the registry on its own: it lists the change, you approve, then it applies it and adds the decision.
- IDs are never renumbered. Claude never releases a feature or turns a flag up on its own.
- Never weaken a test or a proof block to make it pass. A feature is not done until its proofs pass on every platform it is on.
- A question that blocks the work stops it. A question that does not block goes to the feature's `questions_ouvertes` (or the register, if app-wide), and the work goes on.
- A shortcut taken on purpose is written in the workarounds log, with what it would take to remove it.
- A task too big to review in one sitting is split into several pull requests, each one coherent and green.
- Follow the rules in [Code structure](code-structure.md): one folder per feature, no imports between features or across the UI/platform line, no comments in code, file names that carry their rules.

## When the design changes

A change to the description never goes straight into the code: Claude first lists everything it touches, you decide, and the rework becomes backlog tasks. This holds whether you start the change or the feature loop finds a doc is wrong.

1. **Name the change.** Which IDs change (`F`, `E`, `FL`, `SM`, `NFR`, `D`) and how: added, changed, merged, split or removed.
2. **List the impact.** Claude runs the impact query on the registry database (see [Reference](reference.md)) to list everything linked to those IDs, then uses prompt 7 below to sort it. It changes nothing.
3. **Decide.** You approve, adjust or drop the change. It goes into the registry as a decision (`D`) with its reason.
4. **Update the description first.** Registry, flows and system design change in one pull request that cites the `D`. Prompt 3 runs again to check the registry, prompt 14 rechecks the page contracts, the registry database checks run in CI, and the model checker reruns every changed TLA+ model.
5. **Plan the rework.** Each built feature that is affected gets a backlog task citing the `D`. Features not built yet only need their spec to follow.
6. **Build.** Those tasks go through the normal feature loop, one feature folder each.

**Prompt 7: impact of a change** (added to the six in [Describe the app](describe.md), same style)

```text
Changement proposé : [décris le changement, avec les IDs concernés].
Sans rien modifier, liste tout ce qu'il impacte en suivant les IDs :
- Features et variantes (F), avec leur dossier de code.
- Specs : règles (BR) et critères (AC) concernés.
- Tests et blocs de preuve nommés d'après ces IDs.
- Tâches du backlog dont la colonne Serves cite ces IDs, et pull requests ouvertes.
- Entités (E), flows (FL) et diagrammes d'états (SM) touchés, avec leurs modèles TLA+ et les règles qu'ils vérifient.
- Décisions (D) existantes que ce changement contredit.
Classe chaque impact : à modifier, à déplacer, à supprimer.
N'applique rien : j'arbitre d'abord, puis la décision va dans `decisions`.
```

Because each feature has its own folder, a change in the registry shows up in the code as follows:

| Change in the description | What happens in the code |
| --- | --- |
| New feature | A new folder, spec and tasks. Nothing existing moves |
| Feature's behavior or data changed | Its spec and tests change first, then its code. Only its folder is touched |
| New variant (`F-012.a`) | Code goes in the parent's folder; no new folder |
| Two features merged | One ID survives; the other leaves `features` and is never reused, and its `D` says where it went. Its code moves into the surviving folder, and the old folder is deleted |
| Feature split | The original keeps its ID for one part; the other part gets a new `F` and its own folder, and its code moves there |
| Feature removed | It leaves `features`, its ID is never reused, and its `D` records why. Its folder, tests and tasks are deleted |
| Entity changed (`E`) | Every feature in its `utilisee_par` is affected, plus a data migration task. Its TLA+ model is updated and rechecked before any code changes |
| Architecture decision changed (framework, API split) | The framework or shared change is its own task first, then one task per feature that must adapt |
| A released feature changed | The change ships behind its own flag and is released like a new feature. The server keeps serving app versions that predate it |

Moving code between folders is the one costly case, so merges and splits are best settled in step 4, before any code exists.

## Pitfalls

| Pitfall | Why it hurts | Instead |
| --- | --- | --- |
| Answering a question only in the chat | The answer is lost when the session ends | Record it as a decision (`D`) in the registry |
