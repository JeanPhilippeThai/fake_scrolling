# Next docs prompts

2026-11-24 · commit f2afcbf · fingerprint cb949fbb8208

Doc tests: all passed. The docs are at step 5, Flows.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Passed: 0 blocking, 4 Major, 12 Minor |

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Done | L1 passed; B1: 1 Minor (B1-01, leftover design code) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Not done | FL-01 to FL-08 written; L5: 2 Major (L5-02 on FL-07 and FL-08); L5-05: no flow yet for the usage-time timer (F-015, F-065), post expiry or the profile; L5-07 not reached; B5 passed |
| 6 Entities and states | Not done | L6, B6 not reached |
| 7 NFRs | Not done | L7, B7 not reached |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached |

## Next prompts
