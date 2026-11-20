# Top to bottom check · Fake scrolling · 2026-11-20

Documents: commit 620ad29 · Mode: B (database built from 620ad29, fingerprint d4cd4b57746663fa)
Method followed: version of 2026-11-20 (method overview revision 90, describe revision 21, reference revision 26, check instruction revision 50)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed | 0 | 0 | 0 |
| L1 Design | findings (L1-03 passed: the 66 files of `claude_design/` match `.claude-ai.json`, so the 25 new artboards were published; L1-04 passed: no feature carries `design_a_mettre_a_jour`) | 0 | 1 | 0 |
| L2 Raw extraction | findings (L2-01 passed: 58 state artboards, 58 page states, one each, titles and features match) | 0 | 1 | 0 |
| L3 Registry | findings | 0 | 1 | 0 |
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
| B1 Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 0 | 1 |
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 2 | 3 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 0 blocking, 6 major, 5 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, G-01 and G-02 passed with no rows; G-03 passed with `--since ad1922e` (the last checked docs: 25 page states and D-041, D-042 added, no ID removed). Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 4 of the method: the registry is arbitrated (D-001 to D-042), the 58 drawn states have page-state IDs (D-040, D-041). Step 5 (flows) has not started.

Since the last check (ad1922e): commit 57c85f3 drew 25 state artboards (D-041, D-042), gave them the page states P-03.e to P-17.c, and updated the `pages` and `etats_ui` of the 16 features, the inventory and `canvas.json`. Old finding 1 (L1-02, the 16 features with no loading, error or failure state) is fixed: every new artboard's title, page, feature and copy matches its registry entry and inventory row. One L1-02 gap remains outside D-041's list (finding 1). Old findings 2 to 10 are unchanged, with new line numbers; finding 9 gains the two new P-17 artboards. Finding 11 is new (D-042 and F-028.a).

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L1-02 | Major | C | P-24, P-25, P-07, F-048, F-049, F-019.a, F-016.b | D-041 drew 16 features; these lists, which read data, still show no loading or error state, and no decision says they have none. P-24 « Identifier un ami » (inventory line 550) « 8 amis en démo ; vraie liste d'amis : à confirmer », states « Case vide ; cochée en vert » and « Aucun ami trouvé. » only; P-25 « Choisir un lieu » (line 562) « vraie recherche de lieux : à confirmer », states « Lieu choisi coché » and « Aucun lieu trouvé. » only; P-07's row of friends (F-019.a, line 178) shows no loading of the row. `Compose.dc.html` and `Main.dc.html` hold no « chargement » or « Réessayer ». F-016.b (like of a comment, P-05, line 138 « Vide gris ; plein rouge quand liké ») has no failure drawn; D-042 puts the failure message « en bas du fil », which P-05 does not have. | — | See question 1. |
| 2 | L2-03 | Major | B | P-04, P-07, P-12, P-16; F-022, F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010.a | Unchanged: six « à confirmer » items of `claude_docs/inventaire-des-ecrans.md` have no open question and no decision in the registry. Line 113 P-04 « 3 demandes en démo (vraies demandes : à confirmer) »; line 178 P-07 « réception côté ami : à confirmer »; line 179 « copie réelle : à confirmer »; line 180 « feuille de partage du téléphone : à confirmer »; line 300 P-12 « Brouillon abandonné (sauvegarde : à confirmer) »; line 398 P-16 « Non dessinés (à confirmer : mêmes actions que P-03 ?) », which the registry states as a fact with no decision: F-010.a (`registry.md` line 545) « Résultat de recherche : aucune action (like, commentaire, enregistrement, partage) ». Every other « à confirmer » of the inventory has its open question. | — | See question 2. |
| 3 | L3-07 | Major | B | F-046, F-069, D-033 | Unchanged: two features take a photo for the post on the same page P-12 with the same entity E-04: F-046 « Prendre une photo » (line 1081; « Bouton appareil photo », `sans effet`, question « Écran de prise de vue ») and F-069 « Prendre une photo pour un post » (line 1429; « Ouvrir l'appareil photo » from P-12.a). F-069 asks « Bouton seulement dans la galerie vide, ou aussi au-dessus de la grille ? » (line 1443), which is where F-046's button is (`Compose.dc.html`, `aria-label="Appareil photo"`). D-033's reason (line 1764) « aucune feature existante ne prend de photo » overlooks F-046. | — | See question 3. |
| 4 | B3-02 | Major | B | E-09, F-028.a, D-015 | Unchanged: E-09 lists `statut (en attente, demandé, ami, refusé)` (`registry.md` line 1532), a status the design never shows and that F-028.a rules out (line 837): « Refuser : la demande est supprimée et la ligne disparaît ». | — | See question 4. |
| 5 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | Unchanged: `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 344 « Fermer la story ») that nothing on the Accueil opens, and a search state (line 359 `searchOpen`, line 964 `searchOn`) with no entry. `Profile.dc.html` computes values it never shows (line 523 `leaves`, line 598 `usageHint`). No decision records them as unused design code. | — | See question 5. |
| 6 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged: the Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 249, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 6. |
| 7 | T-01 | Major | A | E-03, F-048, F-049, P-13, P-24, P-25 | Unchanged: inventory P-13 shows « Identifier des personnes · Personnes identifiées » (line 327) and « Ajouter un lieu · Lieu » (line 328); F-048 and F-049 list `entites: [E-03]` with `écriture`, but E-03 `champs` (`registry.md` lines 1470-1484) holds neither identified people nor a place. The data model (prompt 11) would miss both. | — | Add the two fields to E-03 `champs` in the registry Claude Doc (the owner confirms the names). |
| 8 | T-04 | Major | A | D-040, P-02.b, F-008 | Unchanged. D-040's rule (line 1798): « Un état liste seulement la feature dont il montre l'état, plus celle que lance un bouton propre à l'état ». The code-expired state shows a button of its own that launches F-008: `Etat-P02-code-expire.dc.html` line 40 « Ce code a expiré. Demande-en un nouveau. » then line 43 « Renvoyer un code »; F-008 `etats_ui` (line 515) « code expiré : bouton « Renvoyer un code » à la place de « Se connecter » ». Yet P-02.b lists `features: [F-007]` only (line 55), and F-008 lists `pages: [P-02]` (line 506). The inventory's « Renvoyer le code » row (line 51) does not cite P-02.b either. The other states with such a button follow the rule (P-08.a F-034, P-12.a F-069, P-17.a F-026). | — | In the registry Claude Doc, add F-008 to P-02.b `features` and P-02.b to F-008 `pages`; in the inventory, add « code expiré (P-02.b) » to the « Renvoyer le code » row. Then import and promote. |
| 9 | T-04 | Minor | C | D-018, F-019, F-062, P-17.a, P-17.b, P-17.c | D-018's reason (line 1689) is « L'app n'explique nulle part ailleurs le flou ni le charabia », but the design still does: `Main.dc.html` line 925 « Lien copié. Il mène à une version floutée. », line 926 « Partagé, flouté comme toujours. »; `Profile.dc.html` line 98 « Tes posts, tels que les voient tes amis », now repeated in the new `Etat-P17-posts-chargement.dc.html` line 59 and `Etat-P17-posts-erreur.dc.html` line 57; `Etat-P17-posts-vide.dc.html` line 60 « Tes posts s’affichent ici, floutés, avec leurs jours restants. » (also in F-062 `etats_ui`, line 1350). D-018's choice itself is applied. | — | See question 7. |
| 10 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 says the states are « lettrés dans l'ordre du canvas », but P-03's are not: in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-71). Every other page's letters follow the canvas, including the 25 new states. | — | Keep the letters (IDs are never renumbered) and reword D-040: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. |
| 11 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | D-042 (line 1808): « Accepter ou refuser une invitation (F-028) […] montrent l'anneau dans le bouton (D-028), puis l'erreur sur place avec « Réessayer » ». F-028 `etats_ui` (line 842) says only « réponse en cours : anneau dans « Accepter » », and the inventory's « Refuser une invitation » row (line 115) still lists « La ligne disparaît » alone, while « Accepter » (line 114) cites P-04.d and P-04.e. Only Accepter is drawn (`Etat-P04-invitation-envoi.dc.html`). D-036 is the precedent for writing such an analogy down (F-001 `etats_ui` « mêmes états pour Apple (F-001.a), par analogie (D-036) »). | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and in the inventory, the same note on the « Refuser une invitation » row. Then import and promote. |

## Questions for the owner

1. **Lists still with no loading or error state (finding 1, class C).** The friends list of P-24, the place search of P-25, the row of friends of P-07, and the failed like of a comment (F-016.b).
   - a. Draw them as for D-041 (loading and error of P-24 and P-25, the P-07 row, the comment-like failure on P-05), then run prompt 9 and give each new artboard a page-state ID (D-040).
   - b. Record one decision that applies D-027 and D-028 to them by analogy, as D-036 did, and say where the comment-like failure message shows on P-05; draw nothing more.
   - c. Record that P-24 and P-25 read local or already loaded data and have no loading or error state, and settle only the comment-like failure.
2. **Dropped « à confirmer » items (finding 2, class B).** Real invitations on P-04, reception of a shared post, real link copy, the phone's share sheet, saving an abandoned draft, actions on a search result (P-16).
   - a. Add each as an open question on its feature (F-022 or F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010).
   - b. Settle them now, one decision each; for P-16, confirm « no actions on a search result » or give it P-03's actions.
   - c. Leave the « real or generated » ones to the system design, and settle only P-16 and the draft now.
3. **Two camera features (finding 3, class B).**
   - a. Merge F-069 into F-046 as a variant (« depuis la galerie vide »), retire F-069 in ids_retires, and reword D-033.
   - b. Keep both, and reword F-046 or F-069 so that their behaviors differ (e.g. F-046 stays « sans effet » until a camera screen is drawn); correct D-033's reason.
   - c. Remove the camera button above the grid from the design and retire F-046.
4. **Refused invitation (finding 4, class B).**
   - a. Deleted: remove « refusé » from E-09's statuses.
   - b. Kept as « refusé » (to stop repeated requests): reword F-028.a and say what the sender sees.
   - c. Deleted for the receiver, still « demandé » for the sender: record it as a decision.
5. **Leftover code in the design (finding 5, class C).**
   - a. Remove the story player and search state from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
6. **Wording of the support offer (finding 6, class C).**
   - a. « Une heure passée ici. » everywhere.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.
7. **Blur wording after D-018 (finding 9, class C).**
   - a. Remove the mentions of blur from the two toasts, the Profil title (on P-17 and its three state artboards) and the P-17.a empty state, so that D-018's reason holds.
   - b. Keep them and reword D-018's reason: only the two long explanations were removed.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 26 pages, 58 page states, 63 features, 20 variants, 17 entities, 42 decisions, 8 retired IDs. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read: the diff of `claude_docs/` and `claude_design/` since ad1922e (25 artboards, `canvas.json`, the inventory, `registry.md`); `registry.md` and the inventory in full; the method files the check needs.
- L2-01 and D-040: every state artboard of `canvas.json` was matched by script to its inventory row and registry page state (page, feature, name), and letter order was compared with canvas order; only P-03 differs (finding 10).
- The 25 new artboards: visible text, `aria-label` and `role` extracted and compared with each feature's `etats_ui` and the inventory; all match.
- L1-03: `claude_design/` was checked against `fake-scrolling-app/.claude-ai.json` (66 files, no hash differs); the live canvas on claude.ai was not opened, as the check requires.
- L3-11: D-041 and D-042 read against D-025 to D-028, D-036 and D-040. D-042 gives like and save a 2 s message with no « Réessayer », where D-027 prefers an error in place; D-027's scope (`impacte`) holds neither F-016 nor F-018 and D-042 gives its reason, so this was not counted as a contradiction.
- Design: older interactive screens were not re-read in full; every older finding's evidence was re-checked by grep at the lines quoted.
- G-03: run as a query with `--since ad1922e`.
- T-04 ran on D-040, D-041 and D-042; T-01 ran as far as entity fields only. T-02, T-03 and U-01 to U-03 need later layers.

## Hand-off to the code check
Commit checked: 620ad29. Verdict: ready for the code check, with no blocking finding.

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

No document carries an open Blocking finding. The Major findings still touch P-02.b and F-008's pages (finding 8), E-03's and E-09's fields (findings 4 and 7), F-046 and F-069 (finding 3), the six « à confirmer » items (finding 2) and the lists of P-24, P-25 and P-07 (finding 1): settle them before the steps that build on them.
