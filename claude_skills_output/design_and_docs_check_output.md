# Top to bottom check · Fake scrolling · 2026-11-20

Documents: commit d2257dd · Mode: B (database built from d2257dd, fingerprint 75e465349a09d0b9)
Method followed: version of 2026-11-19 (method overview revision 90, describe revision 21, reference revision 24, check instruction revision 43)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Not ready: 1 blocking finding (#3)

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed | 0 | 0 | 0 |
| L1 Claude Design | findings | 0 | 1 | 0 |
| L2 Raw extraction | findings (L2-01 now passes: D-040) | 0 | 1 | 0 |
| L3 Registry | findings | 1 | 1 | 0 |
| L4 Canonical registry (platform merge) | not run: the app has one platform | 0 | 0 | 0 |
| L5 Flows | not reached | 0 | 0 | 0 |
| L6 Entity states and TLA+ | not reached | 0 | 0 | 0 |
| L7 NFRs | not reached | 0 | 0 | 0 |
| L8 Data model | not reached | 0 | 0 | 0 |
| L9 Data flows and threat model | not reached | 0 | 0 | 0 |
| L10 Page contracts | not reached | 0 | 0 | 0 |
| L11 Feature specs | not reached | 0 | 0 | 0 |
| L12 Planning and agent documents | not reached (L12-07: every path `CLAUDE.md` gives exists; markers and app command wait for the code) | 0 | 0 | 0 |
| B12 Planning and agent documents | not reached | 0 | 0 | 0 |
| B11 Feature specs | not reached | 0 | 0 | 0 |
| B10 Page contracts | not reached | 0 | 0 | 0 |
| B9 Data flows and threat model | not reached | 0 | 0 | 0 |
| B8 Data model | not reached | 0 | 0 | 0 |
| B7 NFRs | not reached | 0 | 0 | 0 |
| B6 Entity states and TLA+ | not reached | 0 | 0 | 0 |
| B5 Flows | not reached | 0 | 0 | 0 |
| B4 Canonical registry | not run: the app has one platform | 0 | 0 | 0 |
| B3 Per-platform registries | findings | 0 | 1 | 0 |
| B2 Raw extraction | passed | 0 | 0 | 0 |
| B1 Claude Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 0 | 1 |
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 2 | 2 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 1 blocking, 6 major, 4 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, G-01 and G-02 passed with no rows; G-03 passed with `--since 3e7c924` (the last checked docs: only additions, the 33 page states and D-040). Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 4 of the method: the registry is arbitrated (D-001 to D-040), the 33 drawn states now have page-state IDs (D-040). Step 5 (flows) has not started.

Since the last check (3e7c924): finding 2 of that report (L2-01, no page-state IDs) and finding 9 (inventory saying the states were not drawn) are fixed by D-040 and the updated inventory. The other 9 findings are unchanged; two new ones come from D-040 (#10, #11).

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L1-02 | Major | C | F-016, F-017, F-018, F-019.a, F-022, F-028, F-031, F-034, F-036, F-037, F-038, F-042, F-043, F-052, F-053, F-062 | Unchanged: the design has not changed since 3e7c924 (only `.claude-ai.json`). The 33 state artboards cover the 18 features of D-025; other screens show no loading, error or failure state, and no decision says they have none. Lists with no loading or error drawn: P-04 (F-022, only P-04.a « Aucune notification »), P-08 (F-037, only P-08.a « Aucune discussion »), P-10 (F-036), P-11 (F-043), P-14 (F-053), P-17 (F-062, only P-17.a « Aucun post »). Lists with loading and empty but no error: F-017 (P-05.a, P-05.b), F-038 (P-09.a, P-09.b), F-052 (P-15.a, P-15.b). Writes with no failure drawn: F-016 like, F-018 and F-031 enregistrer (P-06), F-019.a envoyer à un ami (P-07), F-028 accepter / refuser (P-04), F-034 ajouter un ami (P-11), F-042 envoyer une photo (P-09). Their `etats_ui` in `claude_docs/registry.md` list no such state. | — | See question 1. |
| 2 | L2-03 | Major | B | P-04, P-07, P-12, P-16; F-022, F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010.a | Unchanged: six « à confirmer » items of `claude_docs/inventaire-des-ecrans.md` have no open question and no decision in the registry. Line 111 P-04 « 3 demandes en démo (vraies demandes : à confirmer) »; line 164 P-07 « réception côté ami : à confirmer »; line 165 « copie réelle : à confirmer »; line 166 « feuille de partage du téléphone : à confirmer »; line 260 P-12 « Brouillon abandonné (sauvegarde : à confirmer) »; line 350 P-16 « Non dessinés (à confirmer : mêmes actions que P-03 ?) », which the registry states as a fact with no decision: F-010.a « Résultat de recherche : aucune action (like, commentaire, enregistrement, partage) ». Every other « à confirmer » of the inventory has its open question. | — | See question 2. |
| 3 | L3-11 | Blocking | A | D-037, D-038 | Unchanged: two decisions in force contradict each other on the registry's path. D-037 (`registry.md` line 1656): « Le registre importé s'appelle claude_docs/registry.yaml, nom fixé par la méthode ». D-038 (line 1661): « …importée en claude_docs/registry.md ». D-037 does not say it was replaced, unlike D-007 and D-008 (« Remplacée par D-017 »). D-038, `CLAUDE.md`, the registry's own intro (line 8, « importé en claude\_docs/registry.md ») and the method (`reference.md`: « Its import has the same name in every app: `claude_docs/registry.md` ») agree on `registry.md`, so D-037 is the stale one. | — | In the registry Claude Doc, mark D-037 « Remplacée en partie par D-038 » (the file name), keeping its rule on ids_retires and on digits; then import and promote. |
| 4 | L3-07 | Major | B | F-046, F-069, D-033 | Unchanged: two features take a photo for the post on the same page P-12 with the same entity E-04: F-046 « Prendre une photo » (« Bouton appareil photo », `sans effet`, question « Écran de prise de vue ») and F-069 « Prendre une photo pour un post » (« Ouvrir l'appareil photo » from P-12.a). F-069 asks « Bouton seulement dans la galerie vide, ou aussi au-dessus de la grille ? », which is where F-046's button is (`Compose.dc.html`, `aria-label="Appareil photo"`). D-033's reason « aucune feature existante ne prend de photo » overlooks F-046. | — | See question 3. |
| 5 | B3-02 | Major | B | E-09, F-028.a, D-015 | Unchanged: E-09 lists `statut (en attente, demandé, ami, refusé)` (`registry.md` line 1405), a status the design never shows and that F-028.a rules out: « Refuser : la demande est supprimée et la ligne disparaît ». | — | See question 4. |
| 6 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | Unchanged: `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 344 « Fermer la story ») that nothing on the Accueil opens, and a search state (line 359 `searchOpen`, line 964 `searchOn`) with no entry. `Profile.dc.html` computes values it never shows (line 523 `leaves`, line 598 `usageHint`). No decision records them as unused design code. | — | See question 5. |
| 7 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged: the Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 249, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 6. |
| 8 | T-01 | Major | A | E-03, F-048, F-049, P-13, P-24, P-25 | Unchanged: inventory P-13 shows « Identifier des personnes · Personnes identifiées » and « Ajouter un lieu · Lieu »; F-048 and F-049 list `entites: [E-03]` with `écriture`, but E-03 `champs` (`registry.md` lines 1344-1356) holds neither identified people nor a place. The data model (prompt 11) would miss both. | — | Add the two fields to E-03 `champs` in the registry Claude Doc (the owner confirms the names). |
| 9 | T-04 | Major | A | D-040, P-02.b, F-008 | New. D-040's rule: « Un état liste seulement la feature dont il montre l'état, plus celle que lance un bouton propre à l'état ». The code-expired state shows a button of its own that launches F-008: `Etat-P02-code-expire.dc.html` « Ce code a expiré. Demande-en un nouveau. » then `<button>Renvoyer un code`; F-008 `etats_ui` (line 415) « code expiré : bouton « Renvoyer un code » à la place de « Se connecter » ». Yet P-02.b lists `features: [F-007]` only (line 55), and F-008 lists `pages: [P-02]` (line 406, `where F-008` → feature_page P-02 only). The inventory's « Renvoyer le code » row (line 51) does not cite P-02.b either. The three other states with such a button follow the rule (P-08.a F-034, P-12.a F-069, P-17.a F-026). | — | In the registry Claude Doc, add F-008 to P-02.b `features` and P-02.b to F-008 `pages`; in the inventory, add « code expiré (P-02.b) » to the « Renvoyer le code » row. Then import and promote. |
| 10 | T-04 | Minor | C | D-018, F-019, F-062, P-17.a | Unchanged: D-018's reason is « L'app n'explique nulle part ailleurs le flou ni le charabia », but the design still does: `Main.dc.html` line 925 « Lien copié. Il mène à une version floutée. », line 926 « Partagé, flouté comme toujours. »; `Profile.dc.html` line 98 « Tes posts, tels que les voient tes amis »; `Etat-P17-posts-vide.dc.html` « Tes posts s’affichent ici, floutés, avec leurs jours restants. » (also in F-062 `etats_ui`). D-018's choice itself is applied. | — | See question 7. |
| 11 | T-04 | Minor | A | D-040, P-03.b, P-03.c | New. D-040 says the states are « lettrés dans l'ordre du canvas », but P-03's are not: in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-71). Every other page's letters follow the canvas. | — | Keep the letters (IDs are never renumbered) and reword D-040: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. |

## Questions for the owner

1. **States still undrawn (finding 1, class C).** D-025 covered 18 features; 16 more show no loading, error or failure state.
   - a. Draw them all in `claude_design/`, as for D-025, then run prompt 9 and give each new artboard a page-state ID (D-040).
   - b. Record one decision that applies D-027 (error in place with « Réessayer ») and D-028 (ring) to them by analogy, as D-036 did, and draw nothing more.
   - c. Draw only the network writes (like, save, send to a friend, accept or refuse, add a friend, send a photo) and record a decision for the lists.
2. **Dropped « à confirmer » items (finding 2, class B).** Real invitations on P-04, reception of a shared post, real link copy, the phone's share sheet, saving an abandoned draft, actions on a search result (P-16).
   - a. Add each as an open question on its feature (F-022 or F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010).
   - b. Settle them now, one decision each; for P-16, confirm « no actions on a search result » or give it P-03's actions.
   - c. Leave the « real or generated » ones to the system design, and settle only P-16 and the draft now.
3. **Two camera features (finding 4, class B).**
   - a. Merge F-069 into F-046 as a variant (« depuis la galerie vide »), retire F-069 in ids_retires, and reword D-033.
   - b. Keep both, and reword F-046 or F-069 so that their behaviors differ (e.g. F-046 stays « sans effet » until a camera screen is drawn); correct D-033's reason.
   - c. Remove the camera button above the grid from the design and retire F-046.
4. **Refused invitation (finding 5, class B).**
   - a. Deleted: remove « refusé » from E-09's statuses.
   - b. Kept as « refusé » (to stop repeated requests): reword F-028.a and say what the sender sees.
   - c. Deleted for the receiver, still « demandé » for the sender: record it as a decision.
5. **Leftover code in the design (finding 6, class C).**
   - a. Remove the story player and search state from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
6. **Wording of the support offer (finding 7, class C).**
   - a. « Une heure passée ici. » everywhere.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.
7. **Blur wording after D-018 (finding 10, class C).**
   - a. Remove the mentions of blur from the two toasts, the Profil title and the P-17.a empty state, so that D-018's reason holds.
   - b. Keep them and reword D-018's reason: only the two long explanations were removed.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 26 pages, 33 page states, 63 features, 20 variants, 17 entities, 40 decisions, 8 retired IDs. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read in full: `claude_docs/registry.md`; `claude_docs/inventaire-des-ecrans.md` through its diff since 3e7c924 and a search of every « à confirmer » and « dessiné »; `canvas.json` (titles and positions of all 40 artboards); the method files the check needs.
- L2-01: the 33 artboard files, the 33 page-state rows of the inventory and the 33 `page_state` IDs of the database match one to one (no file twice, none missing).
- Design: unchanged since 3e7c924 (only `.claude-ai.json`), so the 7 interactive screens were not re-read in full; the earlier findings were re-checked by grep at the lines quoted, and the buttons of all 33 state artboards were listed to check D-040's rule.
- G-03: run as a query with `--since 3e7c924`.
- T-04 ran on D-040 (new); D-001 to D-039 were checked in earlier runs and have not changed. T-01 ran as far as entity fields only. T-02, T-03 and U-01 to U-03 need later layers.
- L1-03: `claude_design/` is taken as the current design export; it was not compared with the live Claude Design canvas.

## Hand-off to the code check
Commit checked: d2257dd. Verdict: not ready, with 1 blocking finding (#3).

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

Documents the code checker should not trust yet: decision D-037 (finding 3); and, with Major findings, P-02.b and F-008's pages (finding 9), and E-03's and E-09's fields (findings 5 and 8).
