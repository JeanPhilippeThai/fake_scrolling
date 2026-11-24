# Top to bottom check · Fake scrolling · 2026-11-24

Documents: commit bb0c70c · Mode: B (database built from bb0c70c, fingerprint 82105996ddc76c43)
Method followed: version of 2026-11-24 (method overview revision 90, describe revision 23, reference revision 26, check instruction revision 51)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed (the flows are in `claude_docs/conception-systeme.md`, the import of the Claude Doc « Conception système », 3 flows read by the database) | 0 | 0 | 0 |
| L1 Design | findings (L1-03: the 69 files of `.claude-ai.json` match `claude_design/` by hash, `support.js` unlisted as before; L1-04: no feature carries `design_a_mettre_a_jour` any more, and every redraw asked by D-051 to D-066 is in the design, see "What was sampled") | 0 | 1 | 0 |
| L2 Raw extraction | passed (28 screens, 60 page states, P-27, P-27.a, P-27.b and P-28 added; canvas order gives P-27.a envoi at x=940, P-27.b erreur at x=1410) | 0 | 0 | 0 |
| L3 Registry | passed (L3-11: D-052 to D-066 contradict no decision; D-066 refines the text of D-056, see finding 10) | 0 | 0 | 0 |
| L4 Canonical registry (platform merge) | not run: the app has one platform | 0 | 0 | 0 |
| L5 Flows | findings (FL-01 to FL-03 written; L5-05 and L5-07 not reached: step 5 is in progress, no background-job flow yet, FL-05 « Griser l'app par cycles » is planned) | 0 | 2 | 0 |
| L6 Entity states and TLA+ | not reached | 0 | 0 | 0 |
| L7 NFRs | not reached | 0 | 0 | 0 |
| L8 Data model | not reached | 0 | 0 | 0 |
| L9 Data flows and threat model | not reached | 0 | 0 | 0 |
| L10 Page contracts | not reached | 0 | 0 | 0 |
| L11 Feature specs | not reached | 0 | 0 | 0 |
| L12 Planning and agent documents | not reached (L12-07: every path `CLAUDE.md` gives exists, and it links the new Claude Doc « Conception système »; markers and app command wait for the code) | 0 | 0 | 0 |
| B12 Planning and agent documents | not reached | 0 | 0 | 0 |
| B11 Feature specs | not reached | 0 | 0 | 0 |
| B10 Page contracts | not reached | 0 | 0 | 0 |
| B9 Data flows and threat model | not reached | 0 | 0 | 0 |
| B8 Data model | not reached | 0 | 0 | 0 |
| B7 NFRs | not reached | 0 | 0 | 0 |
| B6 Entity states and TLA+ | not reached | 0 | 0 | 0 |
| B5 Flows | passed (B5-01: every move is drawn or explained by a decision: P-01/P-02 → P-27 by D-052, P-27 being a separate artboard; B5-02: every undrawn case is an open question of its feature; B5-03 not reached, no background job yet) | 0 | 0 | 0 |
| B4 Canonical registry | not run: the app has one platform | 0 | 0 | 0 |
| B3 Per-platform registries | passed (F-070, F-071, F-072 come from prompt 5's missing items, approved by D-052, D-053, D-060; the new entity fields come from D-053, D-056, D-059, D-060, D-061) | 0 | 0 | 0 |
| B2 Raw extraction | passed (the inventory's P-04, P-21, P-26, P-27, P-28 sections match the design, element by element) | 0 | 0 | 0 |
| B1 Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 0 | 1 |
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 1 | 6 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 0 blocking, 4 major, 8 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, L5-01, L5-06, G-01 and G-02 passed with no rows; G-03 passed with `--since 880a138` (the docs at the last check) and with `--since 3a3b5e6`: no ID disappeared. L5-07 is "not reached: step 5 is in progress". Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 5 of the method: FL-01, FL-02 and FL-03 are written.

Since the last check (880a138): prompt 5 ran on FL-01, FL-02 and FL-03 (D-052 to D-062), the design was redrawn for D-051 to D-062 (P-04, P-12, P-17, P-21, P-26, new P-27 and P-28), and prompt 9 ran on the redraws (D-063 to D-066, every `design_a_mettre_a_jour` flag removed). The pending redraw of the last report is done. Old findings 1 to 5 are unchanged (now 4, 5, 7, 8 and 9); findings 1, 2, 3, 6, 10, 11 and 12 are new.

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L1-02 | Major | B | P-28, F-072, D-043, D-060 | P-28's list has loading and error states that are neither drawn nor covered by a decision. F-072 `etats_ui` (`registry.md` line 1489 onward): « chargement : anneau centré dans la liste (comme D-043) », « échec du chargement : message sur place avec « Réessayer » (comme D-043) »; the inventory's « Choisir un ami proche » row (`inventaire-des-ecrans.md` line 616) ends « (F-072, non dessinés) ». D-043 (line 1882) names only P-24, P-25 and P-07 (`impacte: [F-016, F-019, F-048, F-049]`), and D-060 says nothing about these states. | — | See question 1. |
| 2 | L5-02 | Major | A | FL-01, FL-03, F-008, F-051 | Two steps read entities with a feature whose `operations` is `[écriture]` only. FL-01 step 3b' (`conception-systeme.md` line 26): F-008 reads « E-02 (délai avant renvoi) ». FL-03 steps 9 and 10 (lines 167-168): F-051 reads « E-03 ou E-12 (brouillon), E-04 » and « E-03 ou E-12 ». Each flow's own summary agrees with the registry, not with its table: « F-003, F-008 écrivent E-02 » (line 30), « F-046, F-047, F-050, F-051, F-068 écrivent » (line 170). | — | The registry comes first in the precedence order, but both features do read (the resend delay, the draft): add `lecture` to the `operations` of F-008 and F-051 in the registry Claude Doc and fix the two summary lines of the flows; or, if they must stay write-only, empty those « Entités lues » cells. Then import and promote. |
| 3 | L5-02 | Major | B | FL-03, F-044, F-046, F-047, E-03, E-12, D-059 | In FL-03 the draft of a story is written to E-03 for the photos and the caption, but to « E-03 ou E-12 » for every later option. Steps 1, 1' and 3 (`conception-systeme.md` lines 157, 158, 160) write « E-03 (brouillon : photos choisies…) », « E-03 (brouillon : la photo prise…) », « E-03 (brouillon : légende) »; steps 4 to 7 write « E-03 ou E-12 ». F-044, F-046 and F-047 cite only E-03 (and E-04), while E-12 has the fields « images » and « texte ». The design shows the same photos and the same caption field for both destinations (`Compose.dc.html` lines 89-90, the « Légende » field outside any destination condition). D-059 extended only F-048, F-049 and F-050 to stories. | — | See question 2. |
| 4 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | Unchanged. `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 951 `storyOn: !!storyView`) that nothing on the Accueil opens, and a search state (line 359 `searchOpen: false`, line 966 `searchOn`, lines 968-969 `openSearch` / `closeSearch`) with no entry, which still searches by colour name (line 820 `this.colourFor(s.query)`), against F-052. `Profile.dc.html` computes values it never shows (line 524 `leaves`, line 599 `usageHint`). No decision records them as unused design code. | — | See question 3. |
| 5 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged. The Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 250, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 4. |
| 6 | T-04 | Major | B | D-053, F-063, P-21, E-02, FL-01 | D-053 (`registry.md` line 1932): « la suppression du compte (F-063) y ramène aussi » (to P-01), and `impacte` lists F-063; FL-01 makes it an entry (`conception-systeme.md` line 16). But F-063 was not updated: its open question is still « Effacement réel et déconnexion » (line 1401) and it cites only E-01, though it now closes the session (E-02). The inventory's « Confirmer la suppression » row (line 507) still says « (effacement réel et déconnexion : à confirmer) ». The design does not reach P-01: after « Supprimer définitivement », `Profile.dc.html` lines 197-202 show « Compte supprimé », « Merci d’être passé·e. » and « Recommencer la démo », with no link to `Login.dc.html`, and D-053 set no `design_a_mettre_a_jour`. | — | Mechanical part, in the registry Claude Doc: F-063's question becomes « Effacement réel », the session part citing D-053, and the same on the inventory row. How the « Compte supprimé » state reaches P-01 is not defined: see question 5. |
| 7 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 (`registry.md` line 1869) says « lettré dans l'ordre du canvas », but in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-71). Every other page's letters follow the canvas, P-27.a and P-27.b included. | — | Keep the letters (IDs are never renumbered) and reword D-040 in the registry Claude Doc: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. Then import and promote. |
| 8 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | Unchanged. D-042 (line 1879): « Accepter ou refuser une invitation (F-028) […] montrent l'anneau dans le bouton (D-028), puis l'erreur sur place avec « Réessayer » ». F-028 `etats_ui` (line 861) says only « réponse en cours : anneau dans « Accepter », les deux boutons désactivés », and the inventory's « Refuser une invitation » row (line 115) still lists « La ligne disparaît » alone, while « Accepter » (line 114) cites P-04.d and P-04.e. | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and the same note on the inventory's « Refuser une invitation » row. Then import and promote. |
| 9 | T-04 | Minor | A | F-010, F-010.a, D-046, D-049 | Unchanged. The merge note of F-010 (`registry.md` line 2022) still says « P-16 sans actions en variante », while F-010.a (line 565) says « se comporte comme un post du fil, avec les mêmes actions (D-046, D-049) ». The F-020 note was updated the same way (line 2029 « …en variante, retirée par D-049 »), not this one. | — | In the registry Claude Doc, end the F-010 row with « ; actions ajoutées par D-046 et D-049 ». Then import and promote. |
| 10 | T-04 | Minor | A | D-056, D-066, P-04.a | D-056 (line 1949) still says P-04.a's text « devient « Les invitations, les likes et les commentaires reçus s’affichent ici. » », and D-066 (line 1999) sets a different text for the same state without naming D-056. The registry (F-022), the inventory (line 124) and `Etat-P04-notifications-vide.dc.html` all follow D-066, so it is not a contradiction between documents, but a reader of D-056 alone gets the old text. | — | In the registry Claude Doc, add to D-066's `choix` « ; remplace le texte de D-056 » and D-056 to its `impacte` or reason. Then import and promote. |
| 11 | T-04 | Minor | A | D-056, D-061, F-022, P-04 | Since D-056 and D-061, every notification of P-04 has a thumbnail, not only likes (`Main.dc.html`: one template for the 7 rows of `likesList`, kinds `identification`, `like`, `commentaire`). The inventory still says « Voir le post liké | Miniature carrée à droite de chaque like » (line 117), and F-022's question says « Ouvrir le post liké depuis sa miniature » (`registry.md` line 780). | — | In the inventory, « Voir le post concerné | Miniature carrée à droite de chaque notification »; in F-022, « Ouvrir le post concerné depuis sa miniature ». Then import and promote. |
| 12 | T-04 | Minor | A | D-024, D-054, F-019 | F-019's `questions_ouvertes` still holds « Un lien de post ouvert sans connexion mène à la connexion (P-01) » (line 734), which is not a question: D-024 settled it and D-054 (`impacte: [F-009, F-019]`) settled what follows the connection. F-019 was not changed for D-054. | — | In the registry Claude Doc, remove that line from F-019's questions, or turn it into « Lien ouvert sans connexion : P-01, puis le post (D-024, D-054) » outside the questions. Then import and promote. |

## Questions for the owner

1. **Loading and error states of the Amis proches panel, P-28 (finding 1, class B).**
   - a. Extend D-043 to P-28 (F-072): a ring centred in the list, then a message in place with « Réessayer », no new artboard, as for P-24. Recommended: P-28 copies P-24 (D-060), and F-072 already describes these states.
   - b. Draw them as page states P-28.a and P-28.b, like D-041.
2. **What a story keeps from the draft (finding 3, class B).**
   - a. A story keeps the chosen photos and the caption: F-044, F-046 and F-047 also write E-12 (« images », « texte »), as D-059 did for the other options, and FL-03 steps 1, 1' and 3 write « E-03 ou E-12 ». Recommended: P-12 and P-13 are the same for both destinations, and E-12 already has these fields.
   - b. A story has no caption: P-13 hides the caption field when « Story » is chosen (a design change), and E-12 « texte » gets its own source.
   - c. The draft is always an E-03 until F-051 turns it into a story: record it, and steps 4 to 7 write E-03 only.
3. **Leftover code in the design (finding 4, class C).**
   - a. Remove the story player and the search state (with its colour search) from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`. Recommended: nothing reaches them, and the colour search contradicts F-052.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
4. **Wording of the support offer (finding 5, class C).**
   - a. « Une heure passée ici. » everywhere.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.
5. **How a deleted account reaches the Connexion page (finding 6, class B).**
   - a. « Compte supprimé » and « Merci d’être passé·e. » stay 2 s, then P-01 opens by itself. Recommended: the goodbye stays visible and nothing else is left to do on the page.
   - b. The state gets a button that opens P-01, in place of the demo's « Recommencer la démo ».
   - c. P-01 opens at once, with « Compte supprimé. » as a message there.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 28 pages, 60 page states, 65 features, 21 variants, 17 entities, 66 decisions, 10 retired IDs, 3 flows. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read: all of `conception-systeme.md` (FL-01 to FL-03); the diff of `claude_docs/` from 880a138 to bb0c70c (P-21, P-26, P-27, P-28, F-001, F-005, F-007, F-009, F-016, F-018, F-022, F-024, F-027, F-030, F-048 to F-051, F-070 to F-072, E-01, E-02, E-05, E-08, E-09, E-12, D-052 to D-066; the inventory's P-04, P-07, P-12, P-17, P-21, P-26, P-27, P-28 sections); D-024, D-040, D-042, D-043, F-019, F-028, F-031, F-063; the merge notes.
- Design: the diff of `claude_design/` from 880a138 (`Main.dc.html` notifications and share toasts, `Profile.dc.html` « Tes posts » and « Se déconnecter », the P-04, P-17, P-21 state artboards, `Compose.dc.html` « Modifier la liste », P-28 and the close link, `Inscription.dc.html` and the two P-27 states) and `canvas.json`. L1-03 re-checked by hash against `fake-scrolling-app/.claude-ai.json`. The live canvas on claude.ai was not opened, as the check requires.
- L5-02: every step of the three flows was compared with the `entites` and `operations` of its features, queried from the database.
- L5-03 and B5-02: every decision point leads to a page, a feature or an explicit end, or to an open question of a feature (F-001, F-007, F-009, F-046, F-070, F-072); each « Restent ouverts » item of the flows is in its feature's `questions_ouvertes`.
- Not findings: D-062's close of P-12 returns to `Search.dc.html` in its first state (P-14) when the creation was opened from P-15 or P-16, and P-02 always leads to P-03 in the mock-up; the inventory records both as limits of the mock-up (lines 300 and 589), and D-062 and D-052 explain the moves (B5-01).
- T-04 ran on D-052 to D-066: each change is in the registry, the inventory and the design, except findings 6, 10 and 12.
- Older findings' evidence was re-checked by grep at the lines quoted.
- T-02, T-03 and U-01 to U-03 need later layers.

## Hand-off to the code check
Commit checked: bb0c70c. Verdict: ready for the code check, no blocking finding.

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
