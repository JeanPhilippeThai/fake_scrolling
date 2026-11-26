# Next docs prompts

2026-11-25 · commit ba98a99 · fingerprint 927843266df1

Doc tests: all passed. The docs are at step 5, Flows.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Passed: 0 blocking, 2 Major, 16 Minor |

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Done | L1 passed; B1: 1 Minor (B1-01, leftover design code) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | FL-01 to FL-09 and FL-11 to FL-13 written; L5: 1 Major (L5-05: the photo seeds sent before publication, D-120, and their erase, D-121, are in no flow); L5-07 not reached; B5 passed |
| 6 Entities and states | Not done | 8 state diagrams and 5 TLA+ models, green in CI; L6: 1 Major (L6-01: E-04 now has a server-side draft life and no state diagram, against D-107); L6-04 not reached; B6 passed |
| 7 NFRs | Not done | L7, B7 not reached |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Prompt 6: system design** (step 8), question « choisis la stack : langage et framework de l'app mobile, du serveur, et le moteur de chaque stockage (SQL ou NoSQL) ». Give it: the registry, FL-01 to FL-13, the NFRs (NFR-X-1 to NFR-X-17 in Conception système). It produces: stack decisions.
2. **Prompt 6: system design** (step 8), question « qu'est-ce qui doit être côté serveur vs client, et quel découpage en API ». Give it: the registry, FL-01 to FL-13, the stack from item 1. It produces: decisions on the API split.
