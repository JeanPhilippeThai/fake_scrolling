# Next docs prompts

2026-11-27 · commit bb57d34 · fingerprint 5bc0ba79a5de

Doc tests: all passed. The docs are at step 8, System design; one redraw (L1-04) and two Major findings (L5-02, G-04) are open in earlier steps and come first.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Passed: 0 blocking, 3 Major, 20 Minor |

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Not done | L1: 1 Major (L1-04: F-074's page P-29 is decided by D-141 but not drawn); B1: 1 Minor (B1-01, leftover design code) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | FL-01 to FL-15 written; L5: 1 Major (L5-02: F-052 and FL-08 read E-04 seeds since D-139 without saying so); B5 passed |
| 6 Entities and states | Done | L6, B6 passed: 9 state diagrams and 6 TLA+ models, green in CI |
| 7 NFRs | Done | NFR-X-1 to NFR-X-17; L7: 1 Minor (L7-02), B7: 1 Minor (B7-02) |
| 8 System design | Not done | The stack (D-132 to D-135) and the split between server, phone and API (D-136 to D-141) are decided; L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Prompt 8: sort the check's findings**, on the Major findings 2 (L5-02: add E-04 to F-052, D-139 and FL-08) and 6 (G-04: D-135 and NFR-X-3 say « historique de recherche (E-13) », D-089 and E-13 say no history is kept) of `claude_skills_output/design_and_docs_check_output.md`. It produces: both fixed in the registry and « Conception système » Claude Docs, then imported and promoted.
2. **Prompt 6: system design** (step 8), question « quel outil derrière la commande `app` de la vérification à l'exécution (lancer l'appli, la piloter, trouver chaque élément par son nom accessible) ». Give it: the stack (D-132 to D-135), NFR-X-14, `workflow_docs/method/verification.md`. It produces: the decision on the runtime verification tool.
3. **Prompt 11: data model** (step 8). Give it: the registry's entities (E-01 to E-17), the state diagrams, the stores (PostgreSQL, D-134; SQLite and the secure storage, D-135), and the leads of the check report (E-03's three types never stored, FL-15's list of deleted accounts). It produces: the tables, columns and types, in « Conception système ».
4. **Prompt 12: data-flow graph** (step 8). Give it: the data model from item 3, the flows FL-01 to FL-15, the API groups table (D-137). It produces: the nodes and data flows, in « Conception système ».
