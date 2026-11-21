# Next docs prompts

2026-11-21 · commit 880a138 · fingerprint bd3e3c1e2ce3

Doc tests: all passed. The docs are at step 5, Flows.

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Done | L1 passed; B1: 1 Minor (leftover design code, owner question 1) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | L5, B5 not reached; no flow (FL) in the docs yet |
| 6 Entities and states | Not done | L6, B6 not reached |
| 7 NFRs | Not done | L7, B7 not reached |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Prompt 5: flows** (step 5). Give it: FL-01 « Se connecter », proposed from the registry: P-01 Connexion → P-02 Code reçu par e-mail → P-03 Accueil — fil; the owner confirms the name. It produces: the flow's sequence by IDs, the entities read and written, its decision points and errors, and the features or pages missing from the registry.
2. **Prompt 5: flows** (step 5). Give it: FL-02 « Parcourir le fil et réagir à un post », proposed: P-03 → P-05, P-06 and P-07 (like, comment, save, share). It produces: the same, for this flow.
3. **Prompt 5: flows** (step 5). Give it: FL-03 « Publier un post », proposed: P-12 Nouveau post — choix des photos → P-13 légende, with P-24 to P-26 → P-03. It produces: the same, for this flow.
4. **Prompt 5: flows** (step 5). Give it: FL-04 « Ajouter un ami », proposed: P-08 → P-11 Messages — Ajouter un ami → the invitation answered on P-04 by the other user. It produces: the same, for this flow.
5. **Prompt 5: flows** (step 5), background job. Give it: FL-05 « Griser l'app par cycles », proposed: the colour timer (E-14) that greys every page by 10 % per cycle (F-024) and resets from P-17. It produces: the same, for this job; the other flows (messages and stories, search, profile, Premium, posts' remaining days) come after.
