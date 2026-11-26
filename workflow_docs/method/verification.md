# Verification

Part of [the method](../method.md). Snapshot of the "Verification" tab of the Claude Doc ["Building apps with Claude: the method"](https://claude.ai/artifact/CNNN4eUxaLSfQh2ohtNAP4), revision 12, taken on 2026-11-26.

How Claude checks its own work before anything reaches users. TLA+ models check the design (step 6), runtime proofs check the running app (step 10), and a set of automated checks guards the code in CI. What happens once code reaches users is in [Release and watch](release.md). Read this part when writing a state model or a feature's proof blocks, and before shipping a feature.

## Formal verification: the design

Step 6's state diagrams become TLA+ models, and a model checker proves that their rules hold in every reachable state, not just in the cases someone thought to test. Lean stays an exception, for small pieces of logic where a bug would be expensive.

| Tool | What it checks | When to use it | Where it lives |
| --- | --- | --- | --- |
| TLA+ model | The design: every reachable state, every order of events, against the rules that must always hold | Every entity with non-trivial states (`SM-E-xx`); one model for sync if a user can be on several devices at once | `docs/system-design/SM-E-03.tla`, `docs/system-design/sync.tla` |
| Lean proof | One piece of logic: correct for every possible input | Only small, pure logic that is costly if wrong (a price calculation, a sync merge rule), and only when a decision (`D`) says so | `verify/lean/`, as a reference version; generated tests check that the app's code gives the same answers |

A TLA+ model for an entity, with the rule it checks named after its business rule (TLA+ names cannot hold dashes):

```text
---- MODULE SM_E_03 ----
VARIABLES status, paid

Init == status = "draft" /\ paid = FALSE
Submit == status = "draft" /\ status' = "submitted" /\ UNCHANGED paid
Pay == status = "submitted" /\ status' = "paid" /\ paid' = TRUE
Cancel == status \in {"draft", "submitted"} /\ status' = "cancelled" /\ UNCHANGED paid
Next == Submit \/ Pay \/ Cancel
Spec == Init /\ [][Next]_<<status, paid>>

BR_007_2 == ~(status = "cancelled" /\ paid)
====
```

Rules:

- Each checked rule is named after the business rule it enforces: `BR_007_2` checks `BR-007-2`. You approve which rules a model checks, as with any change to the registry.
- The model checker runs in CI whenever a `.tla` file changes. When a rule breaks, it prints the exact sequence of steps that breaks it, and that sequence becomes a test.
- Multi-device cases are where it pays most: offline edits, sync conflicts, a session that expires on one device mid-action on another.
- A model checks the design, not the code. Tests and runtime proofs still check the code.

## Runtime verification: the app

Claude proves each feature on the real app before asking for your review: it reaches the feature the way a user would, acts on it, checks what the screen shows, and keeps the evidence. Tests check the code; this checks the app, on every platform the feature is on: web, desktop, iOS, Android.

| Piece | What it is | Where it lives |
| --- | --- | --- |
| Feature map | For each feature: how a user reaches it and what proves it works. It is built from what already exists: features from the registry, paths from the flows, proofs from the acceptance criteria | Registry (`F`), flows (`FL`), and a proof block per criterion in the feature spec |
| `app` command | A command line that drives the real app on each platform (on the web, a real browser): click by accessible name, snapshot what is on screen, take a screenshot | `tools/app/`, its commands listed in `CLAUDE.md` |

The commands, as in dune (the tool is a step 8 decision, and the exact names are settled when it is built in step 9):

```bash
$ app --platform ios aria-click --accessible-name "Apply coupon"
$ app --platform ios snapshot
$ app --platform ios screenshot AC-012-1.ios.png
```

A proof block sits under each acceptance criterion in the feature spec (`docs/features/F-012-apply-coupon.md`):

```markdown
AC-012-1: an expired coupon is refused
Reach: FL-02, P-03 Cart then F-012 Apply a coupon
Do: type "OLD10" in "Coupon code", click "Apply coupon"
Expect in the snapshot: the alert "This coupon has expired", total unchanged
Proof: AC-012-1.desktop.png, AC-012-1.ios.png, AC-012-1.android.png
```

Rules:

- Every criterion a user can see gets a proof block. Criteria with nothing on screen are covered by tests only.
- Every button, field and link has an accessible name, fixed in its page contract (`nom_accessible`): that is how the `app` command finds it, and how screen readers do. This is an app-wide requirement (`NFR-X`), checked by lint where possible.
- Proofs run on every platform the feature is on. Screenshots are named `<criterion>.<platform>.png` and attached to the pull request.
- A failing proof sends the work back to Build. Like a test, a proof block is never weakened to make it pass.
- The proof is evidence for your review, not a replacement for it: you look at the screenshots in the pull request.

## Tests Claude cannot game

All tests green must mean the code follows the spec, not that it was shaped to the tests. So the agent that builds a feature never writes its tests, cannot change them and cannot see all of them, and every test must fail before the code that makes it pass exists. No guard alone makes cheating impossible; together they leave one way to turn the suite green: code that applies the rules.

Two agents work on each feature, in separate sessions (step 10, in [Build the app](build.md)):

| Agent | Reads | Writes | Never |
| --- | --- | --- | --- |
| Test writer | The feature spec (rules, criteria, proof blocks, NFRs) and the API contracts in `shared/` | The visible tests, in the feature's folders, and the hidden tests | Reads the feature's code |
| Builder | The spec and the visible tests | The feature's code | Writes or changes a test file, or sees a hidden test |

Test files are the files named `.test.ts` or `.fixture.ts`, the test snapshots, and the settings of the test runner, the coverage tool and the mutation tool.

| Guard | What it stops | How it holds |
| --- | --- | --- |
| Tests first | Tests written to fit code that already exists | In a pull request, test files change only in the commits before the first code commit, written by the test writer; CI fails the pull request otherwise |
| Tests locked | A test, fixture, snapshot or threshold eased until the code passes | The builder's commits never touch a test file (the same CI check). A wrong test is fixed by the test writer in its own pull request, after a spec change you approved ("When the design changes" in Build), and the work rebases on it |
| Red before green | A test that passes whatever the code does | CI runs each new or changed test on the base commit; one that passes there fails the pull request. The test for a bug must fail on the code before its fix |
| Hidden tests | Code fitted to the tests the builder can read | A second set, written from the same spec, in a private repo the builder's sessions cannot read. CI checks it out and runs it on each pull request; the builder sees only the ID of the rule or criterion that failed |
| A property test for every rule | Code that recognizes the examples instead of applying the rule | Every rule (`BR`) about values (amounts, dates, text, lists) gets a property test: random inputs checked against the rule |
| Gaming scan | Code that behaves differently under test | A lint rule on `src/` fails on a check for the test environment or the test runner; a test name or a fixture value in feature code, unless the spec names that value; `skip`, `only` or `todo` in a test; an error caught and dropped |
| Adversarial review | Special cases no scan recognizes | A reviewer agent reads only the spec and the diff, and looks for branches on specific values, rules applied to the examples only, and behavior that differs under test. Each finding blocks the merge like a failing check |

Mutation tests and runtime proofs complete these guards: the first catch tests that check nothing, the second a screen that is wrong while every test is green.

Rules:

- The test writer, the hidden-tests repo, the gaming scan and the reviewer are set up in step 9, with the walking skeleton. You create the private repo and the key CI reads it with.
- A failing hidden test sends the work back to step 4 with the ID it checks. The builder fixes the code from the spec and never asks to see the test.
- Hidden tests are named after their IDs like visible ones (`it("BR-012-3: refuses an expired coupon")`), and traceability counts both.
- When a feature's spec changes, the test writer updates both sets before any code changes.

## Other checks before release

Each of these is set up once, mostly in steps 8 and 9, then runs on its own.

| Check | What it catches | Where it applies | When it runs |
| --- | --- | --- | --- |
| Mutation tests | Hollow tests: the tool breaks the code on purpose, and a test suite that stays green checks nothing | Feature logic, on the UI side and the server side | On each pull request, for the files it changes |
| Property-based and fuzz tests | Inputs nobody thought of: random values checked against a rule that must always hold | Parsers, sync, pricing, any rule that holds for every input; generated from the Lean reference where one exists | On each pull request |
| Contract tests | App and server drifting apart, including app versions still installed on users' devices | The API contracts in `shared/`: every supported app version against the current server | On each pull request touching `ui/client/`, `server/` or `shared/` |
| Access tests | A role using a feature it has no right to: the server must refuse every role missing from the feature's `acces` | Every feature with a server side; tests named after the role and the feature, e.g. `it("R-04 refused on F-035")` | On each pull request |
| Schema check | The data model file and the real database drifting apart | `docs/system-design/data-model.yaml` against the database migrations | On each pull request touching either |
| Benchmarks | Slowdowns in code that runs often | `.hot.ts` files, and server endpoints with a latency requirement | On each pull request touching them; a regression past its `NFR` fails the build |
| Load and soak tests | The server failing at peak, or degrading over hours (leaks, growing queues) | The server; soak tests also for the desktop app | Before each server release, against staging |
| Threat model | Attacks the design invites: who can do what, what leaks if one part is compromised | The whole app, written in step 8 from the data-flow graph (every flow marked sensitive is examined) and updated with every design change | Its findings become security requirements (`NFR-X`) and auditing needs |
| Penetration tests | What the threat model missed | Server and apps | Before the first public release, then on a schedule |

## Pitfalls

| Pitfall | Why it hurts | Instead |
| --- | --- | --- |
| Testing only the cases you thought of | Rare orders of events (two devices, offline, expiry mid-action) slip through | A TLA+ model for every non-trivial state machine and for sync |
| Formal proofs everywhere | A Lean version is a second codebase that drifts from the real one | Lean only for small, critical logic, and only by decision |
| Trusting green tests alone | The code passes, but the screen is wrong, unreachable, or broken on one platform | Prove each visible criterion on the real app, on every platform its feature is on |
| Buttons and fields without accessible names | The app command cannot find them, and neither can screen readers | An accessible name on every interactive element, from the walking skeleton on |
| Hollow tests | Claude's tests pass but would also pass on broken code | Mutation tests on every changed file |
| Testing the server only against the latest app | Users who have not updated start seeing errors | Contract tests against every supported app version |
| Code shaped to the tests | Every test is green while the bug is still there: special cases for the test values, or behavior that changes under test | Tests written and locked by another agent, hidden tests, red before green, the gaming scan (Tests Claude cannot game) |
