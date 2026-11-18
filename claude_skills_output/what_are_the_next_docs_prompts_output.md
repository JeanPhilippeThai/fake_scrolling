# Next docs prompts

2026-11-18 · commit 747d722 · fingerprint 590ea182bb99

Doc tests: all passed. The docs are at step 1, Design.

Doc test run: `test-design-and-docs-conformity`, output `claude_skills_output/design_and_docs_check_output.md`, passed (0 blocking, 5 major, 4 minor).

## Where the docs are
| Step | Status | Evidence |
| --- | --- | --- |
| 1 Design | Not done | L1 has 1 Major (finding 1, L1-02: undrawn states); B1 has only a Minor |
| 2 Raw extraction | Not done | L2 has 1 Major (finding 2, L2-03); B2 passed |
| 3 Registry, 4 Check and arbitrate | Not done | L3 has 1 Major (finding 3, L3-05); B3 has 1 Major (finding 5, B3-02); L4 and B4 not run (one platform) |
| 5 Flows | Not done | L5, B5 not reached |
| 6 Entities and states | Not done | L6, B6 not reached |
| 7 NFRs | Not done | L7, B7 not reached |
| 8 System design | Not done | L8 to L10, B8 to B10 not reached; no stack decisions, code layout or threat model |

## Next prompts
1. **Prompt 8: sort the check's findings** (step 1). Give it: `claude_docs/registre-canonique.yaml` and finding 1 (L1-02) of `claude_skills_output/design_and_docs_check_output.md`, with its question 1 (which empty, loading and error states to draw for the 18 features listed, from F-001 to F-063). It produces: the owner's choice recorded as decision D-025, and `design_a_mettre_a_jour: true` on the features whose states will be drawn.
2. **Step 1 Design, no prompt: draw the missing states** (step 1). Write: the empty, loading and error states chosen in item 1, in the mobile Claude Design "Fake scrolling — app" (https://claude.ai/artifact/9fxJvdH8dPEDrrLKNWerJT), leaving the other screens untouched; section 2 of `claude_docs/prochains-prompts.md` has a ready request for it. Then import and promote the design so `claude_design/` holds it. It produces: a mobile design with the states of the main paths drawn.
3. **Prompt 9: design changed after the extraction** (step 4). Give it: the updated design from item 2, `claude_docs/registre-canonique.yaml` and `claude_docs/inventaire-des-ecrans.md`. It produces: `design_a_mettre_a_jour` removed where the design now matches, the remaining differences, and proposed IDs for new elements (after F-068, P-26).
4. **Prompt 8: sort the check's findings** (steps 2 to 4). Give it: findings 2 (L2-03), 3 (L3-05), 5 (B3-02) and 8 (T-01) of `claude_skills_output/design_and_docs_check_output.md`, with its questions 2 and 3, plus anything left open by item 3. It produces: F-055 naming the three Options lines and E-03 gaining a place field and an identified-people field (class A, applied directly), then decisions for the six "à confirmer" items and for the "refusé" status of E-09.
5. **Prompt 5: flows** (step 5). Give it: `claude_docs/registre-canonique.yaml` as updated by items 3 and 4; flow FL-01 "Se connecter avec un compte tiers ou un code e-mail" (P-01, P-02, F-001, F-003, F-007, F-008). It produces: the FL-01 section of the flows doc, and the features or pages the registry lacks for it. FL-02 to FL-16 follow, one run each (list in section 3 of `claude_docs/prochains-prompts.md`).
