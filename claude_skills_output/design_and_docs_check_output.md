# Top to bottom check · Fake scrolling · 2026-11-21

Documents: commit dacabcb plus the uncommitted promotion of 2026-11-21 on branch import-design-2026-11-21 (`claude_design/fake-scrolling-app/project/Search.dc.html` redrawn; `claude_docs/` unchanged apart from import dates) · Mode: B (database built from dacabcb, fingerprint dae1c5298dfa10e3)
Method followed: version of 2026-11-20 (method overview revision 90, describe revision 21, reference revision 26, check instruction revision 50)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Not ready: 1 blocking finding (#2)

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed | 0 | 0 | 0 |
| L1 Design | findings (L1-02 passed: D-043 settles the lists of P-24, P-25, P-07 and the comment-like failure; L1-03 passed: the 66 files of `claude_design/` match `.claude-ai.json`) | 0 | 0 | 1 |
| L2 Raw extraction | findings (L2-03 passed: D-044, D-045, D-046 settle the six dropped « à confirmer » items) | 1 | 0 | 0 |
| L3 Registry | findings (L3-07 passed: D-047 merges F-069 into F-046.a) | 0 | 1 | 0 |
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
| B3 Per-platform registries | passed (B3-02: D-048 removes « refusé » from E-09) | 0 | 0 | 0 |
| B2 Raw extraction | findings | 0 | 1 | 0 |
| B1 Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 1 | 2 |
| T Traces from the top down | findings (T-01 passed for E-03: « personnes identifiées » and « lieu » added; T-02 and T-03 not reached) | 0 | 0 | 3 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 1 blocking, 3 major, 7 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, G-01 and G-02 passed with no rows; G-03 passed with `--since 620ad29` (the last checked docs: F-069 removed and listed in ids_retires with D-047; F-046.a and D-043 to D-048 added). Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 4 of the method; step 5 (flows) has not started.

Since the last check (620ad29): commits 71f7b11, 74281af and dacabcb recorded D-043 to D-048 and closed old findings 1, 2, 3, 4, 7 and 8. Then the owner redrew P-16 on claude.ai as D-046 asked, and the import of 2026-11-21 promoted it (`Search.dc.html`). Prompt 9 has not run on that redraw, so the registry and the inventory still describe the old P-16: findings 1, 2, 3, 4 and 6 are new and all come from that one gap; one prompt 9 run closes 1, 2, 3 and 4 once the owner answers question 1. Old findings 5, 6, 9, 10 and 11 are unchanged (now 5, 7, 9, 10 and 11).

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L1-04 | Minor | A | F-010, F-016, F-017, F-018, F-019, D-046 | F-010, F-016, F-017, F-018 and F-019 still carry `design_a_mettre_a_jour: true` (`registry.md` lines 554, 651, 669, 688, 720), set by D-046 (line 1833) « jusqu'à ce que le prompt 9 constate que le design correspond ». The design now matches: `Search.dc.html` line 103 `aria-label="J’aime"`, line 109 `aria-label="Commentaires"`, line 115 `aria-label="Enregistrer dans une collection"`, line 121 `aria-label="Partager"`, the same buttons and labels as P-03 (`Main.dc.html` lines 111-129). | — | Run prompt 9 on P-16 and remove the five flags in the registry Claude Doc; then import and promote. |
| 2 | L2-01 | Blocking | A | P-16, P-05, P-06, P-07 | The redrawn P-16 opens three panels that have no page ID. `Search.dc.html` line 174 `role="dialog" aria-labelledby="sheet-title"`, titled (line 518) `{ save: 'Enregistrer dans une collection', share: 'Partager', comments: 'Commentaires' }`. The same panels over P-03 are pages P-05 « Accueil — panneau Commentaires », P-06 « Accueil — panneau Enregistrer dans une collection » and P-07 « Accueil — panneau Partager » (`registry.md` lines 108, 128, 140), and the inventory gives them only P-03 as entry (« Bulle dans la colonne de droite, ouvre P-05 », line 78, and the next two rows). Their states (P-05.a to P-05.d, P-06.a, P-06.b, P-07.a) are not drawn over P-16 either; the inventory's P-16 row (line 398) says « mêmes états que sur P-03 (D-046) », which holds only if these are the same pages. | — | Prompt 9: either give P-05, P-06 and P-07 the Recherche as a second entry (same panels, same features and states; their « Accueil — » names then need rewording), or propose new page IDs for the three panels of P-16. The owner approves the choice in prompt 9. |
| 3 | L3-02 | Major | A | P-16, F-009, F-016, F-016.a, F-016.b, F-017, F-018, F-019, F-019.a, F-019.b, F-019.c, F-021 | P-16 lists `features: [F-005, F-010.a, F-020.a, F-024, F-025, F-026]` (`registry.md` lines 276-279), and none of F-016, F-017, F-018, F-019 lists P-16 (`pages` at lines 630, 656, 674, 693), though D-046 gives P-16 these actions and the design now shows them (finding 1). The redraw also shows on P-16, with no feature there: the double tap that likes with a big heart (F-016.a; `Search.dc.html` line 85 `onClick="{{it.onTap}}"`, line 93 `class="fs-burst"`), « plus » / « moins » on the caption (F-021; line 129, line 387 `var LIMIT = 80`), and a vertical feed of the 18 results by swipe, wheel and keys (line 81 `aria-label="Résultat {{pageNum}} sur {{total}}"`, `onWheel`, `onKeyDown`), which is F-009's behavior on P-03 (line 521 « par glisser, molette ou clavier »). | — | Prompt 9: add F-016, F-016.a, F-017, F-018, F-019 to P-16 and P-16 to their `pages`; for F-021 and the feed of results, see question 1 (F-020.a and F-010.a must change with them). |
| 4 | B2-01 | Major | A | P-16 | The inventory's P-16 section describes the old screen. Line 390 « Un résultat en plein écran, par-dessus la grille » (now a feed of 18 results, `Search.dc.html` line 81); line 397 « Lire la légende … Jamais tronquée » (now cut at 80 characters, line 387); line 398 « Liker, commenter, enregistrer, partager \| Absents de cet écran ; à ajouter comme sur P-03 (D-046) » (now drawn, lines 103-121); the publisher's photo (line 99 `background: {{it.avatar}}`) and the double tap have no row. | — | Rewrite P-16 in the inventory Claude Doc from the redrawn screen (prompt 9), with the rows of P-03 it now shares; then import and promote. The caption row follows the answer to question 1. |
| 5 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | Unchanged: `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 344 « Fermer la story ») that nothing on the Accueil opens, and a search state (line 359 `searchOpen`, line 964 `searchOn`) with no entry, which still searches by colour name (line 820 `this.colourFor(s.query)`), the behavior the 2026-11-21 redraw removed from `Search.dc.html` to match F-052. `Profile.dc.html` computes values it never shows (line 523 `leaves`, line 598 `usageHint`). No decision records them as unused design code. | — | See question 3. |
| 6 | G-04 | Major | C | F-020, F-020.a, F-021, P-16 | F-020.a (`registry.md` line 732): « Sans photo du publieur, légende jamais tronquée ». The redrawn P-16 shows the publisher's photo at the top of the action column (`Search.dc.html` line 99) and cuts the caption at 80 characters with « plus » / « moins » (lines 129, 387-396), exactly as P-03 does (F-020, F-021). D-046 asked only for the four actions; no decision changed F-020.a. By precedence the registry is probably right, but the redraw came from the owner. | — | See question 1. |
| 7 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged: the Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 249, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 4. |
| 8 | G-04 | Minor | C | F-019.b, F-019.c, P-07, P-16, D-018 | The same share actions give two texts. Over P-03: « Lien copié. Il mène à une version floutée. » and « Partagé, flouté comme toujours. » (`Main.dc.html` lines 925-926; inventory lines 179-180). Over P-16: « Lien copié. » and « Partagé. » (`Search.dc.html` lines 610-611). F-019 `etats_ui` (line 712) « « Lien copié… » ou « Partagé… » » fits both. | — | See question 2. |
| 9 | T-04 | Minor | C | D-018, F-019, F-062, P-17.a, P-17.b, P-17.c | Unchanged: D-018's reason (line 1694) is « L'app n'explique nulle part ailleurs le flou ni le charabia », but the design still does: `Main.dc.html` lines 925-926 (finding 8); `Profile.dc.html` line 98 « Tes posts, tels que les voient tes amis », repeated in `Etat-P17-posts-chargement.dc.html` line 59, `Etat-P17-posts-erreur.dc.html` line 57 and `Etat-P17-posts-vide.dc.html` line 57; `Etat-P17-posts-vide.dc.html` line 60 « Tes posts s’affichent ici, floutés, avec leurs jours restants. » (also F-062 `etats_ui`, line 1369). D-018's choice itself is applied. | — | See question 2. |
| 10 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 (line 1803) still says « lettré dans l'ordre du canvas », but in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-71). Every other page's letters follow the canvas. | — | Keep the letters (IDs are never renumbered) and reword D-040: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. |
| 11 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | Unchanged. D-042 (line 1813): « Accepter ou refuser une invitation (F-028) […] montrent l'anneau dans le bouton (D-028), puis l'erreur sur place avec « Réessayer » ». F-028 `etats_ui` (line 850) says only « réponse en cours : anneau dans « Accepter » », and the inventory's « Refuser une invitation » row (line 115) still lists « La ligne disparaît » alone, while « Accepter » (line 114) cites P-04.d and P-04.e. | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and the same note on the inventory's « Refuser une invitation » row. Then import and promote. |

## Questions for the owner

1. **P-16 now looks exactly like a post of the feed (findings 3 and 6, class C).** The redraw added the publisher's photo, the 80-character caption with « plus » / « moins », the double-tap like and a vertical feed of the 18 results, beyond the four actions D-046 asked for.
   - a. Keep the redraw: record a decision that a search result behaves as a post of the feed in every respect; prompt 9 then drops F-020.a (retired in ids_retires), adds F-020, F-021 and F-016.a to P-16, and gives the feed of results to F-009 as a variant or to F-010.a's difference. Recommended: it follows D-046's reason « un post trouvé se traite comme un post du fil ».
   - b. Keep F-020.a as it is: redraw P-16 without the photo and with the caption never cut; keep the feed of results and the double tap (prompt 9 registers them).
   - c. Keep only the four actions of D-046: redraw P-16 as one post at a time, without the photo, the cut caption or the double tap.
2. **Blur wording after D-018 (findings 8 and 9, class C).** The new P-16 share toasts already drop the blur mention; those over P-03 keep it.
   - a. Remove every mention of blur: the two toasts over P-03 become « Lien copié. » and « Partagé. » as over P-16, plus the Profil title (P-17 and its three state artboards) and the P-17.a empty state, so that D-018's reason holds.
   - b. Keep the explanations and reword D-018's reason (only the two long texts were removed); P-16 then uses the P-03 toasts.
   - c. Keep both toast versions on purpose and note it on F-019 (not recommended: one feature, two texts).
3. **Leftover code in the design (finding 5, class C).**
   - a. Remove the story player and the search state (with its colour search) from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
4. **Wording of the support offer (finding 7, class C).**
   - a. « Une heure passée ici. » everywhere.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.

Finding 2 is class A but its fix has a product side, asked in prompt 9: whether the three panels over P-16 are P-05, P-06 and P-07 (recommended: same features, same states, no new ID) or new pages.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 26 pages, 58 page states, 62 features, 21 variants, 17 entities, 48 decisions, 9 retired IDs. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read: the diff of `claude_docs/` since 620ad29 (D-043 to D-048, F-046.a, E-03, E-09, E-11, the inventory rows they touch); `Search.dc.html` in full; the P-03, P-12, P-15 and P-16 sections of the inventory; the registry entries of P-16, F-009, F-010, F-016 to F-021, F-028, F-046 and D-018, D-033, D-040, D-042 to D-048; `claude_skills_output/compare_newest_current_claude_files.md`.
- L1-03: `claude_design/` checked against `fake-scrolling-app/.claude-ai.json` by hash (66 files, none differs; `support.js` is not listed, as before); the live canvas on claude.ai was not opened, as the check requires.
- P-16 against P-03: the action column, the toasts, the save, share and comments panels of `Search.dc.html` compared line by line with `Main.dc.html`; only the two share toasts differ (finding 8).
- L3-11: D-043 to D-048 read against D-018, D-027, D-028, D-033, D-036, D-040 and D-042; D-033 now says « Remplacée en partie par D-047 », so it does not contradict D-047. No contradiction found.
- T-04 ran on D-043 to D-048 (each change is in the registry and the inventory, except D-046, which waits for prompt 9: findings 1 to 4).
- Design: older interactive screens and state artboards were not re-read in full (unchanged since the last check, hashes equal); every older finding's evidence was re-checked by grep at the lines quoted.
- G-03: run as a query with `--since 620ad29`.
- T-02, T-03 and U-01 to U-03 need later layers.

## Hand-off to the code check
Commit checked: dacabcb plus the uncommitted promotion of `Search.dc.html`. Verdict: not ready, 1 blocking finding (#2).

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

Documents not to trust yet: the P-16 section of `claude_docs/inventaire-des-ecrans.md` and the P-16, P-05, P-06, P-07 entries of `claude_docs/registry.md` (finding 2), with F-010, F-016 to F-021 as they touch P-16 (findings 1, 3, 6), until prompt 9 runs on the redrawn P-16.
