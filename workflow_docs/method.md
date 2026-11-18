# Building apps with Claude: the method

Snapshot of the Claude Doc ["Building apps with Claude: the method"](https://claude.ai/artifact/CNNN4eUxaLSfQh2ohtNAP4), taken on 2026-11-17: this file is its Overview tab (revision 88), and each other tab is a file in [method/](method/).
For now the Claude Doc is the source of truth and these files are copies of it.

## The idea in short

First describe the whole app wide and shallow: screens, features, data, architecture. With a Claude Design mock-up as the starting point, six prompts turn the screens into a registry of pages, features and entities. Then build it narrow and deep, one working feature at a time. Every piece of knowledge lives in exactly one place and has an ID, so Claude and you can always point to it.

Four principles:

- **One source of truth per fact.** Write a fact once and link to it everywhere else. Copies drift and end up lying.
- **Vertical slices, not layers.** A slice is one registry feature (F-xxx) a user can see, built through every layer (screen, API, service, database). Each slice ends with something that works.
- **Detail just in time.** Write the detailed design only for the next slice, right before building it. The one exception is the page contracts: one line per component, written for every page in step 8, so gaps show up before any code. Fix the docs as soon as the code proves them wrong.
- **Code shaped for agents.** Each feature lives in its own folder on a shared app framework, features never import each other, and the code carries no comments. Claude can then change one feature without reading the rest.

## How the method is organised

One file per kind of work, so an agent reads only what its task needs. Start each session with `CLAUDE.md`, then read the file the task calls for. To read the whole method, read this file, then the files below in this order.

| File | What it holds | Read it when |
| --- | --- | --- |
| [Describe the app](method/describe.md) | Steps 1 to 8 and their prompts | Starting an app, or changing the registry, a flow or a design decision |
| [Code structure](method/code-structure.md) | Folders for the UI, platform and server sides, import bans, file-name markers | Before touching code |
| [Verification](method/verification.md) | TLA+ models, runtime proofs, and the other checks that run before release | Writing a state model or proof blocks, before shipping |
| [Reference](method/reference.md) | Sources of truth, IDs, traceability | Looking up where a fact lives or how to name something |
| [Build the app](method/build.md) | The feature loop, defaults, and what to do when the design changes | At the start of every coding session |
| [Release and watch](method/release.md) | Deploy, release and post-release: flags, staged rollouts, monitoring | Preparing a release, or investigating a problem in production |

Changes flow both ways: a change to the description reaches the code only through the procedure in [Build the app](method/build.md), and code that proves the description wrong goes back through the same procedure.

## The pipeline

Steps 1 to 8 describe the app ([Describe the app](method/describe.md)): done once for the whole app and kept rough, with steps 5 and 8 repeated for each flow and each design question. Steps 9 to 11 build and release it ([Build the app](method/build.md) and [Release and watch](method/release.md)): step 9 is done once, steps 10 and 11 repeat for every feature until the app is built. Steps 2 to 5 and 8 each run one of the prompts in [Describe the app](method/describe.md).

| # | Step | What you do | What it produces |
| --- | --- | --- | --- |
| 1 | Design | Draw the screens in Claude Design, one design per platform the app targets (web, desktop, mobile: iOS and Android share the mobile design unless a decision splits them), including the empty, loading and error states | Mock-ups, navigation between pages |
| 2 | Raw extraction (prompt 1) | Give each screen a page ID and list everything a user can see or do on it. Nothing is merged across pages yet; anything deduced rather than seen is marked "to confirm" | Pages (`P`) and their elements |
| 3 | Registry (prompt 2; prompt 10 to merge platforms) | Merge the elements into features: same intent, data and behavior is one feature; same intent with different data or behavior is a variant. Pages and features link both ways. List the user roles and which of them may use each feature | `docs/registry.yaml`: pages, features (`F`), variants, entities (`E`), roles (R) with each feature's access, merges made, ambiguous cases |
| 4 | Check and arbitrate (prompts 3, 8 and 4; prompt 9 if the design changes) | Claude lists the inconsistencies without fixing anything. You settle them and the ambiguous cases; Claude applies your choices | A consistent registry, decisions (`D`) |
| 5 | Flows (prompt 5, once per flow) | Describe each flow across pages, and each background job (timers, expiry, cleanup), from registry IDs only | Flows (`FL`), missing features or pages |
| 6 | Entities and states | For each entity: which states exist, which moves between them are allowed, what triggers each move. Entities with non-trivial states, and sync between devices, get a TLA+ model whose rules the model checker proves | Entity state diagrams (`SM`), TLA+ models checked in CI |
| 7 | Non-functional requirements | Write the app-wide ones once (privacy, speed, security, accessibility), each with a number or a test. Add feature-level ones only when they are specific | NFRs (`NFR`) |
| 8 | System design (prompt 6, once per question; prompts 11 to 14) | Choose the stack, the API split, server versus client; write the data model as tables with columns and types (prompt 11) and the data-flow graph between user types and infrastructure (prompt 12), then a contract for every page listing each component, the columns and flows it uses and the conditions for it to appear, checked against the rest (prompts 13 and 14); lay the code out in ui/, platform/ and shared/ (see [Code structure](method/code-structure.md)), with one folder per feature, the import bans as lint rules, the file-name markers, and the tool behind the app command for runtime verification, and write the threat model | Decisions (`D`), system design with its data model (TB) and data-flow graph (N, DF), page contracts (C) and the list of gaps, import rules in the lint config |
| 9 | Walking skeleton | Build the thinnest app that runs end to end: sign in, one screen, one call to the server, one table, deployed to staging and the beta channels with crash reporting and one feature flag, built and running on every platform the app targets (web, desktop, iOS, Android), the registry database built from the docs with its checks running in CI, import bans already enforced, and the app command able to reach that screen and screenshot it on each | First tasks in the backlog (`T`) |
| 10 | Feature loop | For the next feature: its spec (rules, criteria), acceptance criteria as tests, code in the feature's folder, proof on the real app, doc fixes, then one pull request, merged with the feature's flag off | Working feature, updated docs |
| 11 | Release and watch | Beta channels, then the flag turned up and a staged rollout while errors, latency and crashes are watched; problems seen in production come back as tasks | Feature in users' hands, its flag removed |

A walking skeleton proves that all the pipes connect before you put real features through them. Its tasks come before any slice.
