# Next docs prompts

2026-11-25 · commit ba98a99 · fingerprint 630f7bafb2f8

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
1. **Prompt 8: sort the check's findings** (step 6), on finding 2 (L6-01, class B). Give it: D-107, D-120, D-121, E-04, SM-E-03, SM-E-12, the 24 h cleanup of D-123 (FL-14), and the report's question 2 (a: amend D-107 and add SM-E-04 Média, graine d'un brouillon → rattachée → effacée, recommended; b: no diagram, reword D-107 and the « États des entités » intro). If a diagram is added, keep in step with `docs/system-design/sync.tla` or add `SM_E_04.tla`. It produces: a decision, SM-E-04 or the reworded D-107.
2. **Step 7: non-functional requirements** (no prompt). Write the app-wide NFRs once (privacy, speed, security, accessibility), each with a number or a test, as `NFR-X-<n>` in the Conception système Claude Doc (the app has no `docs/cross-cutting.md`; its docs live in Claude Docs), with feature-level ones (`NFR-<feature>-<n>`) only where they are specific. D-074, D-086, D-101 and D-119 already constrain privacy; accessible names are required by `verification.md`. It produces: NFRs.
3. **Prompt 6: system design** (step 8), question « choisis la stack : langage et framework de l'app mobile, du serveur, et le moteur de chaque stockage (SQL ou NoSQL) ». Give it: the registry, FL-01 to FL-13, the NFRs from item 2. It produces: stack decisions.
4. **Prompt 6: system design** (step 8), question « qu'est-ce qui doit être côté serveur vs client, et quel découpage en API ». Give it: the registry, FL-01 to FL-13, the stack from item 3. It produces: decisions on the API split.
