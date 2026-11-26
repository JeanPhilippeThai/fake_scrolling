# Next docs prompts

2026-11-26 · commit e4b341c · fingerprint 06c7fc3e4494

Doc tests: all passed. The docs are at step 5, Flows.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Passed: 0 blocking, 4 Major, 18 Minor |

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Done | L1 passed; B1: 1 Minor (B1-01, leftover design code) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | FL-01 to FL-15 written; L5: 2 Major (L5-02: F-005 and F-044 erase E-04 seeds without saying so; L5-05: D-128's backup and deleted-account jobs are in no flow); B5 passed |
| 6 Entities and states | Not done | 9 state diagrams and 6 TLA+ models, green in CI; L6: 1 Major (L6-02: SM-E-02 has no move to « Code expiré » on the 5th wrong code, D-127); B6 passed |
| 7 NFRs | Done | NFR-X-1 to NFR-X-17; L7: 1 Minor (L7-02), B7: 1 Minor (B7-02) |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Prompt 6: system design** (step 8), question « qu'est-ce qui doit être côté serveur vs client, et quel découpage en API ». Give it: the registry, FL-01 to FL-15, the stack (D-132 to D-135). It produces: decisions on the API split.
2. **Prompt 6: system design** (step 8), question « quel outil derrière la commande `app` de la vérification à l'exécution (lancer l'appli, la piloter, trouver chaque élément par son nom accessible) ». Give it: the stack (D-132 to D-135), NFR-X-14, `workflow_docs/method/verification.md`. It produces: the decision on the runtime verification tool.
