# Top to bottom check · Fake scrolling · 2026-11-24

Documents: commit f2afcbf · Mode: B (database built from f2afcbf, fingerprint 09d95d661f4e3469)
Method followed: version of 2026-11-24 (method overview revision 90, describe revision 23, reference revision 26, check instruction revision 54)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed (the flows are in `claude_docs/conception-systeme.md`, 8 flows read by the database) | 0 | 0 | 0 |
| L1 Design | passed (`claude_design/` unchanged since 883a083 apart from the sync time in `.claude-ai.json`; L1-03: its 69 files match by hash, `index.html`, `artifact-type/dc-runtime.js` and `project/support.js` unlisted as before; L1-04: query passed) | 0 | 0 | 0 |
| L2 Raw extraction | passed (28 screens, 60 page states, unchanged; L2-03: the inventory's « à confirmer » on media and on what friends see became D-086 and the questions of F-042 and F-051) | 0 | 0 | 0 |
| L3 Registry | passed (L3-11: D-070 to D-090 contradict no decision; D-090 narrows D-062 and names it) | 0 | 0 | 0 |
| L4 Canonical registry (platform merge) | not run: the app has one platform (L4-14 included) | 0 | 0 | 0 |
| L5 Flows | findings (L5-02 on FL-07 and FL-08; L5-05: FL-05 covers the colour timer, the usage-time timer of F-015/F-065 and post expiry have no flow yet, step 5 is in progress; L5-07 not reached) | 0 | 2 | 0 |
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
| B5 Flows | passed (B5-01: every step of FL-04 to FL-08 follows a path the inventory shows; B5-02: every undrawn case is settled by D-070 to D-090 or is an open question of its feature; B5-03: FL-05 comes from F-024 and D-075) | 0 | 0 | 0 |
| B4 Canonical registry | not run: the app has one platform | 0 | 0 | 0 |
| B3 Per-platform registries | passed (the new fields of E-04, E-10 to E-14 and the new entity links of F-024, F-028, F-034, F-036 to F-042, F-052, F-053 come from D-070 to D-089) | 0 | 0 | 0 |
| B2 Raw extraction | passed (design and inventory unchanged) | 0 | 0 | 0 |
| B1 Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 0 | 1 |
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 2 | 10 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 0 blocking, 4 major, 12 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L1-04, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, L5-01, L5-06, G-01 and G-02 passed with no rows; G-03 passed with `--since 883a083` (the docs at the last check): no ID disappeared. L5-07 is "not reached: step 5 is in progress". Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 5 of the method: FL-01 to FL-08 are written.

Since the last check (883a083): FL-04 to FL-08 and D-070 to D-090 were added; the design did not change. Old findings 1 to 8 are unchanged (now 3, 4 and 7 to 12); findings 1, 2, 5, 6 and 13 to 16 are new.

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L5-02 | Major | A | FL-07, F-040, E-11 | FL-07 step 5 (`conception-systeme.md` line 409): « 5. Citer un message \| P-09 \| F-040 \| E-11 \| E-11 (message cité, écrit avec l'envoi) », so F-040 reads E-11; but F-040 has `operations: [écriture]` (`registry.md` line 1013), and the flow's own summary (line 414) says « F-040, F-041 et F-042 écrivent ». | — | Either drop E-11 from the « Entités lues » cell of step 5 in the flows Claude Doc (the quoted message is already read by F-038), or add `lecture` to F-040's `operations` in the registry Claude Doc. Then import and promote. |
| 2 | L5-02 | Major | A | FL-08, F-009.a, F-020, F-021, F-010.a, E-04 | FL-08 step 6 (line 476): « 6. Passer d'un résultat à l'autre \| P-16 \| F-009.a, F-020, F-021 \| E-03, E-04 ». None of these reads E-04: F-009, F-020 and F-021 have `entites: [E-03]` (query on `refs`). FL-02 step 2 reads E-04 through F-010, which step 6 does not list. | — | In the flows Claude Doc, add F-010.a to step 6's features, or drop E-04 from that row. Then import and promote. |
| 3 | B1-01 | Minor | C | P-03, P-10, F-036, F-052 | Unchanged. `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 951 `storyOn: !!storyView`) that nothing on the Accueil opens, and a search state (line 359 `searchOpen: false`, line 966 `searchOn`, lines 968-969 `openSearch` / `closeSearch`) with no entry, which searches by colour name (line 820 `this.colourFor(s.query)`), against F-052 and D-087. `Profile.dc.html` computes values it never shows (line 525 `leaves`, line 611 `usageHint`). No decision records them as unused design code. | — | See question 1. |
| 4 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged. The Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 251, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 2. |
| 5 | T-04 | Major | A | D-090, D-062, F-005.a, FL-03, P-12, P-14, P-15, P-16 | D-090 (`registry.md` line 2119): opened from P-14, P-15 or P-16, the creation closes on P-14, « D-062 vaut pour les autres pages ». F-005.a (line 469) still says the cross « revient à la page d'où elle a été ouverte (D-062) », and FL-03's decision point (`conception-systeme.md` line 181) « retour à la page d'origine (D-062) », without the exception. FL-08 (lines 462, 496) and the inventory (line 300) do carry it. | — | In the registry Claude Doc, end F-005.a's `difference` with « ; ouverte depuis la Recherche (P-14 à P-16), sur P-14 (D-090) », and add « ; depuis la Recherche, P-14 (D-090) » to FL-03's row in the flows Claude Doc. Then import and promote. |
| 6 | T-04 | Major | B | D-086, F-058, P-17, P-18, E-04 | D-086 (line 2099): « Dans toute l'app, une photo ou une vidéo n'est jamais montrée telle quelle » and « Le flou du design tient lieu de cet art ». F-058 still has `etats_ui` « nette environ 1 s » then « floutée » (lines 1320-1321), and the inventory (line 426) « Nette environ 1 s après un changement, puis floutée »: the user's real photo is shown for 1 s. D-086 does not say whether this second stays, as the typed text does before the charabia (F-041, D-083). | — | See question 3. |
| 7 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 (line 1869) says « lettré dans l'ordre du canvas », but in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-69). | — | Keep the letters (IDs are never renumbered) and reword D-040 in the registry Claude Doc: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. Then import and promote. |
| 8 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | Unchanged. D-042 (line 1879) gives accept and refuse an invitation the ring in the button, then the error with « Réessayer ». F-028 `etats_ui` (line 861) says only « réponse en cours : anneau dans « Accepter », les deux boutons désactivés », and the inventory's « Refuser une invitation » row (`inventaire-des-ecrans.md` line 115) lists « La ligne disparaît » alone, while « Accepter » (line 114) cites P-04.d and P-04.e. | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and the same note on the inventory's « Refuser une invitation » row. Then import and promote. |
| 9 | T-04 | Minor | A | F-010, F-010.a, D-046, D-049 | Unchanged. The merge note of F-010 (`registry.md` line 2142) still says « P-16 sans actions en variante », while F-010.a (line 565) says « se comporte comme un post du fil, avec les mêmes actions (D-046, D-049) ». | — | In the registry Claude Doc, end the F-010 row with « ; actions ajoutées par D-046 et D-049 ». Then import and promote. |
| 10 | T-04 | Minor | A | D-056, D-066, P-04.a | Unchanged. D-056 (line 1949) still says P-04.a's text becomes « Les invitations, les likes et les commentaires reçus s’affichent ici. », and D-066 (line 1999) sets a different text for the same state without naming D-056. | — | In the registry Claude Doc, add to D-066's `choix` « ; remplace le texte de D-056 ». Then import and promote. |
| 11 | T-04 | Minor | A | D-056, D-061, F-022, P-04 | Unchanged. Every notification of P-04 has a thumbnail, not only likes. The inventory still says « Voir le post liké \| Miniature carrée à droite de chaque like » (line 117), and F-022's question « Ouvrir le post liké depuis sa miniature » (`registry.md` line 779). | — | In the inventory, « Voir le post concerné \| Miniature carrée à droite de chaque notification »; in F-022, « Ouvrir le post concerné depuis sa miniature ». Then import and promote. |
| 12 | T-04 | Minor | A | D-024, D-054, F-019 | Unchanged. F-019's `questions_ouvertes` still holds « Un lien de post ouvert sans connexion mène à la connexion (P-01) » (line 733), which D-024 and D-054 settled. | — | In the registry Claude Doc, remove that line from F-019's questions. Then import and promote. |
| 13 | T-04 | Minor | A | D-088, F-050, F-020, FL-03 | D-088 (line 2109) settled who can see a post. FL-03 still lists as open « F-050 : règle de l'audience (qui voit le post et agit dessus) » (`conception-systeme.md` line 210), and F-020 « Lire l'auteur et la légende » keeps « Accès supposé : visible sur tout post qu'on peut voir (audience du post, F-050) » (`registry.md` line 748), which is the seeing D-088 settled. F-050's own question (line 1189) and FL-08 (line 512) were updated. | — | In the flows Claude Doc, FL-03 line 210 « F-050 : agir sur un post suit-il aussi son audience ? (qui le voit : D-088) »; in the registry Claude Doc, replace F-020's question with « Visible sur tout post qu'on peut voir (D-088) » outside the questions, or remove it. Then import and promote. |
| 14 | T-04 | Minor | A | D-082, F-019, F-019.a, E-10 | D-082 (line 2079): « Une conversation (E-10) n'existe qu'entre deux amis […] rien ne permet d'écrire à un autre compte ». F-019.a sends the post as a message into that conversation (FL-02 step 6a), yet F-019 still asks « Envoyer à un ami (F-019.a) : amis seulement (ami ou non, E-09) » (line 732), and FL-02 lists « F-019 : rangée limitée aux amis » as open (`conception-systeme.md` line 137). D-082's `impacte` does not name F-019. | — | In the registry Claude Doc, remove F-019's question or turn it into « amis seulement (D-082) », and add F-019 to D-082's `impacte`; drop « rangée limitée aux amis » from FL-02's open list. Then import and promote. |
| 15 | T-04 | Minor | A | D-086, F-010, P-03 | D-086 settles what replaces the demo shapes: art generated from each photo's seed. F-010's question « Vrais médias à la place des formes générées » (`registry.md` line 572) and the inventory's « formes générées en démo ; vrais médias : à confirmer » (`inventaire-des-ecrans.md` line 67) do not cite it; the open part now lives in F-042's question « Art généré (D-086) : quels algorithmes, et comment pour une vidéo ? ». | — | In the registry Claude Doc, reword F-010's question « Art généré à partir de la graine de chaque photo (D-086) : voir F-042 », or remove it; in the inventory, « vrais médias : art généré, D-086 ». Then import and promote. |
| 16 | T-04 | Minor | A | D-086, E-12, E-04, F-036 | D-086 applies « dans toute l'app » and makes E-04 keep the seed and the algorithm, not the image. E-12 still has a plain « images » field (line 1619), F-036 shows story images without reading E-04 (`entites: [E-12, E-09]`), and D-086's `impacte` names neither E-12 nor F-036; FL-06 step 2 reads « E-12 (images, …) » (`conception-systeme.md` line 351). | — | In the registry Claude Doc, write E-12's field as « images (médias E-04 : graine et algorithme, D-086) » and add E-12 and F-036 to D-086's `impacte`. Then import and promote. |

## Questions for the owner

1. **Leftover code in the design (finding 3, class C).**
   - a. Remove the story player and the search state (with its colour search) from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`. Recommended: nothing reaches them, and the colour search contradicts F-052 and D-087.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
2. **Wording of the support offer (finding 4, class C).**
   - a. « Une heure passée ici. » everywhere.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.
3. **The real profile photo shown for 1 s (finding 6, class B).**
   - a. Keep it: on one's own phone, the chosen photo shows as is for about 1 s, then becomes its generated art, like the typed text before the charabia (D-083). Record it in a decision, or in D-086. Recommended: it is what the design draws, and the photo never leaves the phone.
   - b. Never show it: the generated art appears at once; F-058 loses « nette environ 1 s » and P-17 is redrawn (F-058 gets `design_a_mettre_a_jour: true`).
   - c. Same as a., and also say whether the gallery of F-044 and F-045 shows one's own photos as they are.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 28 pages, 60 page states, 65 features, 21 variants, 17 entities, 90 decisions, 10 retired IDs, 8 flows. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read: all of FL-04 to FL-08 and FL-02 in `conception-systeme.md`; the diff of `claude_docs/` from 883a083 to f2afcbf (D-070 to D-090 and every feature and entity they changed); F-005, F-009, F-010, F-019 to F-022, F-026 to F-028, F-033, F-040, F-050, F-051, F-053, F-058, F-062; E-08, E-12; the inventory's P-08 to P-10 story rows and every « flou », « nette » and « à confirmer » it holds.
- L5-02: every step of FL-04 to FL-08 was compared with the `entites` and `operations` of its features and variants, by query on `refs` and `features`.
- T-04 ran on D-070 to D-090: each decision's `impacte` and each document it should change (registry, inventory, flows).
- Design: `claude_design/` is unchanged since 883a083; L1-03 re-checked by hash against `fake-scrolling-app/.claude-ai.json`. The live canvas on claude.ai was not opened, as the check requires.
- Older findings' evidence was re-checked by grep at the lines quoted; line numbers that moved were updated.
- T-02, T-03 and U-01 to U-03 need later layers.

## Hand-off to the code check
Commit checked: f2afcbf. Verdict: ready for the code check, no blocking finding.

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
