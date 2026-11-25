# Next docs prompts

2026-11-25 · commit ebd658d · fingerprint d369641c43b1

Doc tests: all passed. The docs are at step 5, Flows.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Passed: 0 blocking, 5 Major, 13 Minor |

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Done | L1 passed; B1: 1 Minor (B1-01, leftover design code) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | FL-01 to FL-09 and FL-11 written; L5: 2 Major (L5-05: no flow for the resend of pending sends, nor for the end of a story); L5-07 not reached; B5 passed |
| 6 Entities and states | Not done | 8 state diagrams written (D-107); L6: 2 Major (L6-02 on F-070, L6-03: no TLA+ model); L6-04 not reached, L6-05 not run; B6 passed |
| 7 NFRs | Not done | L7, B7 not reached |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Step 6: entities and states** (no prompt). Fix finding 3 (L6-02, class A): F-070 creates the timer (E-14) and the support record (E-16) in SM-E-14 and SM-E-16, but its `entites` list only E-01 and E-02; add them in the registry Claude Doc (and E-15 if it is created at sign-up), or drop « F-070 » from the two initial moves. Then write the five TLA+ models D-107 chose (SM-E-09, SM-E-12, SM-E-14, SM-E-16 and sync between phones), as `workflow_docs/method/verification.md` says, with their rules from the table « Modèles TLA+ à écrire » of `conception-systeme.md`, and run the model checker in CI (finding 4, L6-03). It produces: TLA+ models checked in CI; their `BR` IDs wait for step 7 or the feature specs (L6-04).
2. **Step 7: non-functional requirements** (no prompt). Write the app-wide NFRs once (privacy, speed, security, accessibility), each with a number or a test, in the Conception système Claude Doc, with feature-level ones only where they are specific (D-074, D-086 and D-101 already constrain privacy). It produces: NFRs (`NFR-xx`).
