# Verification

Part of [the method](../method.md). Snapshot of the "Verification" tab of the Claude Doc ["Building apps with Claude: the method"](https://claude.ai/artifact/CNNN4eUxaLSfQh2ohtNAP4), revision 5, taken on 2026-11-17 (see [DEC-5](../decisions.md#dec-5)).

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

Claude proves each feature on the real app before asking for your review: it reaches the feature the way a user would, acts on it, checks what the screen shows, and keeps the evidence. Tests check the code; this checks the app, on desktop, iOS and Android.

| Piece | What it is | Where it lives |
| --- | --- | --- |
| Feature map | For each feature: how a user reaches it and what proves it works. It is built from what already exists: features from the registry, paths from the flows, proofs from the acceptance criteria | Registry (`F`), flows (`FL`), and a proof block per criterion in the feature spec |
| `app` command | A command line that drives the real app on each platform: click by accessible name, snapshot what is on screen, take a screenshot | `tools/app/`, its commands listed in `CLAUDE.md` |

The commands, as in dune (the exact names are settled in step 8):

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
- Proofs run on all three platforms. Screenshots are named `<criterion>.<platform>.png` and attached to the pull request.
- A failing proof sends the work back to Build. Like a test, a proof block is never weakened to make it pass.
- The proof is evidence for your review, not a replacement for it: you look at the screenshots in the pull request.

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
| Trusting green tests alone | The code passes, but the screen is wrong, unreachable, or broken on one platform | Prove each visible criterion on the real app, on all three platforms |
| Buttons and fields without accessible names | The app command cannot find them, and neither can screen readers | An accessible name on every interactive element, from the walking skeleton on |
| Hollow tests | Claude's tests pass but would also pass on broken code | Mutation tests on every changed file |
| Testing the server only against the latest app | Users who have not updated start seeing errors | Contract tests against every supported app version |
