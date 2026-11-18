# Top to bottom check · Fake scrolling · 2026-11-18

Documents: commit 747d722 · Mode: A (no registry database: `.registry/registry.db` and `tools/registry-db/` do not exist yet)
Method followed: version of 2026-11-17 (method overview revision 88, check instruction revision 25)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registre-canonique.yaml` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed | 0 | 0 | 0 |
| L1 Claude Design | findings | 0 | 1 | 0 |
| L2 Raw extraction | findings | 0 | 1 | 0 |
| L3 Registry | findings | 0 | 1 | 1 |
| L4 Canonical registry (platform merge) | not run: one platform only, nothing was merged | 0 | 0 | 0 |
| L5 Flows | not reached | 0 | 0 | 0 |
| L6 Entity states and TLA+ | not reached | 0 | 0 | 0 |
| L7 NFRs | not reached | 0 | 0 | 0 |
| L8 Data model | not reached | 0 | 0 | 0 |
| L9 Data flows and threat model | not reached | 0 | 0 | 0 |
| L10 Page contracts | not reached | 0 | 0 | 0 |
| L11 Feature specs | not reached | 0 | 0 | 0 |
| L12 Planning and agent documents | not reached | 0 | 0 | 0 |
| B12 Planning and agent documents | not reached | 0 | 0 | 0 |
| B11 Feature specs | not reached | 0 | 0 | 0 |
| B10 Page contracts | not reached | 0 | 0 | 0 |
| B9 Data flows and threat model | not reached | 0 | 0 | 0 |
| B8 Data model | not reached | 0 | 0 | 0 |
| B7 NFRs | not reached | 0 | 0 | 0 |
| B6 Entity states and TLA+ | not reached | 0 | 0 | 0 |
| B5 Flows | not reached | 0 | 0 | 0 |
| B4 Canonical registry | not run: one platform only | 0 | 0 | 0 |
| B3 Per-platform registries | findings | 0 | 1 | 0 |
| B2 Raw extraction | passed | 0 | 0 | 0 |
| B1 Claude Design | findings | 0 | 0 | 1 |
| G Global rules | findings (G-05 not run: mode A) | 0 | 0 | 1 |
| T Traces from the top down | findings (T-01 and T-04 only as far as the registry; T-02 and T-03 not reached) | 0 | 1 | 1 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 0 blocking, 5 major, 4 minor.

The project is at step 4 of the method (registry checked and arbitrated, decisions D-001 to D-024). Step 5 (flows) has not started, so every layer from L5 down is "not reached", not failed.

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L1-02 | Major | C | F-001, F-003, F-007, F-009, F-015, F-017, F-022, F-030, F-037, F-038, F-041, F-044, F-051, F-052, F-056, F-058, F-062, F-063 | The design draws no loading, error or empty state for these, and no decision says they have none. `claude_docs/registre-canonique.yaml`, e.g. F-001 "États chargement et erreur non dessinés", F-007 "États code faux et code expiré non dessinés", F-017 "États vide et chargement non dessinés", F-051 "États envoi, succès et erreur non dessinés", F-063 "Échec non dessiné". `claude_docs/inventaire-des-ecrans.md` says the same per page ("aucun chargement ni erreur dessiné"). | — | See question 1. `claude_docs/prochains-prompts.md` section 2 already plans this pass. |
| 2 | L2-03 | Major | B | P-04, P-07, P-12, P-16; F-022, F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010.a | Six items marked "à confirmer" in `claude_docs/inventaire-des-ecrans.md` have no open question and no decision in the registry: P-04 "3 demandes en démo (vraies demandes : à confirmer)"; P-07 "réception côté ami : à confirmer", "copie réelle : à confirmer", "feuille de partage du téléphone : à confirmer"; P-12 "Brouillon abandonné (sauvegarde : à confirmer)"; P-16 "Non dessinés (à confirmer : mêmes actions que P-03 ?)". For P-16 the registry states the answer as a fact without a decision: F-010.a "Résultat de recherche : aucune action (like, commentaire, enregistrement, partage)". | — | See question 2. |
| 3 | L3-05 | Major | A | P-20, F-055 | The three lines of the Options panel ("Gérer son compte" opens P-21, "Ouvrir Premium" opens P-22, "Régler l'interface" opens P-23 in the inventory, section P-20) are named by no feature. P-20 lists `[F-024, F-027.b, F-055]` and F-055 reads "Engrenage du Profil puis panneau sur la moitié gauche de l'écran." The imported registry holds no "Regroupements effectués" note saying where they went. Flows to P-21, P-22 and P-23 will have no feature ID to cite for that step. | — | Name the three lines in F-055's description (or in a merge note), without creating an ID unless the owner asks for one. |
| 4 | L3-01 | Minor | A | D-001 to D-024 | Decisions use three digits (`- id: D-001`) where the method's ID table gives `D-NN` (`D-07`). The method's own prompt 10 template uses `D-001`, so the method is not consistent either. | — | Keep the IDs (never renumber); align the method's ID table, or note the three-digit format once. |
| 5 | B3-02 | Major | B | E-09, F-028.a, D-015 | E-09 lists a status the design never shows and another registry line rules out: `statut (en attente, demandé, ami, refusé)` against F-028.a "Refuser : la demande est supprimée et la ligne disparaît". The design only removes the line (inventory P-04: "La ligne disparaît"). | — | See question 3. |
| 6 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | `claude_design/fake-scrolling-app/project/Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, "Fermer la story") and a search state (line 359 `searchOpen`, line 966 `openSearch`) that nothing on the Accueil artboard opens. The registry places stories on P-08 to P-10 and search on P-14 to P-16 only. No decision records their removal from the Accueil. | — | See question 4. |
| 7 | G-04 | Minor | C | F-015, F-015.a, P-03, P-22 | The same offer has two wordings in the design: `Main.dc.html` line 70 "Plus d’une heure passée ici." (Premium post, P-03) and `Profile.dc.html` line 249 "Une heure passée ici." (P-22). The inventory quotes only the P-22 one. | — | See question 5. |
| 8 | T-01 | Major | A | E-03, F-048, F-049, P-13, P-24, P-25 | Two data items the design shows and features write have no field in their entity. Inventory P-13: "Identifier des personnes · Personnes identifiées" and "Ajouter un lieu · Lieu". F-048 and F-049 both list `entites: [E-03]` with `écriture`, but E-03 `champs` holds neither a place nor identified people (auteur, type, légende, counters, audience, jours restants, palette, lien). The data model (prompt 11) would miss both columns. | — | Add the two fields to E-03 `champs` (owner confirms the names). |
| 9 | T-04 | Minor | C | D-018, F-019, F-062 | D-018's reason is "L'app n'explique nulle part ailleurs le flou ni le charabia", but the design still does: `Main.dc.html` line 925 "Lien copié. Il mène à une version floutée.", line 926 "Partagé, flouté comme toujours."; `Profile.dc.html` "Tes posts, tels que les voient tes amis". D-018's choice itself (the two panel texts) is applied: neither panel holds an explanation any more. | — | See question 6. |

