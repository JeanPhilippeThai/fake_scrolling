# Next docs prompts

2026-11-24 · commit 883a083 · fingerprint ed75333001bb

Doc tests: all passed. The docs are at step 5, Flows.

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Done | L1 passed; B1: 1 Minor (B1-01, leftover design code) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | FL-01 to FL-03 written; L5, B5 passed (L5-05, L5-07 not reached); no friend, story, message, search, profile, Premium or background-job flow yet |
| 6 Entities and states | Not done | L6, B6 not reached |
| 7 NFRs | Not done | L7, B7 not reached |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Prompt 5: flows** (step 5). Give it: FL-07 « Discuter avec un ami », proposed: P-08 (F-037, F-033) → P-09 (F-038, F-040, F-041, F-042, F-039), E-10, E-11. It produces: the same, for this flow.
2. **Prompt 5: flows** (step 5). Give it: FL-08 « Rechercher », proposed: P-14 → P-15 → P-16 (E-13). It produces: the same; profile, Premium and posts' remaining days come after.
