# Next docs prompts

2026-11-27 · commit 6d380a1 · fingerprint ad762ad89915

Doc tests: all passed. The docs are at step 8, System design: the data model and the data-flow graph are written; the page contracts and the threat model are next.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Passed: 0 blocking, 0 Major, 24 Minor |

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Done | L1 passed; B1: 1 Minor (leftover design code) |
| 2 Raw extraction | Done | L2, B2 passed |
| 3 Registry, 4 Check and arbitrate | Done | L3, B3 passed; L4, B4 not run (one platform) |
| 5 Flows | Done | FL-01 to FL-17 (FL-10 retired); L5, B5 passed |
| 6 Entities and states | Done | L6: 1 Minor (SM-E-02's table has no row for FL-16); B6 passed |
| 7 NFRs | Done | NFR-X-1 to NFR-X-17; L7, B7: 1 Minor each |
| 8 System design | Not done | Data model TB-01 to TB-33 (D-144) and data flows N-01 to N-14, DF-01 to DF-84 (D-151): L8, B8, B9 passed, L9 1 Minor; L9's threat-model half, L10 and B10 not reached |

## Next prompts
1. **Redraw the flagged features** (design cycle step 4, then prompt 9 and `publish-claude-design`). Redraw in `claude_design/`: F-019, the shared post in a conversation on P-09 and its grey box « Ce post n’est plus disponible. » (D-153); F-070, the sign-up expired state on P-27 with « Ton inscription a expiré. Reconnecte-toi pour la finir. », then P-01 (D-154); F-049, P-25 with a free « Lieu » field of 60 characters at most, no list of places and no « Aucun lieu trouvé. » (D-157); F-018, P-06 with « Favoris » as the one collection of a new account (D-161). Then run prompt 9 on them, which clears the flags, and publish. Open questions: F-019: what a post received in the friend's conversation looks like (F-019.a, D-044), not drawn on P-09; F-070: identifier rules: length, allowed characters, message when it is taken (D-145).
2. **Prompt 14: check the contracts** (step 8). Give it: the contracts `docs/pages/P-01.yaml` to `P-29.yaml`, with the registry, the data model TB-01 to TB-33, the data flows DF-01 to DF-84 and the state diagrams SM-E-02 to SM-E-16. It produces: the list of gaps between the contracts, the registry, the data model and the data flows, each fixed or asked.
3. **Threat model** (step 8, no prompt). Write it in « Conception système », from the 78 sensitive flows of « Flux sensibles » (D-151), the crash-report path to N-14 (NFR-X-5), the stores N-01 to N-03 and NFR-X-1 to NFR-X-9: for each sensitive flow and store, the threats, the protection and the NFR or decision that holds it. Open questions: L9-08 (check report question 1): keep the two dotted edges to N-14 outside the DF flows, as D-151 says, or add flows with no entity.
