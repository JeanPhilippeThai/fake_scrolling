# Next docs prompts

2026-11-27 · commit 0ab85e4 · fingerprint c454c21653ea

Doc tests: all passed. The docs are at step 8, System design; three Major findings (L3-05, L5-02, G-04) are open in earlier steps and come first.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Passed: 0 blocking, 3 Major, 22 Minor |

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Done | L1 passed (P-29 is drawn, D-142); B1: 1 Minor (B1-01, leftover design code) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Not done | L3: 1 Major (L3-05: the themed logo drawn on P-29 is in no feature); B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | FL-01 to FL-15 written; L5: 1 Major (L5-02: F-052 and FL-08 read E-04 seeds since D-139 without saying so); B5 passed |
| 6 Entities and states | Done | L6, B6 passed: 9 state diagrams and 6 TLA+ models, green in CI |
| 7 NFRs | Done | NFR-X-1 to NFR-X-17; L7: 1 Minor (L7-02), B7: 1 Minor (B7-02) |
| 8 System design | Not done | The stack (D-132 to D-135) and the split between server, phone and API (D-136 to D-141) are decided; L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Prompt 11: data model** (step 8). Give it: the registry's entities (E-01 to E-17), the state diagrams, the stores (PostgreSQL, D-134; SQLite and the secure storage, D-135), and the leads of the check report (E-03's three types never stored, FL-15's list of deleted accounts). It produces: the tables, columns and types, in « Conception système ».
2. **Prompt 12: data-flow graph** (step 8). Give it: the data model from item 1, the flows FL-01 to FL-15, the API groups table (D-137). It produces: the nodes and data flows, in « Conception système ».