## Questions for the owner

1. **Undrawn states (finding 1, class C).** Which empty, loading and error states get drawn before the flows?
   - a. Draw them all now in the design, then run prompt 9.
   - b. Draw only the ones on the main paths (sign-in, publish, pay, delete account); record a decision that the others wait for their feature's spec.
   - c. Record a decision that some screens have none (for example, always-filled demo lists), and draw the rest.
2. **Dropped "à confirmer" items (finding 2, class B).** For each of the six: real invitations on P-04, reception of a shared post, real link copy, the phone's share sheet, saving an abandoned draft, actions on a search result (P-16).
   - a. Add each as an open question on its feature (F-022 or F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010).
   - b. Settle them now and record one decision per answer; for P-16, either confirm "no actions on a search result" as a decision or give the post the same actions as P-03.
   - c. Move the "real or generated" ones to the system-design question already planned ("ce qui doit être réel et ce qui reste généré") and settle only P-16 and the draft now.
3. **Refused invitation (finding 5, class B).** What happens to a refused friend request?
   - a. It is deleted: remove "refusé" from E-09's statuses.
   - b. It is kept with the status "refusé" (for example to stop repeated requests): reword F-028.a and say what the sender sees.
   - c. Deleted for the receiver, kept as "demandé" for the sender: record it as a decision.
