# Next docs prompts

2026-11-24 · commit bb0c70c · fingerprint a92ff8600eb5

Doc tests: all passed. The docs are at step 1, Design.

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Not done | L1: 1 Major (L1-02, P-28's loading and error states, finding 1); B1: 1 Minor (leftover design code, finding 4) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | FL-01 to FL-03 written; L5: 2 Major (L5-02, findings 2 and 3); B5 passed; no background-job flow yet |
| 6 Entities and states | Not done | L6, B6 not reached |
| 7 NFRs | Not done | L7, B7 not reached |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Prompt 5: flows** (step 5). Give it: FL-04 « Ajouter un ami », proposed: P-08 → P-11 Messages — Ajouter un ami → the invitation answered on P-04 by the other user. It produces: the flow's sequence by IDs, the entities read and written, its decision points and errors, and the features or pages missing from the registry.
2. **Prompt 5: flows** (step 5), background job. Give it: FL-05 « Griser l'app par cycles », proposed: the colour timer (E-14) that greys every page by 10 % per cycle (F-024) and resets from P-17. It produces: the same, for this job.
3. **Prompt 5: flows** (step 5). Give it: FL-06 « Voir et publier une story », proposed: P-08 Messages → P-10 lecteur de story (F-036), and P-12 with « Story » chosen → P-08.b Story publiée (F-051, E-12). It produces: the same, for this flow; the other flows (messages, search, profile, Premium, posts' remaining days) come after.
