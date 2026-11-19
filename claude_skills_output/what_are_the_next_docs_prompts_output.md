# Next docs prompts

2026-11-18 · commit 747d722 · fingerprint 8da892d85db6

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
1. **Prompt 8: sort the check's findings** (steps 2 to 4). Give it: findings 2 (L2-03), 3 (L3-05), 5 (B3-02) and 8 (T-01) of `claude_skills_output/design_and_docs_check_output.md`, with its questions 2 and 3, plus anything left open by prompt 9. It produces: F-055 naming the three Options lines and E-03 gaining a place field and an identified-people field (class A, applied directly), then decisions for the six "à confirmer" items and for the "refusé" status of E-09.
2. **Prompt 5: flows** (step 5). Give it: `claude_docs/registry.md` as updated by prompt 9 and item 1; flow FL-01 "Se connecter avec un compte tiers ou un code e-mail" (P-01, P-02, F-001, F-003, F-007, F-008). It produces: the FL-01 section of the flows doc, and the features or pages the registry lacks for it. FL-02 to FL-16 follow, one run each (a proposal; for a background job, ask for its trigger instead of the sequence):
   - FL-02 Publier un post dans le fil ou en story (P-12, P-13, P-24 à P-26, F-044 à F-051, F-068)
   - FL-03 Réagir à un post : liker, commenter, enregistrer, partager (P-03, P-05 à P-07, F-016 à F-019, F-030, F-031)
   - FL-04 Ajouter un ami, puis accepter ou refuser l'invitation (P-08, P-11, P-04, F-034, F-043, F-028)
   - FL-05 Discuter avec un ami et voir sa story (P-08 à P-10, F-036 à F-042)
   - FL-06 Rechercher des posts et ouvrir un résultat (P-14 à P-16, F-052 à F-054)
   - FL-07 Soutenir le projet après 1 h d'utilisation (P-03, P-22, F-015, F-065)
   - FL-08 Modifier son profil et sa photo (P-17 à P-19, F-056, F-058)
   - FL-09 Régler le minuteur, l'icône et les carrousels de pause (P-17, P-23, F-060, F-061, F-066, F-067)
   - FL-10 Supprimer son compte (P-20, P-21, F-063)
   - FL-11 Griser l'app cycle après cycle, job (F-024, F-059, E-14)
   - FL-12 Compter le temps d'utilisation et ouvrir l'offre de soutien, job (F-015, F-065, E-15)
   - FL-13 Composer le fil : posts de pause, Inspire / Expire, offre de soutien, job (F-009, F-012.a, F-014, F-015.a)
   - FL-14 Faire expirer les posts, job (F-062, E-03)
   - FL-15 Flouter les photos et brouiller les textes après l'envoi, job (F-030, F-041, F-051, F-058)
   - FL-16 Faire expirer le code de connexion et autoriser le renvoi, job (F-007, F-008, E-02)
