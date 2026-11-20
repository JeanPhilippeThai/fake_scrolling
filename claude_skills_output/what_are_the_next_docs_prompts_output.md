# Next docs prompts

2026-11-20 · commit 620ad29 · fingerprint 0f141510a9df

Doc tests: all passed. The docs are at step 1, Design.

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Not done | L1: 1 Major (#1 L1-02); B1: 1 Minor (#5) |
| 2 Raw extraction | Not done | L2: 1 Major (#2 L2-03); B2 passed |
| 3 Registry, 4 Check and arbitrate | Not done | L3: 1 Major (#3 L3-07); B3: 1 Major (#4 B3-02); L4, B4 not run (one platform) |
| 5 Flows | Not done | L5, B5 not reached |
| 6 Entities and states | Not done | L6, B6 not reached |
| 7 NFRs | Not done | L7, B7 not reached |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached |

## Next prompts
1. **Prompt 5: flows** (step 5), one run per flow. Give it: flow FL-01 and its name, from the owner (no flow is named in the docs yet). It produces: the flow's sequence, the entities read and written, its decision points and errors, and the features or pages missing from the registry.
