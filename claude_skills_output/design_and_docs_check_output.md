# Top to bottom check · Fake scrolling · 2026-11-25

Documents: commit ebd658d · Mode: B (database built from ebd658d, fingerprint 197c1007d2179fac)
Method followed: version of 2026-11-24 (method overview revision 90, describe revision 23, reference revision 26, verification revision 9, check instruction revision 54)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed (the flows and the state diagrams are in `claude_docs/conception-systeme.md`; 10 flows read by the database; the TLA+ models step 6 requires are missing, recorded under L6-03) | 0 | 0 | 0 |
| L1 Design | passed (`claude_design/` changed since f2afcbf only for D-097: P-17 grid without remaining days, P-17.a text; L1-03: its 69 files match `.claude-ai.json` by hash, `index.html`, `artifact-type/dc-runtime.js` and `project/support.js` unlisted as before; L1-04: query passed, F-062's flag cleared) | 0 | 0 | 0 |
| L2 Raw extraction | passed (28 screens, 60 page states, unchanged; L2-03: the inventory's « à confirmer » on the payment, the deletion and the theme became D-092, D-101 and D-103) | 0 | 0 | 0 |
| L3 Registry | passed (L3-11: D-091 to D-107 contradict no decision; D-097 names the D-051 text it replaces) | 0 | 0 | 0 |
| L4 Canonical registry (platform merge) | not run: the app has one platform (L4-14 included) | 0 | 0 | 0 |
| L5 Flows | findings (L5-02, L5-03, L5-04 passed on FL-09 and FL-11; L5-05: 2 background jobs without a flow; L5-07 not reached) | 0 | 2 | 0 |
| L6 Entity states and TLA+ | findings (L6-01 passed: the 8 diagrams D-107 chose; L6-02: 1 finding; L6-03: no TLA+ model written; L6-04 not reached: no model, no `BR`; L6-05 not run: no model, see finding 4) | 0 | 2 | 0 |
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
| B6 Entity states and TLA+ | passed, apart from what findings 1 and 2 cause (B6-01: every state is drawn or comes from a decision: « Vue » D-106, « Soutenu, pas encore enregistré » D-095, « Finie » D-079; B6-02: « En cours → Finie » of SM-E-12 and « → Soutenu » of SM-E-16 are triggered by jobs that have no flow, caused by findings 2 and 1, not counted again; B6-03 not reached) | 0 | 0 | 0 |
| B5 Flows | passed (B5-01: every step of FL-09 and FL-11 follows a path the inventory shows: « Premium », « Gérer mon compte », « Interface de l'appli » on P-20, « Modifier » and the photo on P-17; B5-02: every undrawn case is settled by D-092 to D-104 or open in F-015, F-058, F-062; B5-03: F-073 comes from D-096) | 0 | 0 | 0 |
| B4 Canonical registry | not run: the app has one platform | 0 | 0 | 0 |
| B3 Per-platform registries | passed (F-073 comes from D-096; the new fields of E-01, E-08, E-14 to E-17 come from D-092, D-093, D-095, D-098, D-103, D-105, D-106) | 0 | 0 | 0 |
| B2 Raw extraction | passed (the inventory's changes all follow D-092, D-097 to D-099, D-101, D-103) | 0 | 0 | 0 |
| B1 Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 1 | 1 |
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 0 | 11 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 0 blocking, 5 major, 13 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L1-04, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, L5-01, L5-06, G-01 and G-02 passed with no rows; G-03 passed with `--since f2afcbf` (the docs at the last check): no ID disappeared. L5-07 is "not reached: step 5 is in progress". Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project is at step 6 of the method: FL-01 to FL-09 and FL-11 are written (FL-10 was only ever planned, never defined, and D-097 removed its subject), and the 8 state diagrams D-107 chose are written; their TLA+ models are not.

Tooling note: the database does not index the state diagrams. `ids` has no kind for `SM-E-xx` (`registry_db.py where SM-E-14` finds no definition), so G-01, G-02 and the future L6-04 query do not cover them. Checked by reading instead: each of SM-E-02, -03, -08, -09, -10, -12, -14, -16 is defined once by its heading in `conception-systeme.md`, and every citation of them (F-019, F-036, F-060 in `registry.md`, the TLA+ table) names one of these. To fix in workflow_claude's `registry-db` skill, not in this app.

Since the last check (f2afcbf): FL-09, FL-11, the state diagrams and D-091 to D-107 were added; P-17 was redrawn for D-097. Old findings 1, 2, 5 and 6 are fixed (FL-07 and FL-08 steps, F-005.a and FL-03 now carry D-090, D-091 settles the profile photo's second). Old findings 3, 4 and 7 to 16 are unchanged (now 6, 7 and 9 to 18); findings 1 to 5 and 8 are new.

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L5-05 | Major | B | D-077, D-078, D-095, D-100, D-104, F-060, F-061, F-036, F-015, F-058, E-14, E-12, E-16, E-04 | The resend of what waits for the server is a background job (a scheduled send) with no flow of its own. Pieces of it are spread over four flows: FL-05 « Appliquée sur le téléphone, renvoyée sans message (D-077) » (`conception-systeme.md` line 315), FL-06 « renvoyé sans message (D-078) » (line 371), FL-09 « l'achat est renvoyé sans message à chaque ouverture (D-095, comme D-077) » (line 551), FL-11 « Envois en attente (D-077, D-095, D-100) » (line 619). D-107 already gives it a TLA+ model (« Synchronisation », line 905). Nothing says when it runs (each opening only, or also when the network comes back), in which order, or what happens when the server refuses a send for good; F-060 asks which of two phones' settings wins (`registry.md` line 1355). | — | See question 1. |
| 2 | L5-05 | Major | A | D-079, E-12, F-036, FL-06 | SM-E-12 makes the end of a story a background job: « En cours → Finie \| 24 h écoulées (tâche de fond) » (`conception-systeme.md` line 830). No flow describes that job: FL-06 only shows what a viewer sees once it has happened (line 367), and F-036 asks what becomes of a finished story (`registry.md`, F-036 `questions_ouvertes`). | — | In the flows Claude Doc, either write a short background-job flow for the end of a story from D-079 and SM-E-12 (trigger: the `fin` field of E-12 reached; effect: no more circle, P-10.b; cleanup: F-036's open question), or, if no job runs and the end is only read at each load, reword SM-E-12's trigger to « fin (E-12) atteinte, lue à chaque chargement (D-079) ». Then import and promote. |
| 3 | L6-02 | Major | A | SM-E-14, SM-E-16, F-070, E-14, E-15, E-16 | SM-E-14 starts with `[*] --> arrete : F-070` (`conception-systeme.md` line 842) and SM-E-16 with `[*] --> non_soutenu : F-070` (line 875): account creation creates the timer and the support record. But F-070 has `entites: [E-02, E-01]` (`registry.md` line 1464), and neither E-14 (`utilisee_par: [F-024, F-059, F-060, F-061, F-063]`, line 1658) nor E-16 (`utilisee_par: [F-015, F-063]`, line 1674) lists F-070. | — | In the registry Claude Doc, add E-14 and E-16 to F-070's `entites`, and F-070 to their `utilisee_par` (and E-15 too if it is created at sign-up rather than by F-073's first second); or, in the flows Claude Doc, drop « F-070 » from the two initial moves and say the record starts with its default values. Then import and promote. |
| 4 | L6-03 | Major | A | D-107, SM-E-09, SM-E-12, SM-E-14, SM-E-16 | D-107 (`registry.md` line 2233) chooses TLA+ models for SM-E-09, SM-E-12, SM-E-14, SM-E-16 and for sync between phones (D-104, D-105). None exists: `conception-systeme.md` line 895 « Modèles TLA+ à écrire », and no `.tla` file is in the repo. | — | Write the five models (`workflow_docs/method/verification.md`: `docs/system-design/SM-E-xx.tla`, `sync.tla`) with the rules of the table at lines 899-905, and run the model checker in CI. Their rules need `BR` IDs in a feature spec or a cross-cutting page (L6-04), so either write those rules on the cross-cutting page at step 7, or keep the models until step 10. |
| 5 | G-04 | Major | B | D-078, D-101, D-104, F-071, F-063, E-12 | The list of sends that wait for the server differs between documents. D-104 (`registry.md` line 2215) and D-101 (line 2197) name three: « minuteur, D-077 ; soutien, D-095 ; photo de profil, D-100 », and so does FL-11 (`conception-systeme.md` line 619). The sync model's row (line 905) and SM-E-12 (line 829) add a fourth: a story's « vue », « renvoyé sans message au serveur (D-078) ». Nothing says whether a pending « vue » is kept at logout (D-104) or dropped with the account (D-101). | — | See question 2. |
| 6 | B1-01 | Minor | C | P-03, P-10, F-036, F-052, D-074, D-086 | Unchanged. `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 951 `storyOn: !!storyView`) that nothing on the Accueil opens, and a search state (line 359 `searchOpen: false`, line 966 `searchOn`, lines 968-969 `openSearch` / `closeSearch`) with no entry, which searches by colour name (line 820 `this.colourFor(s.query)`), against F-052 and D-087. `Profile.dc.html` computes values it never shows: line 610 `usageHint`, and lines 524-529 `leaves`, whose text now also contradicts decisions: « Fil, minuteur, pauses · générés sur ce téléphone » (the timer is on the server, D-074) and « Photos et vidéos · miniature 32×40 floutée, 7 jours » (only the seed and the algorithm leave the phone, D-086). No decision records them as unused design code. | — | See question 3. |
| 7 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged. The Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 250, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40), as FL-09 quotes it (`conception-systeme.md` line 547). | — | See question 4. |
| 8 | T-04 | Minor | A | D-089, F-053, P-14 | D-089 settled where the suggestions come from (charabia drawn by the app, 8 at random at each opening). The inventory still says « origine des suggestions : à confirmer » (`inventaire-des-ecrans.md` line 347). | — | In the inventory Claude Doc, replace it with « tirées au hasard par l'app à chaque ouverture (D-089) ». Then import and promote. |
| 9 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 (`registry.md` line 1882) says « lettré dans l'ordre du canvas », but in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-69). | — | Keep the letters (IDs are never renumbered) and reword D-040 in the registry Claude Doc: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. Then import and promote. |
| 10 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | Unchanged. D-042 (line 1892) gives accept and refuse an invitation the ring in the button, then the error with « Réessayer ». F-028 `etats_ui` (line 860) says only « réponse en cours : anneau dans « Accepter », les deux boutons désactivés », and the inventory's « Refuser une invitation » row (`inventaire-des-ecrans.md` line 115) lists « La ligne disparaît » alone, while « Accepter » (line 114) cites P-04.d and P-04.e. | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and the same note on the inventory's « Refuser une invitation » row. Then import and promote. |
| 11 | T-04 | Minor | A | F-010, F-010.a, D-046, D-049 | Unchanged. The merge note of F-010 (`registry.md` line 2258) still says « P-16 sans actions en variante », while F-010.a (line 564) says it « se comporte comme un post du fil, avec les mêmes actions (D-046, D-049) ». | — | In the registry Claude Doc, end the F-010 row with « ; actions ajoutées par D-046 et D-049 ». Then import and promote. |
| 12 | T-04 | Minor | A | D-056, D-066, P-04.a | Unchanged. D-056 (line 1962) still says P-04.a's text becomes « Les invitations, les likes et les commentaires reçus s’affichent ici. », and D-066 (line 2012) sets a different text for the same state without naming D-056. | — | In the registry Claude Doc, add to D-066's `choix` « ; remplace le texte de D-056 ». Then import and promote. |
| 13 | T-04 | Minor | A | D-056, D-061, F-022, P-04 | Unchanged. Every notification of P-04 has a thumbnail, not only likes. The inventory still says « Voir le post liké \| Miniature carrée à droite de chaque like » (line 117), and F-022's question « Ouvrir le post liké depuis sa miniature » (`registry.md` line 779). | — | In the inventory, « Voir le post concerné \| Miniature carrée à droite de chaque notification »; in F-022, « Ouvrir le post concerné depuis sa miniature ». Then import and promote. |
| 14 | T-04 | Minor | A | D-024, D-054, F-019 | Unchanged. F-019's `questions_ouvertes` still holds « Un lien de post ouvert sans connexion mène à la connexion (P-01) » (line 732), which D-024 and D-054 settled. | — | In the registry Claude Doc, remove that line from F-019's questions. Then import and promote. |
| 15 | T-04 | Minor | A | D-088, F-050, F-020, FL-03 | Unchanged. D-088 (line 2122) settled who can see a post. FL-03 still lists as open « F-050 : règle de l'audience (qui voit le post et agit dessus) » (`conception-systeme.md` line 211), and F-020 keeps « Accès supposé : visible sur tout post qu'on peut voir (audience du post, F-050) » (`registry.md` line 748). | — | In the flows Claude Doc, FL-03 line 211 « F-050 : agir sur un post suit-il aussi son audience ? (qui le voit : D-088) »; in the registry Claude Doc, replace F-020's question with « Visible sur tout post qu'on peut voir (D-088) » outside the questions, or remove it. Then import and promote. |
| 16 | T-04 | Minor | A | D-082, F-019, F-019.a, E-10 | Unchanged. D-082 (line 2092) lets a conversation exist only between two friends. F-019 still asks « Envoyer à un ami (F-019.a) : amis seulement (ami ou non, E-09) » (line 731), FL-02 lists « F-019 : rangée limitée aux amis » as open (`conception-systeme.md` line 137), and D-082's `impacte` (line 2096) does not name F-019. | — | In the registry Claude Doc, remove F-019's question or turn it into « amis seulement (D-082) », and add F-019 to D-082's `impacte`; drop « rangée limitée aux amis » from FL-02's open list. Then import and promote. |
| 17 | T-04 | Minor | A | D-086, F-010, P-03 | Unchanged. F-010's question « Vrais médias à la place des formes générées » (`registry.md` line 571) and the inventory's « formes générées en démo ; vrais médias : à confirmer » (`inventaire-des-ecrans.md` line 67) do not cite D-086; the open part lives in F-042's question. | — | In the registry Claude Doc, reword F-010's question « Art généré à partir de la graine de chaque photo (D-086) : voir F-042 », or remove it; in the inventory, « vrais médias : art généré, D-086 ». Then import and promote. |
| 18 | T-04 | Minor | A | D-086, E-12, E-04, F-036 | Unchanged. D-086 applies « dans toute l'app ». E-12 still has a plain « images » field (`registry.md` line 1630), F-036 shows story images without reading E-04 (`entites: [E-12, E-09]`), D-086's `impacte` (line 2116) names neither E-12 nor F-036, and FL-06 step 2 reads « E-12 (images, …) » (`conception-systeme.md` line 351). | — | In the registry Claude Doc, write E-12's field as « images (médias E-04 : graine et algorithme, D-086) » and add E-12 and F-036 to D-086's `impacte`. Then import and promote. |

## Questions for the owner

1. **A flow for the sends that wait for the server (finding 1, class B).**
   - a. Write one background-job flow for them (next free FL number): what waits (D-077, D-078, D-095, D-100), when it is sent (each opening, and when the network comes back), the order, what happens when the server refuses a send for good, and which of two phones wins for the timer (F-060's question). Recommended: D-107 already gives it a TLA+ model, which needs these rules.
   - b. Keep the four flows as they are, and record in a decision that each one's « renvoyé sans message » row is the whole job.
2. **A story's « vue » waiting to be sent (finding 5, class B).**
   - a. Treat it like the other three: kept at logout for the same account (D-104), dropped with the account (D-101); add D-078 to both decisions and to FL-11. Recommended: one rule for every pending send.
   - b. Drop a pending « vue » at logout: it only greys a circle on that phone.
3. **Leftover code in the design (finding 6, class C).**
   - a. Remove the story player and the search state (with its colour search) from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`. Recommended: nothing reaches them, and their text now contradicts F-052, D-074, D-086 and D-087.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
4. **Wording of the support offer (finding 7, class C).**
   - a. « Une heure passée ici. » everywhere. Recommended: FL-09 already quotes it.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 28 pages, 60 page states, 66 features, 21 variants, 17 entities, 107 decisions, 10 retired IDs, 10 flows; the 8 state diagrams are not in the database (tooling note above) and were read in full. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read: all of `conception-systeme.md` (FL-01 to FL-09, FL-11, the state diagrams and the TLA+ table); the diff of `claude_docs/` and `claude_design/` from f2afcbf to ebd658d (D-091 to D-107 and every feature, entity and inventory row they changed); F-019, F-036, F-057, F-060, F-061, F-070; E-12, E-14 to E-16.
- L5-02: every step of FL-09 and FL-11, and FL-04 step 4, compared with the `entites` and `operations` of their features, by query on `refs` and `features`.
- L6-02: every move of the 8 diagrams compared with the flows and with the `entites` and `operations` of the feature that triggers it.
- T-04 ran on D-091 to D-107: each decision's `impacte` and each document it should change (registry, inventory, flows, design).
- Design: L1-03 re-checked by hash against `fake-scrolling-app/.claude-ai.json`; the two changed files read in full in the diff. The live canvas on claude.ai was not opened, as the check requires.
- Older findings' evidence was re-checked by grep at the lines quoted; line numbers that moved were updated.
- T-02, T-03 and U-01 to U-03 need later layers.

## Hand-off to the code check
Commit checked: ebd658d. Verdict: ready for the code check, no blocking finding.

There is nothing for the code checker to verify yet: no feature is at step 10, and there is no code.

| Expectation | From the documents today |
| --- | --- |
| One folder per canonical feature at step 10 or beyond | None: no feature has a spec |
| A test for every rule (`BR`) and criterion (`AC`) | None: no spec, no cross-cutting page |
| A screenshot for every visible criterion per platform | None: no proof block |
| A test for every model-checker failure trace | None: no TLA+ model yet (finding 4) |
| Every table and column of the data model | None: no data model |
| Every event named in a spec | None |
| One flag per feature not fully released | None: no backlog |
| The import rules | None: no code structure or lint config yet |
