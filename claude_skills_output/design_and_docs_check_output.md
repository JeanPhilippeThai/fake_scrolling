# Top to bottom check · Fake scrolling · 2026-11-21

Documents: commit 880a138 · Mode: B (database built from 880a138, fingerprint a7bd606e70aff69d)
Method followed: version of 2026-11-20 (method overview revision 90, describe revision 21, reference revision 26, check instruction revision 50)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed | 0 | 0 | 0 |
| L1 Design | passed (L1-02: the like and save failures on P-16 follow P-03.e and P-03.f by D-046 and D-049, its panels' states are those of P-05 to P-07 by D-050; L1-03: the 66 files of `claude_design/` match `.claude-ai.json`; L1-04: only F-019 and F-062 carry `design_a_mettre_a_jour`, set by D-051, and both still differ from the design, see below) | 0 | 0 | 0 |
| L2 Raw extraction | passed (L2-01: D-050 makes the three panels over P-16 the pages P-05, P-06 and P-07) | 0 | 0 | 0 |
| L3 Registry | passed (L3-02: P-16 and F-009, F-016, F-016.a, F-017 to F-021 now list each other; L3-11: D-049 to D-051 contradict no decision) | 0 | 0 | 0 |
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
| B3 Per-platform registries | passed | 0 | 0 | 0 |
| B2 Raw extraction | passed (the inventory's P-16 section now matches `Search.dc.html`, element by element) | 0 | 0 | 0 |
| B1 Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 0 | 1 |
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 0 | 3 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 0 blocking, 0 major, 5 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, G-01 and G-02 passed with no rows; G-03 passed with `--since a84fb37` (the docs before prompt 9: F-020.a removed and listed in ids_retires with D-049; F-009.a and D-049 to D-051 added) and with `--since dacabcb`. Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 4 of the method; step 5 (flows) has not started.

Since the last check (dacabcb plus the P-16 redraw): commit 880a138 ran prompt 9 on the redrawn P-16 and recorded D-049 (option a of old question 1), D-050 (old finding 2) and D-051 (option a of old question 2). Old findings 1, 2, 3, 4, 6, 8 and 9 are closed. Old findings 5, 7, 10 and 11 are unchanged (now 1, 2, 3 and 4); finding 5 is new, a merge note prompt 9 did not update.

Pending redraw, not a finding: D-051 flags F-019 and F-062 with `design_a_mettre_a_jour: true`, and the design still shows what D-051 removes: `Main.dc.html` lines 925-926 « Lien copié. Il mène à une version floutée. » and « Partagé, flouté comme toujours. »; « Tes posts, tels que les voient tes amis » in `Profile.dc.html` line 98, `Etat-P17-posts-chargement.dc.html` line 59, `Etat-P17-posts-erreur.dc.html` line 57 and `Etat-P17-posts-vide.dc.html` line 57; « Tes posts s’affichent ici, floutés, avec leurs jours restants. » in `Etat-P17-posts-vide.dc.html` line 60. Step 4 of the design cycle (Claude redraws them in `claude_design/`, then `publish-claude-design`) and prompt 9 then remove the two flags.

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | Unchanged: `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 949 `storyOn: !!storyView`) that nothing on the Accueil opens, and a search state (line 359 `searchOpen: false`, line 964 `searchOn`, lines 966-967 `openSearch` / `closeSearch`) with no entry, which still searches by colour name (line 820 `this.colourFor(s.query)`), the behavior the P-16 redraw removed from `Search.dc.html` to match F-052. `Profile.dc.html` computes values it never shows (line 523 `leaves`, line 598 `usageHint`). No decision records them as unused design code. | — | See question 1. |
| 2 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged: the Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 249, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 2. |
| 3 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 (`registry.md` line 1800) still says « lettré dans l'ordre du canvas », but in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-71). Every other page's letters follow the canvas. | — | Keep the letters (IDs are never renumbered) and reword D-040 in the registry Claude Doc: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. Then import and promote. |
| 4 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | Unchanged. D-042 (line 1810): « Accepter ou refuser une invitation (F-028) […] montrent l'anneau dans le bouton (D-028), puis l'erreur sur place avec « Réessayer » ». F-028 `etats_ui` (line 846) says only « réponse en cours : anneau dans « Accepter », les deux boutons désactivés », and the inventory's « Refuser une invitation » row (`inventaire-des-ecrans.md` line 115) still lists « La ligne disparaît » alone, while « Accepter » (line 114) cites P-04.d and P-04.e. | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and the same note on the inventory's « Refuser une invitation » row. Then import and promote. |
| 5 | T-04 | Minor | A | F-010, F-010.a, D-046, D-049 | The merge note of F-010 (`registry.md` line 1878) still says « P-16 sans actions en variante », while F-010.a (line 549) now says « se comporte comme un post du fil, avec les mêmes actions (D-046, D-049) ». Prompt 9 updated the F-020 note the same way (line 1885 « …en variante, retirée par D-049 ») but not this one. A historical merge note, not a rule in force, so not an L3-11 contradiction. | — | In the registry Claude Doc, end the F-010 row with « ; actions ajoutées par D-046 et D-049 ». Then import and promote. |

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
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 26 pages, 58 page states, 62 features, 21 variants, 17 entities, 51 decisions, 10 retired IDs. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read: the diff of `claude_docs/` from a84fb37 to 880a138 (P-05, P-06, P-07, P-16, F-009, F-009.a, F-010, F-016 to F-021, F-062, D-049 to D-051, ids_retires, the merge notes; the inventory's P-05, P-06, P-07, P-16 and P-17 sections); the P-16 part of `Search.dc.html` (lines 60-260 and its script: 18 results, Escape, end resistance, double tap that only likes, reduced motion, 80-character caption, toasts) against the new inventory rows; D-018, D-040, D-042, D-046, F-028.
- `claude_design/` did not change since the last check (880a138 touches only the docs); L1-03 re-checked by hash against `fake-scrolling-app/.claude-ai.json` (66 files, none differs; `support.js` is not listed, as before). The live canvas on claude.ai was not opened, as the check requires.
- Older findings' evidence was re-checked by grep at the lines quoted.
- D-051: every « flou » in the docs and the design was grepped. Besides the flagged texts above, two accessible names describe the blur without explaining it (`Main.dc.html` line 503 « Photo d’un ami, floutée », `Profile.dc.html` line 101 « Post flouté, expire dans … jours »); D-051 does not list them, so no finding.
- T-04 ran on D-049, D-050 and D-051 (each change is in the registry and the inventory; the design part of D-051 waits for the redraw, flagged).
- G-03: run as a query with `--since a84fb37` and `--since dacabcb`.
- T-02, T-03 and U-01 to U-03 need later layers.

## Hand-off to the code check
Commit checked: 880a138. Verdict: ready for the code check, no blocking finding.

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