4. **Leftover story player and search in the Accueil artboard (finding 6, class C).**
   - a. Remove both from `Main.dc.html`: they are leftovers.
   - b. Keep the story player and give the Accueil an entry to it; that adds P-03 to F-036 through prompt 9.
   - c. Leave them and record a decision that they are unused design code, like the demo-only items of D-020.
5. **Wording of the support offer (finding 7, class C).**
   - a. "Une heure passée ici." on both screens.
   - b. "Plus d’une heure passée ici." on both screens.
   - c. Keep both on purpose and note the difference on F-015.a.
6. **Blur wording after D-018 (finding 9, class C).**
   - a. Remove the mentions of blur from the two confirmation messages (and decide for the Profil title), so D-018's reason holds.
   - b. Keep them and reword D-018's reason: only the two long explanations were removed.

## What was sampled
Mode A, read in full: `claude_docs/registre-canonique.yaml`, `claude_docs/inventaire-des-ecrans.md`, `claude_docs/prochains-prompts.md`, and the method files it needs. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Registry links (L3-01 to L3-04, L3-08, L3-10, G-01, G-02): every ID and every link checked by script, not sampled: 2 roles, 26 pages, 62 features, 20 variants, 17 entities, 24 decisions. No duplicate, no broken link either way, no unused or unknown role. A page lists the variant ID instead of the base ID where only the variant shows (12 cases), as prompt 2's format allows.
- G-03: the six missing feature numbers (F-013, F-023, F-029, F-032, F-035, F-064) and the variants F-058.a and F-067.a are each explained by a decision (D-001, D-002, D-015, D-017, D-018, D-020, D-021).
- Design against the inventory (L2-01, L3-05, B2-01, B3-01): every visible text, accessible label and conditional view of the seven artboards in `claude_design/fake-scrolling-app/project/` was extracted and matched to the 26 pages; all 26 pages map to one view each. Numbers were spot-checked, not all: 30 s resend, 6-digit code, 150/16/80 character limits, cycle durations 1 to 30 min, 18 results, palette modulo 5, Premium post 1 in 20 after 1 h, 3 demo invitations. All matched.
- All 32 "à confirmer" items were traced to the registry (L2-03).
- T-04 ran on all 24 decisions against the registry and the design. T-01 ran as far as entity fields only, for every feature that writes data; columns, components and flows do not exist yet. T-02, T-03 and U-01 to U-03 need later layers.
- L1-03: `claude_design/` is taken as the current design export (there is no `design/` folder); it was not compared with the live Claude Design artifact.
- L3-05 and L3-12: the imported registry is the YAML only; its "Regroupements effectués" and "Cas ambigus à trancher" sections are not in `claude_docs/`. The 11 ambiguous cases were checked through decisions D-013 to D-023, which settle "Cas 1" to "Cas 11".
- Not yet required at this step, so not counted as findings: product brief, backlog, questions register, workarounds log, cross-cutting page, and a `CLAUDE.md` that points to the sources of truth (it holds only the git workflow today).

## Hand-off to the code check
Commit checked: 747d722. Verdict: ready for the code check, with no blocking finding.

There is nothing for the code checker to verify yet: no feature is at step 10, and there is no code.

| Expectation | From the documents today |
| --- | --- |
| One folder per canonical feature at step 10 or beyond | None: no feature has a spec |
| A test for every rule (`BR`) and criterion (`AC`) | None: no spec, no cross-cutting page |
| A screenshot for every visible criterion per platform | None: no proof block |
| A test for every model-checker failure trace | None: no TLA+ model |
| Every table and column of the data model | None: no data model |
| Every event named in a spec | None |
| One flag per feature not fully released | None: no backlog |
| The import rules | None: no code structure or lint config yet |

Documents the code checker should not rely on until their findings are settled: E-03's and E-09's fields in the registry (findings 5 and 8), and the P-16 variant F-010.a (finding 2).
