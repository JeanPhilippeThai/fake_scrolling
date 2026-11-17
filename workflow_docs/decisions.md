# Decision log

Each decision gets a `DEC-<n>` ID that is never reused. Newest at the bottom.

## DEC-1

**The method lives in this repo, in [method.md](method.md).**
It started as the Claude Doc ["Building apps with Claude: the method"](https://claude.ai/artifact/CNNN4eUxaLSfQh2ohtNAP4) (2026-11-13). Two editable copies would drift, so the repo is now the only home: it is versioned, reviewable in pull requests, and Claude reads it at the start of every session. The Claude Doc is kept as the original draft and is not updated any more.

Suspended by [DEC-3](#dec-3) until a later decision makes the repo the source again.

## DEC-2

**This project follows its own method.**
The rules it teaches (one source of truth, stable IDs, decision log, questions register) apply here first. A rule we cannot follow ourselves is a sign the rule is wrong, and gets fixed in `method.md`.

## DEC-3

**For now the Claude Docs are the source of truth; the repo holds dated copies of them.**
After DEC-1, the owner kept writing the method in the Claude Doc ["Building apps with Claude: the method"](https://claude.ai/artifact/CNNN4eUxaLSfQh2ohtNAP4): it grew from one page to seven tabs (registry, prompts 1 to 14, code structure, verification, release). On 2026-11-17 the owner decided that the Docs stay the source of truth for now, and that this repo becomes the source again later, by a new decision. Until then:

1. A change to the method or the check is made in its Claude Doc first.
2. The repo copy is then refreshed from the Doc in one commit, which names the Doc revision in the copy's first lines.
3. The copies are never edited by hand, except for these adaptations: the byline becomes a snapshot note, "tab" references become links to sections, and the diagrams the Doc export drops are redrawn in Mermaid.

First sync, 2026-11-17: [method.md](method.md) from the method Doc (Overview at revision 85), and [design_and_docs_check.md](design_and_docs_check.md) from the check Doc (revision 18). The seven tabs became seven parts of `method.md`, in the Doc's order, so the repo keeps one method file.

## DEC-4

**The top to bottom check lives next to the method, in [design_and_docs_check.md](design_and_docs_check.md).**
It is written for a checking agent, not for the agent that builds: it checks, layer by layer, that a project's documents are complete, consistent and traceable from the Claude Design screens down to the feature specs, and stops before the code. It is run on its own, so it gets its own file instead of a part of `method.md`. It comes from the Claude Doc ["Building apps with Claude: top to bottom check instruction"](https://claude.ai/artifact/EstadEuPyWMhdta7gNjwiG) and follows DEC-3.

## DEC-5

**The method is split into one file per tab: [method.md](method.md) is the entry file, and each other tab is a file in [method/](method/).**
As one file, `method.md` weighed about 63 KB (about 16k tokens). A coding session needs only Build, Code structure and parts of Reference (about 26 KB), but loaded everything, including about 17 KB of prompts. The method itself says to read only the part a task needs, and warns against docs Claude rereads every session. One file per tab also maps each Doc tab to one file, so a DEC-3 re-sync copies each tab into its own file without rewriting it.

- `method.md` holds the Overview tab: the idea, the principles, the pipeline, and the table of files in reading order. To read the whole method, read it, then the files in that order.
- `method/describe.md`, `code-structure.md`, `verification.md`, `reference.md`, `build.md`, `release.md` hold one tab each. Each names its tab and revision in its first lines.
- "Tab" references in the Doc become links to these files. This replaces the "links to sections" adaptation of DEC-3, and the single-file layout of its first sync.
- `design_and_docs_check.md` stays one file: the checking agent reads all of it.

## DEC-6

**Every change to `workflow_docs/` on `main` is copied into claudine, fake_scrolling and travel_planner, at the same path, through a pull request in each.**
The owner wants the three apps to follow the latest method without copying it by hand. The owner chose, on 2026-11-17:

- **What lands where:** this repo's `workflow_docs/` lands as `workflow_docs/` at the app's root, next to the app's own `docs/`. This repo's `docs/` folder was renamed `workflow_docs/` for this, so the method has the same path everywhere. `CLAUDE.md` is not copied: each app keeps its own, and links to `workflow_docs/method.md` itself. Nothing else in the app is touched.
- **How:** a pull request in each app, opened or updated by the GitHub Action [sync-to-apps.yml](../.github/workflows/sync-to-apps.yml), so each copy is reviewed before it lands. An app with no commit yet gets the first copy straight on `main`, since a pull request needs a base branch.

How it works:

1. [scripts/sync-to-app.sh](../scripts/sync-to-app.sh) replaces the app's `workflow_docs/` as a whole, so a file removed here is removed there too. `workflow_docs/` belongs to the sync: it is never edited in the app.
2. The Action pushes the result to the app's `sync/workflow-claude` branch and opens a pull request, or updates the one already open.
3. It needs the secret `APPS_SYNC_TOKEN`: a fine-grained GitHub token with Contents and Pull requests write access on the three app repos.

The list of apps lives in the workflow's `matrix`, and only there.

## DEC-7

**The git history of this repo is a single line, and Claude marks a finished task with a line in capitals.**
The owner asked for both on 2026-11-17. A single line of history reads like a list of changes, one per commit, with no merge commits to untangle. The capitals line tells the owner at a glance that nothing is waiting for them. The rules and commands are in [CLAUDE.md](../CLAUDE.md).
