# Top to bottom check · Fake scrolling · 2026-11-25

Documents: commit ba98a99 · Mode: B (database built from ba98a99, fingerprint d98acdaf4eabdfe8)
Method followed: version of 2026-11-24 (method overview revision 90, describe revision 23, reference revision 26, verification revision 9, check instruction revision 54)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed (flows and state diagrams in `claude_docs/conception-systeme.md`, 12 flows read by the database; the 5 TLA+ models in `docs/system-design/`) | 0 | 0 | 0 |
| L1 Design | passed (`claude_design/` changed since ebd658d only for D-120: new artboard `Etat-P13-transformation.dc.html`, P-13.c; L1-03: its 70 files match `.claude-ai.json` by hash, `index.html`, `artifact-type/dc-runtime.js` and `project/support.js` unlisted as before; L1-04: query passed) | 0 | 0 | 0 |
| L2 Raw extraction | passed (28 screens, 61 page states; P-13.c has its row in the inventory and its canvas title « P-13 · F-051 · Transformation avant publication ») | 0 | 0 | 0 |
| L3 Registry | passed (L3-11: D-108 to D-121 contradict no decision; D-112 says it widens D-095, D-116 says it refines D-113, D-119 is marked on D-086, D-091 and D-100) | 0 | 0 | 0 |
| L4 Canonical registry (platform merge) | not run: the app has one platform (L4-14 included) | 0 | 0 | 0 |
| L5 Flows | findings (L5-01, L5-06 passed by query; L5-02, L5-03, L5-04 passed on FL-12, FL-13 and the FL-03 rows D-120 changed; L5-05: old findings 1 and 2 fixed by FL-12 and FL-13, 1 new finding; L5-07 not reached) | 0 | 1 | 0 |
| L6 Entity states and TLA+ | findings (L6-01: 1 finding; L6-02 passed: old finding 3 fixed by D-114; L6-03 passed: 5 models, as D-107 chose; L6-04 not reached: the rules are named after decisions because no `BR` exists before step 7 or 10, as `conception-systeme.md` line 986 says; L6-05 passed: run 45631336891 of « TLA+ models » on c33b4c4, the last commit that touched `docs/system-design/`, success, 5 of 5 models « No error has been found ») | 0 | 1 | 0 |
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
| B6 Entity states and TLA+ | passed (B6-01: every state is drawn or comes from a decision; B6-02: « En cours → Finie » of SM-E-12 is now triggered by FL-13 and « → Soutenu » of SM-E-16 by FL-12; B6-03: every variable and action of the 5 models maps to an entity field, a move of its diagram or a FL-12 row, and ghost variables are marked as such) | 0 | 0 | 0 |
| B5 Flows | passed (B5-01: FL-13 step 3 follows the P-08 and P-09 loads; B5-02: every error case of FL-12 and FL-13 is settled by D-110 to D-116; B5-03: FL-12 comes from D-108, FL-13 from D-110) | 0 | 0 | 0 |
| B4 Canonical registry | not run: the app has one platform | 0 | 0 | 0 |
| B3 Per-platform registries | passed (F-070's new entities come from D-114; the new fields of E-03, E-04, E-05, E-12, E-14 to E-16 from D-114 to D-119) | 0 | 0 | 0 |
| B2 Raw extraction | passed (the inventory's changes follow D-118, D-120, D-121; P-13.c is drawn) | 0 | 0 | 0 |
| B1 Design | findings | 0 | 0 | 1 |
| G Global rules | findings | 0 | 0 | 1 |
| T Traces from the top down | findings (T-02 and T-03 not reached) | 0 | 0 | 14 |
| U Traces from the bottom up | not reached | 0 | 0 | 0 |

Totals: 0 blocking, 2 major, 16 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L1-04, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, L5-01, L5-06, G-01 and G-02 passed with no rows; G-03 passed with `--since ebd658d` (the docs at the last check): no ID disappeared. L5-07 is "not reached: step 5 is in progress". Every L4, L8, L9, L10, B10, B9, B8 and B4 query is "not reached" (one platform, no data model, no data flows, no page contract). The project has finished step 6 apart from finding 2: FL-01 to FL-09 and FL-11 to FL-13 are written, the 8 state diagrams D-107 chose, and the 5 TLA+ models, checked in CI. Next is step 7 (NFRs).

Tooling note, unchanged: the database does not index the state diagrams (`registry_db.py where SM-E-14` finds no definition; `ids` has no kind for `SM-E-xx`), so G-01, G-02 and the future L6-04 query do not cover them. Checked by reading: each of the 8 diagrams is defined once by its heading in `conception-systeme.md`, and every citation (FL-13, the TLA+ table, the `.tla` headers) names one of them. To fix in workflow_claude's `registry-db` skill, not in this app.

Since the last check (ebd658d): FL-12, FL-13, the 5 TLA+ models with their CI workflow, D-108 to D-121 and P-13.c were added. Old findings 1 to 5 are fixed (FL-12 by D-108; FL-13 by D-110; F-070's entities by D-114; the TLA+ models; the pending « vue » by D-109). Old findings 6 to 18 are unchanged (now 3, 4 and 8 to 18); findings 1, 2 and 5 to 7 are new.

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L5-05 | Major | B | D-120, D-121, D-108, D-101, D-104, F-044, F-046, F-005.a, E-04, FL-03, FL-12 | D-120 (`registry.md` line 2321) makes the seed of each chosen photo a send that waits for the network: « Sans réseau, la graine part dès qu'il revient, au plus tard avec la publication. » D-121 (line 2327) makes the server erase sent seeds when a photo is removed or the draft closed, which is a second send. Neither is in FL-12: its entries are FL-05, FL-06, FL-09 and FL-11 only (`conception-systeme.md` lines 650-655), D-108's list names four kinds (line 2249), and its « Hors de ce flow » (line 657) only excludes sends with « Réessayer ». Nothing says what happens to a seed or an erase request that cannot reach the server (failed while online, still waiting at F-071 or F-063, an erase made offline), and FL-03 has no error case for it (lines 172-191). F-044 asks when a lost draft's seeds are erased (line 1093), but FL-03's open list (lines 204-213) does not name that question. | — | See question 1. |
| 2 | L6-01 | Major | B | D-107, D-120, D-121, E-04, SM-E-03, SM-E-12, F-044 | Since D-120 and D-121, a media (E-04) lives on the server before its post: a seed sent from a draft, erased when the photo is removed or the draft closed (D-121), kept once the post or story is published, and maybe left behind by a lost draft (F-044's question, `registry.md` line 1093). Its erase rule depends on that state. D-107 (line 2243) still says « Les autres entités ne font qu'exister puis être effacées », and so does `conception-systeme.md` line 737, which lists E-04 among them. The seed's life is only told in two rows of SM-E-03 (lines 807-808), and SM-E-12 only says « Même brouillon que SM-E-03 » (line 890). | — | See question 2. |
| 3 | B1-01 | Minor | C | P-03, P-10, F-036, F-052, D-074, D-086 | Unchanged. `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 951 `storyOn: !!storyView`) that nothing on the Accueil opens, and a search state (line 359 `searchOpen: false`, line 966 `searchOn`, lines 968-969 `openSearch` / `closeSearch`) with no entry, which searches by colour name (line 820 `this.colourFor(s.query)`), against F-052 and D-087. `Profile.dc.html` computes values it never shows: line 610 `usageHint`, and lines 524-529 `leaves`, whose text contradicts decisions: « Fil, minuteur, pauses · générés sur ce téléphone » (line 525; the timer is on the server, D-074) and « Photos et vidéos · miniature 32×40 floutée, 7 jours » (line 527; only the seed leaves the phone, D-086, D-119). No decision records them as unused design code. | — | See question 3. |
| 4 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged. The Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 250, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40), as FL-09 quotes it (`conception-systeme.md` line 547) and the inventory (`inventaire-des-ecrans.md` line 529). | — | See question 4. |
| 5 | T-04 | Minor | A | D-112, D-095, E-16, SM-E-16 | D-112 (`registry.md` line 2273) « élargit le « à chaque ouverture » de D-095 »: sends also go back to the foreground and when the network returns. E-16 still says « achat du store, renvoyé à chaque ouverture tant que le serveur ne l'a pas enregistré (D-095) » (line 1681), and SM-E-16 « Renvoyé sans message à chaque ouverture jusque-là (D-095) » (`conception-systeme.md` line 979). D-112's `impacte` does not name E-16. | — | In the registry Claude Doc, write E-16's field « achat du store, renvoyé par FL-12 tant que le serveur ne l'a pas enregistré (D-095, D-112) … » and add E-16 to D-112's `impacte`; in the flows Claude Doc, SM-E-16 « Renvoyé sans message par FL-12 jusque-là (D-095, D-112) ». Then import and promote. |
| 6 | T-04 | Minor | A | D-119, E-04, FL-07, FL-11, F-042, F-058 | D-119 (`registry.md` line 2315): « seule la graine quitte le téléphone. Le serveur choisit l'algorithme ». FL-07 step 7 still writes « E-04 (graine et algorithme, D-086) » from the phone (`conception-systeme.md` line 411), and FL-11 step 4 « E-04 (graine et algorithme, D-086), E-01 (photo) ; renvoyés sans message (D-100) » (line 593). | — | In the flows Claude Doc, write both cells « E-04 (graine ; algorithme choisi par le serveur, D-086, D-119) ». Then import and promote. |
| 7 | T-04 | Minor | A | D-108, D-110, FL-12, FL-13 | The state diagrams' introduction still says they are « tiré[s] des flows FL-01 à FL-09 et FL-11 » (`conception-systeme.md` line 737), while SM-E-12, SM-E-14 and SM-E-16 now cite FL-12 and FL-13. | — | In the flows Claude Doc, « tiré des flows FL-01 à FL-09 et FL-11 à FL-13 ». Then import and promote. |
| 8 | T-04 | Minor | A | D-089, F-053, P-14 | Unchanged. D-089 settled where the suggestions come from. The inventory still says « origine des suggestions : à confirmer » (`inventaire-des-ecrans.md` line 348). | — | In the inventory Claude Doc, replace it with « tirées au hasard par l'app à chaque ouverture (D-089) ». Then import and promote. |
| 9 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 (`registry.md` line 1892) says « lettré dans l'ordre du canvas », but in `canvas.json`, row y=2364, « P-03 · F-015.a · Paiement échoué » is at x=-470 and « P-03 · F-009 · Fil : erreur de chargement » at x=1880, so canvas order gives P-03.b Paiement échoué, P-03.c Fil : erreur. The registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué » (lines 64-69). | — | Keep the letters (IDs are never renumbered) and reword D-040 in the registry Claude Doc: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. Then import and promote. |
| 10 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | Unchanged. D-042 (line 1900) gives accept and refuse an invitation the ring in the button, then the error with « Réessayer ». F-028 `etats_ui` (line 865) says only « réponse en cours : anneau dans « Accepter », les deux boutons désactivés », and the inventory's « Refuser une invitation » row (`inventaire-des-ecrans.md` line 115) lists « La ligne disparaît » alone, while « Accepter » (line 114) cites P-04.d and P-04.e. | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and the same note on the inventory's « Refuser une invitation » row. Then import and promote. |
| 11 | T-04 | Minor | A | F-010, F-010.a, D-046, D-049 | Unchanged. The merge note of F-010 (`registry.md` line 2350) still says « P-16 sans actions en variante », while F-010.a (line 568) says it « se comporte comme un post du fil, avec les mêmes actions (D-046, D-049) ». | — | In the registry Claude Doc, end the F-010 row with « ; actions ajoutées par D-046 et D-049 ». Then import and promote. |
| 12 | T-04 | Minor | A | D-056, D-066, P-04.a | Unchanged. D-056 (line 1972) still says P-04.a's text becomes « Les invitations, les likes et les commentaires reçus s’affichent ici. », and D-066 (line 2022) sets a different text for the same state without naming D-056. | — | In the registry Claude Doc, add to D-066's `choix` « ; remplace le texte de D-056 ». Then import and promote. |
| 13 | T-04 | Minor | A | D-056, D-061, F-022, P-04 | Unchanged. Every notification of P-04 has a thumbnail, not only likes. The inventory still says « Voir le post liké \| Miniature carrée à droite de chaque like » (line 117), and F-022's question « Ouvrir le post liké depuis sa miniature » (`registry.md` line 784). | — | In the inventory, « Voir le post concerné \| Miniature carrée à droite de chaque notification »; in F-022, « Ouvrir le post concerné depuis sa miniature ». Then import and promote. |
| 14 | T-04 | Minor | A | D-024, D-054, F-019 | Unchanged. F-019's `questions_ouvertes` still holds « Un lien de post ouvert sans connexion mène à la connexion (P-01) » (line 737), which D-024 and D-054 settled. | — | In the registry Claude Doc, remove that line from F-019's questions. Then import and promote. |
| 15 | T-04 | Minor | A | D-088, F-050, F-020, FL-03 | Unchanged. D-088 (line 2130) settled who can see a post. FL-03 still lists as open « F-050 : règle de l'audience (qui voit le post et agit dessus) » (`conception-systeme.md` line 211), and F-020 keeps « Accès supposé : visible sur tout post qu'on peut voir (audience du post, F-050) » (`registry.md` line 753). | — | In the flows Claude Doc, FL-03 line 211 « F-050 : agir sur un post suit-il aussi son audience ? (qui le voit : D-088) »; in the registry Claude Doc, replace F-020's question with « Visible sur tout post qu'on peut voir (D-088) » outside the questions, or remove it. Then import and promote. |
| 16 | T-04 | Minor | A | D-082, F-019, F-019.a, E-10 | Unchanged. D-082 (line 2100) lets a conversation exist only between two friends. F-019 still asks « Envoyer à un ami (F-019.a) : amis seulement (ami ou non, E-09) » (line 736), FL-02 lists « F-019 : rangée limitée aux amis » as open (`conception-systeme.md` line 137), and D-082's `impacte` (line 2104) does not name F-019. | — | In the registry Claude Doc, remove F-019's question or turn it into « amis seulement (D-082) », and add F-019 to D-082's `impacte`; drop « rangée limitée aux amis » from FL-02's open list. Then import and promote. |
| 17 | T-04 | Minor | A | D-086, D-119, F-010, P-03 | Unchanged. F-010's question « Vrais médias à la place des formes générées » (`registry.md` line 575) and the inventory's « formes générées en démo ; vrais médias : à confirmer » (`inventaire-des-ecrans.md` line 67) cite neither D-086 nor D-119; the open part lives in F-042's question. | — | In the registry Claude Doc, reword F-010's question « Art généré à partir de la graine de chaque photo (D-086, D-119) : voir F-042 », or remove it; in the inventory, « vrais médias : art généré, D-086 ». Then import and promote. |
| 18 | T-04 | Minor | A | D-086, D-119, E-12, E-04, F-036 | Unchanged. D-086 applies « dans toute l'app ». E-12 still has a plain « images » field (`registry.md` line 1638), F-036 shows story images without reading E-04 (`entites: [E-12, E-09]`, line 945), neither D-086's `impacte` (line 2124) nor D-119's names E-12 or F-036, and FL-06 step 2 reads « E-12 (images, …) » (`conception-systeme.md` line 351). | — | In the registry Claude Doc, write E-12's field as « images (médias E-04 : graine, algorithme choisi par le serveur, D-086, D-119) » and add E-12 and F-036 to D-086's `impacte`. Then import and promote. |

## Questions for the owner

1. **Seeds sent before publication, and their erase (finding 1, class B).**
   - a. Add both to FL-12 as a fifth kind of pending send: the seed (D-120) and the erase of a removed photo's seed (D-121) wait on the phone and go by FL-12's rules (when, order, refusal), are dropped at logout with their draft, and abandoned with the account (D-101). Settle F-044's lost-draft question at the same time (for example: the server erases seeds no post has claimed after a set delay, a background job in FL-12 or its own flow). Recommended: one rule for every send that waits, and the TLA+ sync model already has a slot for « other » kinds.
   - b. Keep them out of FL-12, and say in FL-03 that a seed not yet sent goes with the publication (D-120) and that an erase that fails is left to the server's cleanup of unclaimed seeds; record it in a decision.
2. **A state diagram for media (finding 2, class B).**
   - a. Amend D-107 and add SM-E-04 Média: Graine d'un brouillon → Rattachée à un post, une story, un message ou une photo de profil → effacée (D-121, F-063), with the lost-draft case from question 1. Recommended: the erase rule depends on the state, and question 1's cleanup job will need it.
   - b. Keep E-04 without a diagram, and reword D-107 and `conception-systeme.md` line 737: « E-04 vit aussi en brouillon côté serveur (D-120, D-121), décrit par les lignes Brouillon de SM-E-03 et SM-E-12 ».
3. **Leftover code in the design (finding 3, class C).**
   - a. Remove the story player and the search state (with its colour search) from `Main.dc.html`, and `leaves` and `usageHint` from `Profile.dc.html`. Recommended: nothing reaches them, and their text contradicts F-052, D-074, D-086 and D-087.
   - b. Keep the story player and give the Accueil an entry to it (adds P-03 to F-036 through prompt 9); remove the rest.
   - c. Keep them and record a decision that they are unused design code, like the demo items of D-020.
4. **Wording of the support offer (finding 4, class C).**
   - a. « Une heure passée ici. » everywhere. Recommended: FL-09 and the inventory already quote it.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, and note the difference on F-015.a.

## What was sampled
Mode B, so the query checks covered every ID and link, not a sample: 2 roles, 28 pages, 61 page states, 66 features, 21 variants, 17 entities, 121 decisions, 10 retired IDs, 12 flows; the 8 state diagrams are not in the database (tooling note above) and were read in full. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read: the diff of `claude_docs/`, `claude_design/` and `docs/system-design/` from ebd658d to ba98a99 (D-108 to D-121 and every feature, entity, flow and inventory row they changed); FL-03, FL-12, FL-13 and the whole « États des entités » section in full; the 5 `.tla` and `.cfg` files in full; `.github/workflows/tla-models.yml` and the log of its last run on main.
- L5-02: every step of FL-12 and FL-13, and FL-03 steps 1, 1' and 9, compared with the `entites` and `operations` of their features, by query on `refs` and `features`.
- L6-02 and B6-03: every move of SM-E-12, SM-E-14 and SM-E-16 compared with FL-12, FL-13 and their decisions; every variable and action of the 5 models mapped to an entity field, a move or a FL-12 row.
- T-04 ran on D-108 to D-121: each decision's `impacte` and each document it should change (registry, inventory, flows, state diagrams, models, design).
- Design: L1-03 re-checked by hash against `fake-scrolling-app/.claude-ai.json`; the new artboard read in full. The live canvas on claude.ai was not opened, as the check requires.
- Older findings' evidence was re-checked by grep at the lines quoted; line numbers that moved were updated.
- T-02, T-03 and U-01 to U-03 need later layers.

## Hand-off to the code check
Commit checked: ba98a99. Verdict: ready for the code check, no blocking finding.

There is little for the code checker to verify yet: no feature is at step 10, and there is no code.

| Expectation | From the documents today |
| --- | --- |
| One folder per canonical feature at step 10 or beyond | None: no feature has a spec |
| A test for every rule (`BR`) and criterion (`AC`) | None: no spec, no cross-cutting page |
| A screenshot for every visible criterion per platform | None: no proof block |
| A test for every model-checker failure trace | One trace so far, already settled by D-116 (a support confirmed by the store after the account was deleted on another phone is dropped; `conception-systeme.md` line 996). The 5 models pass in CI; their rules are named after decisions until their `BR` exist (L6-04 not reached) |
| Every table and column of the data model | None: no data model |
| Every event named in a spec | None |
| One flag per feature not fully released | None: no backlog |
| The import rules | None: no code structure or lint config yet |
