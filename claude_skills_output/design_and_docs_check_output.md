# Top to bottom check · Fake scrolling · 2026-11-24

Documents: commit 883a083 · Mode: B (database built from 883a083, fingerprint 4423494c29e97c49)
Method followed: version of 2026-11-24 (method overview revision 90, describe revision 23, reference revision 26, check instruction revision 54)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed (the flows are in `claude_docs/conception-systeme.md`, 3 flows read by the database) | 0 | 0 | 0 |
| L1 Design | passed (L1-02: P-28's loading and error states are now covered by D-067; L1-03: the 69 files of `fake-scrolling-app/.claude-ai.json` match `claude_design/` by hash, `index.html`, `artifact-type/dc-runtime.js` and `project/support.js` unlisted as before; L1-04: query passed, no feature carries `design_a_mettre_a_jour`, and F-063's redraw asked by D-069 is in `Profile.dc.html`) | 0 | 0 | 0 |
| L2 Raw extraction | passed (28 screens, 60 page states, unchanged since the last check) | 0 | 0 | 0 |
| L3 Registry | passed (L3-11: D-067, D-068 and D-069 contradict no decision) | 0 | 0 | 0 |
| L4 Canonical registry (platform merge) | not run: the app has one platform (L4-14 included) | 0 | 0 | 0 |
| L5 Flows | passed (L5-02: every step of FL-01 to FL-03 matches its features' `entites` and `operations`; L5-05 and L5-07 not reached: step 5 is in progress, no background-job flow yet) | 0 | 0 | 0 |
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
| B5 Flows | passed (B5-01: P-21 → P-01 after a deletion is now drawn, `Profile.dc.html` lines 202 and 593-605, explained by D-069; B5-02: every undrawn case is an open question of its feature; B5-03 not reached, no background job yet) | 0 | 0 | 0 |
| B4 Canonical registry | not run: the app has one platform | 0 | 0 | 0 |
| B3 Per-platform registries | passed (E-12 written by F-044, F-046, F-047 comes from D-068; F-063's E-02 from D-053 and D-069) | 0 | 0 | 0 |
| B2 Raw extraction | passed (the inventory's P-21 and P-28 rows match the design) | 0 | 0 | 0 |
| B1 Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 0 | 1 |
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 0 | 6 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 0 blocking, 0 major, 8 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L1-04, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, L5-01, L5-06, G-01 and G-02 passed with no rows; G-03 passed with `--since bb0c70c` (the docs at the last check) and with `--since 2f91804`: no ID disappeared. L5-07 is "not reached: step 5 is in progress". Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 5 of the method: FL-01, FL-02 and FL-03 are written.

Since the last check (bb0c70c): D-067 settled P-28's states (old finding 1), F-008 and F-051 now read (old finding 2), D-068 made F-044, F-046 and F-047 write E-12 (old finding 3), and D-069 with the `Profile.dc.html` redraw took a deleted account to P-01 after 2 s (old finding 6). Old findings 4, 5 and 7 to 12 are unchanged (now 1 to 8); no new finding.

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | Unchanged. `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 951 `storyOn: !!storyView`) that nothing on the Accueil opens, and a search state (line 359 `searchOpen: false`, line 966 `searchOn`, lines 968-969 `openSearch` / `closeSearch`) with no entry, which still searches by colour name (line 820 `this.colourFor(s.query)`), against F-052. `Profile.dc.html` computes values it never shows (line 525 `leaves`, line 611 `usageHint`). No decision records them as unused design code. | — | See question 1. |
| 2 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged. The Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 251, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 2. |
| 3 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 (`registry.md` line 1869) says « lettré dans l'ordre du canvas », but in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-71). Every other page's letters follow the canvas. | — | Keep the letters (IDs are never renumbered) and reword D-040 in the registry Claude Doc: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. Then import and promote. |
| 4 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | Unchanged. D-042 (line 1879): « Accepter ou refuser une invitation (F-028) […] montrent l'anneau dans le bouton (D-028), puis l'erreur sur place avec « Réessayer » ». F-028 `etats_ui` (line 861) says only « réponse en cours : anneau dans « Accepter », les deux boutons désactivés », and the inventory's « Refuser une invitation » row (`inventaire-des-ecrans.md` line 115) still lists « La ligne disparaît » alone, while « Accepter » (line 114) cites P-04.d and P-04.e. | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and the same note on the inventory's « Refuser une invitation » row. Then import and promote. |
| 5 | T-04 | Minor | A | F-010, F-010.a, D-046, D-049 | Unchanged. The merge note of F-010 (`registry.md` line 2037) still says « P-16 sans actions en variante », while F-010.a (line 565) says « se comporte comme un post du fil, avec les mêmes actions (D-046, D-049) ». The F-020 note was updated the same way (line 2044 « …en variante, retirée par D-049 »), not this one. | — | In the registry Claude Doc, end the F-010 row with « ; actions ajoutées par D-046 et D-049 ». Then import and promote. |
| 6 | T-04 | Minor | A | D-056, D-066, P-04.a | Unchanged. D-056 (line 1949) still says P-04.a's text « devient « Les invitations, les likes et les commentaires reçus s’affichent ici. » », and D-066 (line 1999) sets a different text for the same state without naming D-056. The registry (F-022), the inventory and `Etat-P04-notifications-vide.dc.html` all follow D-066, so no document contradicts the other, but a reader of D-056 alone gets the old text. | — | In the registry Claude Doc, add to D-066's `choix` « ; remplace le texte de D-056 » and D-056 to its `impacte` or reason. Then import and promote. |
| 7 | T-04 | Minor | A | D-056, D-061, F-022, P-04 | Unchanged. Since D-056 and D-061, every notification of P-04 has a thumbnail, not only likes (`Main.dc.html`: one template for the 7 rows of `likesList`, kinds `identification`, `like`, `commentaire`). The inventory still says « Voir le post liké | Miniature carrée à droite de chaque like » (line 117), and F-022's question says « Ouvrir le post liké depuis sa miniature » (`registry.md` line 780). | — | In the inventory, « Voir le post concerné | Miniature carrée à droite de chaque notification »; in F-022, « Ouvrir le post concerné depuis sa miniature ». Then import and promote. |
| 8 | T-04 | Minor | A | D-024, D-054, F-019 | Unchanged. F-019's `questions_ouvertes` still holds « Un lien de post ouvert sans connexion mène à la connexion (P-01) » (line 734), which is not a question: D-024 settled it and D-054 (`impacte: [F-009, F-019]`) settled what follows the connection. | — | In the registry Claude Doc, remove that line from F-019's questions, or turn it into « Lien ouvert sans connexion : P-01, puis le post (D-024, D-054) » outside the questions. Then import and promote. |

## Questions for the owner

1. **Leftover code in the design (finding 1, class C).**
   - a. Remove the story player and the search state (with its colour search) from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`. Recommended: nothing reaches them, and the colour search contradicts F-052.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
2. **Wording of the support offer (finding 2, class C).**
   - a. « Une heure passée ici. » everywhere.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 28 pages, 60 page states, 65 features, 21 variants, 17 entities, 69 decisions, 10 retired IDs, 3 flows. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read: all of `conception-systeme.md` (FL-01 to FL-03); the diff of `claude_docs/` from bb0c70c to 883a083 (F-008, F-044, F-046, F-047, F-051, F-063, F-072, E-02, E-12, D-067 to D-069; the inventory's P-21 and P-28 rows; FL-01 and FL-03); the inventory's P-12 and P-13 sections; D-040, D-042, D-056, D-066, F-019, F-022, F-028, F-071; the merge notes.
- Design: the diff of `claude_design/` from bb0c70c (`Profile.dc.html`: the hidden link to `Login.dc.html` clicked 2 s after « Supprimer définitivement », and « Recommencer la démo » cancelling it, as the inventory's line 509 says). L1-03 re-checked by hash against `fake-scrolling-app/.claude-ai.json`. The live canvas on claude.ai was not opened, as the check requires.
- L5-02: every step of the three flows was compared with the `entites` and `operations` of its features in the registry.
- T-04 ran on D-067, D-068 and D-069: each change is in the registry, the inventory, the flows and the design. D-069's « F-063 porte design_a_mettre_a_jour: true » records the redraw it asked for; the flag is gone since the redraw, as for D-053 and D-062: not a finding.
- Older findings' evidence was re-checked by grep at the lines quoted; line numbers that moved were updated.
- T-02, T-03 and U-01 to U-03 need later layers.

## Hand-off to the code check
Commit checked: 883a083. Verdict: ready for the code check, no blocking finding.

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
