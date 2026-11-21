# Next docs prompts

2026-11-21 · commit dacabcb · fingerprint 2621640d9cc1

The docs are not clean: fix them before running the next prompts.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Failed: not ready, 1 blocking finding (#2) |

## Fix first
1. **#2 L2-01** (P-16, P-05, P-06, P-07): the redrawn P-16 opens the panels « Commentaires », « Enregistrer dans une collection » and « Partager », which have no page ID; the same panels over the feed are P-05, P-06 and P-07, whose only entry is P-03. Prompt 9 on P-16: either give P-05, P-06 and P-07 the Recherche as a second entry (same panels, same features and states, their « Accueil — » names reworded), or propose new page IDs for the three panels of P-16; the owner approves the choice in prompt 9.
