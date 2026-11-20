# Next docs prompts

2026-11-20 · commit 620ad29 · fingerprint 7ca7364c7e6f

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
1. **Prompt 8: sort the check's findings** (step 2). Give it: finding #2 (L2-03, class B: six « à confirmer » items of the inventory on P-04, P-07, P-12, P-16 with no question or decision), with question 2. It produces: open questions on F-022 or F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010, or decisions.
2. **Prompt 8: sort the check's findings** (steps 3 and 4). Give it: findings #3 (L3-07, F-046 and F-069), #4 (B3-02, E-09 « refusé »), #7 (T-01, E-03 fields for F-048 and F-049) and #8 (T-04, P-02.b and F-008), with questions 3 and 4. It produces: the class A fixes (#7, #8) and decisions for #3 and #4 in the registry Claude Doc, then import and promote.
3. **Prompt 5: flows** (step 5), one run per flow. Give it: flow FL-01 and its name, from the owner (no flow is named in the docs yet). It produces: the flow's sequence, the entities read and written, its decision points and errors, and the features or pages missing from the registry.
