# Top to bottom check · Fake scrolling · 2026-11-19

Documents: commit 3e7c924 · Mode: B (database built from 3e7c924, fingerprint 83187fa8f2c890d9)
Method followed: version of 2026-11-19 (method overview revision 90, check instruction revision 42)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Not ready: 2 blocking findings (#2, #4)

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed | 0 | 0 | 0 |
| L1 Claude Design | findings | 0 | 1 | 0 |
| L2 Raw extraction | findings | 1 | 1 | 0 |
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
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 1 | 1 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 2 blocking, 5 major, 3 minor (finding 9 follows from finding 2 and is not counted).

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, G-01 and G-02 passed with no rows; every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 4 of the method: the registry is arbitrated (D-001 to D-039), the 18 states of D-025 are drawn and prompt 9 ran on them (D-033 to D-036). Step 5 (flows) has not started.

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L1-02 | Major | C | F-016, F-017, F-018, F-019.a, F-022, F-028, F-031, F-034, F-036, F-037, F-038, F-042, F-043, F-052, F-053, F-062 | The 33 state artboards cover exactly the 18 features of D-025 (all 18 checked against `canvas.json`). Other screens still show no loading, error or failure state, and no decision says they have none. Lists with no loading or error drawn: P-04 (F-022, only « Aucune notification »), P-08 (F-037, only « Aucune discussion »), P-10 (F-036), P-11 (F-043), P-14 (F-053), P-17 (F-062, only « Aucun post »). Lists with loading and empty drawn but no error: F-017 (P-05), F-038 (P-09), F-052 (P-15). Writes with no failure drawn: F-016 like, F-018 and F-031 enregistrer (P-06), F-019.a envoyer à un ami (P-07), F-028 accepter / refuser (P-04), F-034 ajouter un ami (P-11), F-042 envoyer une photo (P-09; F-041's « Non envoyé. » covers text only). Their `etats_ui` in `claude_docs/registry.md` list no such state. | — | See question 1. |
| 2 | L2-01 | Blocking | A | P-01, P-02, P-03, P-04, P-05, P-08, P-09, P-12, P-13, P-15, P-17, P-18, P-19, P-21, P-22 | The design has 40 artboards (`claude_design/fake-scrolling-app/project/canvas.json`): the 7 interactive screens, which hold the 26 pages, and 33 static state artboards titled by page and feature, e.g. « P-02 · F-007 · Code faux », « P-12 · F-044 · Galerie vide ». The method now makes each of them a page state with its own ID (`workflow_docs/method/reference.md`: « A page state is a screen drawn as its own artboard that belongs to one page: … an empty, loading or error view. Its ID is its page's ID plus a letter »). None has one: the database holds 26 pages and no page state (`select kind, count(*) from ids group by kind` → page 26). The screen inventory still lists 26 screens and none of the 33 (« Le design compte 26 écrans, de P-01 à P-26 »). Two artboards are filed under a page their title does not name: `Etat-P13-publication-succes.dc.html` is « P-03 · F-051 · Post publié » and `Etat-P13-story-succes.dc.html` is « P-08 · F-051 · Story publiée ». The rule came with the method sync of 2026-11-19 (280bf3d), after the states were drawn (D-026). | — | Run prompt 9 on the 33 state artboards: give each one a page-state ID after its page (P-02.a…), as an entry of `pages` listing its own features, and add them to the screen inventory. Settle which page owns the two success toasts (by their title: P-03 and P-08). |
| 3 | L2-03 | Major | B | P-04, P-07, P-12, P-16; F-022, F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010.a | Unchanged since the last check: six « à confirmer » items of `claude_docs/inventaire-des-ecrans.md` have no open question and no decision in the registry. P-04 « 3 demandes en démo (vraies demandes : à confirmer) »; P-07 « réception côté ami : à confirmer », « copie réelle : à confirmer », « feuille de partage du téléphone : à confirmer »; P-12 « Brouillon abandonné (sauvegarde : à confirmer) »; P-16 « Non dessinés (à confirmer : mêmes actions que P-03 ?) », which the registry states as a fact with no decision: F-010.a « Résultat de recherche : aucune action (like, commentaire, enregistrement, partage) ». | — | See question 2. |
| 4 | L3-11 | Blocking | A | D-037, D-038 | Two decisions in force contradict each other on the registry's path. D-037: « Le registre importé s'appelle claude_docs/registry.yaml, nom fixé par la méthode ». D-038: « …importée en claude_docs/registry.md ». D-037 does not say it was replaced, unlike D-007 and D-008 (« Remplacée par D-017 »). D-038, `CLAUDE.md` and the method (L0-05, « claude_docs/registry.md, the import of its Claude Doc ») agree on `registry.md`, so D-037 is the stale one. | — | In the registry Claude Doc, mark D-037 « Remplacée en partie par D-038 » (the file name), keeping its rule on ids_retires and on digits; then import and promote. |
| 5 | L3-07 | Major | B | F-046, F-069, D-033 | Two features take a photo for the post on the same page P-12 with the same entity E-04: F-046 « Prendre une photo » (« Bouton appareil photo », sans effet, question « Écran de prise de vue ») and F-069 « Prendre une photo pour un post » (« Ouvrir l'appareil photo » depuis la galerie vide). F-069 even asks « Bouton seulement dans la galerie vide, ou aussi au-dessus de la grille ? », which is where F-046's button is (`Compose.dc.html` line 47, `aria-label="Appareil photo"`). D-033's reason « aucune feature existante ne prend de photo » overlooks F-046. | — | See question 3. |
| 6 | B3-02 | Major | B | E-09, F-028.a, D-015 | Unchanged since the last check: E-09 lists `statut (en attente, demandé, ami, refusé)`, a status the design never shows and that F-028.a rules out: « Refuser : la demande est supprimée et la ligne disparaît ». | — | See question 4. |
| 7 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | Unchanged since the last check: `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 344 « Fermer la story ») that nothing on the Accueil opens (`storyFriends` is never rendered there), and a search state (line 359 `searchOpen`, line 966 `openSearch`) with no entry. `Profile.dc.html` also computes values it never shows (line 523 `leaves`, a storage table « Fil, minuteur, pauses… »; line 598 `usageHint`). No decision records them as unused design code. | — | See question 5. |
| 8 | G-04 | Minor | C | F-015, F-015.a, P-03, P-22 | Unchanged since the last check, and now copied into the new states: the Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 249, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 6. |
| 9 | G-04 | Minor | A | P-01, P-02, P-03, P-05, P-09, P-13, P-15, P-17, P-18, P-19, P-21, P-22 | The screen inventory still says the states are not drawn, where the registry and the design have them: e.g. inventory P-13 « aucun envoi en cours, succès ni erreur dessiné » against F-051 `etats_ui` « envoi : anneau et « Publication… » » and `Etat-P13-publication-envoi.dc.html`; inventory P-01 « aucun chargement ni erreur dessiné »; P-22 « aucun échec ni annulation dessiné ». The registry wins by precedence. | 2 | Update the inventory in its Claude Doc when the page states get their IDs (finding 2). |
| 10 | T-01 | Major | A | E-03, F-048, F-049, P-13, P-24, P-25 | Unchanged since the last check: inventory P-13 shows « Identifier des personnes · Personnes identifiées » and « Ajouter un lieu · Lieu »; F-048 and F-049 list `entites: [E-03]` with `écriture`, but E-03 `champs` holds neither identified people nor a place. The data model (prompt 11) would miss both. | — | Add the two fields to E-03 `champs` in the registry Claude Doc (the owner confirms the names). |
| 11 | T-04 | Minor | C | D-018, F-019, F-062 | Unchanged since the last check: D-018's reason is « L'app n'explique nulle part ailleurs le flou ni le charabia », but the design still does: `Main.dc.html` line 925 « Lien copié. Il mène à une version floutée. », line 926 « Partagé, flouté comme toujours. »; `Profile.dc.html` « Tes posts, tels que les voient tes amis »; and the new empty state `Etat-P17-posts-vide.dc.html` line 60 « Tes posts s’affichent ici, floutés, avec leurs jours restants. » D-018's choice itself is applied. | — | See question 7. |

## Questions for the owner

1. **States still undrawn (finding 1, class C).** D-025 covered 18 features; 16 more show no loading, error or failure state.
   - a. Draw them all in `claude_design/`, as for D-025, then run prompt 9.
   - b. Record one decision that applies D-027 (error in place with « Réessayer ») and D-028 (ring) to them by analogy, as D-036 did, and draw nothing more.
   - c. Draw only the network writes (like, save, send to a friend, accept or refuse, add a friend, send a photo) and record a decision for the lists.
2. **Dropped « à confirmer » items (finding 3, class B).** Real invitations on P-04, reception of a shared post, real link copy, the phone's share sheet, saving an abandoned draft, actions on a search result (P-16).
   - a. Add each as an open question on its feature (F-022 or F-028, F-019.a, F-019.b, F-019.c, F-005.a, F-010).
   - b. Settle them now, one decision each; for P-16, confirm « no actions on a search result » or give it P-03's actions.
   - c. Leave the « real or generated » ones to the system design, and settle only P-16 and the draft now.
3. **Two camera features (finding 5, class B).**
   - a. Merge F-069 into F-046 as a variant (F-046.a « depuis la galerie vide »), retire F-069 in ids_retires, and reword D-033.
   - b. Keep both, and reword F-046 or F-069 so that their behaviors differ (e.g. F-046 stays « sans effet » until a camera screen is drawn); correct D-033's reason.
   - c. Remove the camera button above the grid from the design and retire F-046.
4. **Refused invitation (finding 6, class B).**
   - a. Deleted: remove « refusé » from E-09's statuses.
   - b. Kept as « refusé » (to stop repeated requests): reword F-028.a and say what the sender sees.
   - c. Deleted for the receiver, still « demandé » for the sender: record it as a decision.
5. **Leftover code in the design (finding 7, class C).**
   - a. Remove the story player and search state from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
6. **Wording of the support offer (finding 8, class C).**
   - a. « Une heure passée ici. » everywhere.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.
7. **Blur wording after D-018 (finding 11, class C).**
   - a. Remove the mentions of blur from the two toasts, the Profil title and the P-17 empty state, so that D-018's reason holds.
   - b. Keep them and reword D-018's reason: only the two long explanations were removed.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 26 pages (no page state), 63 features, 20 variants, 17 entities, 39 decisions, 8 retired IDs. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read in full: `claude_docs/registry.md`, `claude_docs/inventaire-des-ecrans.md`, `canvas.json` (titles of all 40 artboards), and the method files the check needs.
- Design: the 7 interactive screens have not changed since the last check (747d722), which matched every text and label of them to the 26 pages; this run read only what changed (the 33 state artboards, by title and by grep for wording) and re-checked the earlier findings in the interactive screens.
- L1-02: all 18 features of D-025 checked against the state artboards; the 16 others in finding 1 come from reading every feature's `etats_ui`.
- G-03: the ID set of `registry.md` against the last checked registry (`registre-canonique.yaml` at 747d722): only additions (D-025 to D-039, F-069), nothing removed or renumbered.
- T-04 ran on D-025 to D-039; D-001 to D-024 were checked last time and have not changed. T-01 ran as far as entity fields only. T-02, T-03 and U-01 to U-03 need later layers.
- L1-03: `claude_design/` is taken as the current design export; it was not compared with the live Claude Design canvas.

## Hand-off to the code check
Commit checked: 3e7c924. Verdict: not ready, with 2 blocking findings (#2, #4).

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

Documents the code checker should not trust yet: the registry's `pages` section (no page states, finding 2) and decision D-037 (finding 4), the screen inventory (findings 2 and 9), and E-03's and E-09's fields (findings 6 and 10).
