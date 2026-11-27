# Top to bottom check · Fake scrolling · 2026-11-27

Documents: commit 6d380a1 plus the uncommitted changes of `claude_docs/` in the `data-model` worktree (registry rev 480, « Conception système » rev 210, inventory rev 156: the fixes of the last report's findings) · Mode: B (database built from the docs at 6d380a1, fingerprint 95d91ae26934facd, which matches the docs as they are in the working tree, so L0-03 passes)
Method followed: version of 2026-11-26 (method overview revision 96, describe revision 23, reference revision 31, verification revision 12, check instruction revision 58)
Platforms: mobile (iOS and Android share the one mobile design) (per-platform registries: none; `claude_docs/registry.md` is the only registry)

## Verdict
Ready for the code check

## Layers
| Layer | Status | Blocking | Major | Minor |
| --- | --- | --- | --- | --- |
| L0 Method and inputs | passed (L0-03, L0-04, L0-05 by query; L0-01: the inputs of step 8 so far exist: 16 flows (FL-01 to FL-17, FL-10 retired), 9 state diagrams, 6 TLA+ models, NFR-X-1 to NFR-X-17, « Serveur, téléphone et API », « Modèle de données », « Flux de données »; L0-02 unchanged) | 0 | 0 | 0 |
| L1 Design | passed (`claude_design/` unchanged since 6373644, the last check; L1-04 passed by query) | 0 | 0 | 0 |
| L2 Raw extraction | passed (only the P-27 identifier row changed, finding 16 of the last report) | 0 | 0 | 0 |
| L3 Registry | passed (every query passed; L3-11: the new wording of D-144, D-145, D-147 and D-151 read against D-105, D-117, D-129, NFR-X-1, NFR-X-5, P-27 and the data model: no contradiction) | 0 | 0 | 0 |
| L4 Canonical registry (platform merge) | not run: the app has one platform (L4-14 included) | 0 | 0 | 0 |
| L5 Flows | passed (L5-01, L5-06, L5-07 by query; L5-02: FL-13 step 2 now writes E-08, D-148 in its decisions) | 0 | 0 | 0 |
| L6 Entity states and TLA+ | findings (L6-01, L6-03 unchanged; L6-02: SM-E-08 now has D-148's move, SM-E-02 D-149's two moves in its diagram, but not as rows of its table, 1 finding; L6-04 not reached: rules are still named after decisions; L6-05 passed: `docs/system-design/` has not changed since 9e7bd31, whose « TLA+ models » run on `main` succeeded; only the description of `D105_SecondCountedOnce` in the Claude Doc changed) | 0 | 0 | 1 |
| L7 NFRs | findings (L7-01, L7-03, L7-04 passed; NFR-X-1 now lets the place leave readable, test unchanged; L7-02: 1 finding, unchanged) | 0 | 0 | 1 |
| L8 Data model | passed (L8-01, L8-02, L8-04 by query; L8-03 read: TB-33.facon is gone, and TB-33's three columns are an id, a key and an owner, each explained (`conception-systeme.md` lines 1759, 1763); TB-01.identifiant is now `text`, matching D-145's lowercase-only identifier; L8-05, L8-06 unchanged) | 0 | 0 | 0 |
| L9 Data flows and threat model | findings (L9-01 to L9-05 passed by query; L9-01 read: the crash-report service is node N-14; L9-06 passed for the marks: by script, the 78 flows marked `sensible: true` are exactly those that carry an entity of D-151's list, and exactly the 78 of the table « Flux sensibles »; the 6 others carry only E-04 or E-13; the threat-model half is not reached; L9-07 not reached; L9-08: 1 finding, the two dotted edges to N-14; L9-09 passed) | 0 | 0 | 1 |
| L10 Page contracts | not reached | 0 | 0 | 0 |
| L11 Feature specs | not reached | 0 | 0 | 0 |
| L12 Planning and agent documents | not reached (L12-05 and L12-07 unchanged) | 0 | 0 | 0 |
| B12 Planning and agent documents | not reached | 0 | 0 | 0 |
| B11 Feature specs | not reached | 0 | 0 | 0 |
| B10 Page contracts | not reached | 0 | 0 | 0 |
| B9 Data flows and threat model | passed (B9-01 passed; B9-02: N-14 is a third party from D-129; B9-03 by query; B9-04 not reached, no threat model) | 0 | 0 | 0 |
| B8 Data model | passed (B8-01 passed; B8-02: no column kept « for later » now that TB-33.facon is gone; B8-03 by query) | 0 | 0 | 0 |
| B7 NFRs | findings (B7-01 passed; B7-02: 1 finding, unchanged) | 0 | 0 | 1 |
| B6 Entity states and TLA+ | passed (B6-02: the new moves of SM-E-02 and SM-E-08 are triggered by FL-16 and FL-13 or a deletion; B6-03: no model changed) | 0 | 0 | 0 |
| B5 Flows | passed (unchanged) | 0 | 0 | 0 |
| B4 Canonical registry | not run: the app has one platform | 0 | 0 | 0 |
| B3 Per-platform registries | passed (unchanged) | 0 | 0 | 0 |
| B2 Raw extraction | passed (unchanged) | 0 | 0 | 0 |
| B1 Design | findings (unchanged) | 0 | 0 | 1 |
| G Global rules | findings (G-01, G-02 passed by query; G-03 passed with `--since 6d380a1`: no ID disappeared; G-04: 3 findings; G-05: the queries above) | 0 | 0 | 3 |
| T Traces from the top down | findings (T-01, T-02 not reached, no page contract; T-03 passed as far as it goes; T-04: 16 findings) | 0 | 0 | 16 |
| U Traces from the bottom up | passed as far as it goes (U-01 not reached without page contracts; U-02 passed; U-03 passed: the moves of D-148 and D-149 are now in their diagrams) | 0 | 0 | 0 |

Totals: 0 blocking, 0 major, 24 minor.

Registry queries (`registry_db.py check --all --no-fail`): L0-03, L0-04, L0-05, L1-04, L3-01, L3-02, L3-03, L3-04, L3-08, L3-10, L5-01, L5-06, L5-07, L8-01, L8-02, L8-04, L9-01 to L9-05, B9-03, B8-03, G-01 and G-02 passed with no rows; G-03 passed with `--since 6d380a1` (the docs at the last check). Every L4, B4, L10 and B10 query is "not reached" (one platform, no page contract). The CODE checks were left out: they belong to `test-code-conformity`. The project is in step 8: the page contracts (prompts 13 and 14) and the threat model are next.

Tooling notes:
- Unchanged: the database defines neither the state diagrams nor the NFRs, so G-01 and G-02 do not cover `SM-E-xx` and `NFR-X-n`; read instead, each is defined once.
- L8-03 and L9-06 have no query in `checks.sql`; they were read, and the `sensible` marks checked by script (see L9).
- The last report counted « 17 flows »: there are 16 (FL-10 is retired). Nothing else depends on that count.

Since the last check (6d380a1, before these fixes): the last report's findings 1 (SM-E-08 and FL-13, D-148), 4 (the `sensible` marks, the blocking one), 5 (N-14), 6 (TB-33.facon), 13 (D-144's wording), 14 (lowercase identifier, D-145), 15 (FL-03, F-072) and 16 (the inventory, P-27) are fixed. Finding 2 (SM-E-02, D-149) is fixed in the diagram, with a remainder in its table (new finding 1). Finding 9 (D-147 and D-105) is fixed in the nine places it named, with a remainder in F-073 and FL-09 (new finding 9, now Minor: D-147 states « Précise D-105 et D-117 », so precedence settles it). Finding 5's fix brings new finding 3 (the dotted edges). Old findings 3, 7, 8, 10, 11, 12 are now 2, 4, 5, 6, 7, 8; old 17 to 31 are now 10 to 24, every one checked again at its lines (line numbers of `conception-systeme.md` updated).

Leads for the next layers, not findings yet:
- P-29 has no error state (L1-02); the page contract of P-29 (prompt 13, L10-11) is where it will be asked.
- D-144 makes the phone build the id of a notification (TB-14) and of a conversation (TB-17), though both are created by the server as the effect of another gesture. The page contracts and the specs of F-016, F-028 and F-034 will say which gesture carries that id.
- TB-18.post_partage_id points to TB-06.id, and a post is erased with its author's account; F-019's question asks what the message then shows. The foreign key's behaviour on delete follows from that answer.
- The threat model must take the path to N-14 from the graph, since no DF carries it (D-151, « Flux sensibles »).

## Findings
| # | Check | Severity | Class | IDs | Evidence | Caused by | Proposed fix |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1 | L6-02 | Minor | A | SM-E-02, FL-16, D-149 | Remainder of the last report's finding 2. The diagram now has `inscription --> deconnecte : 1 h, FL-16` and `code_expire --> deconnecte : 1 h, FL-16` (`conception-systeme.md` lines 922-923), but the table has no row for either move: FL-16 is only written in the effect column of the rows « Code expiré → Code envoyé \| F-008 » (line 933: « Sans nouveau code, le serveur oublie le code et l'adresse 1 h après l'envoi (FL-16, D-149) ») and « Inscription → Déconnecté \| F-005 » (line 939). | — | In the flows Claude Doc, give each move its own row: « Code expiré → Déconnecté \| 1 h après l'envoi, FL-16 \| Le serveur oublie le code et l'adresse (D-149) » and « Inscription → Déconnecté \| 1 h après son début, FL-16 \| Le serveur oublie l'inscription (D-149) ; ce que voit alors le téléphone est ouvert dans F-070 », and remove those sentences from the F-008 and F-005 rows. Then import and promote. |
| 2 | L7-02 | Minor | A | NFR-X-1 to NFR-X-17 | Unchanged. The app-wide NFRs are a section of the flows Claude Doc: « L'appli n'a pas de page transversale à part : elles vivent ici » (`conception-systeme.md` line 1190), with no decision saying so. The database reads none of them. | — | Move « Exigences non fonctionnelles » to its own Claude Doc (the cross-cutting page), list it in `CLAUDE.md` and `INDEX.md`, and import it; or keep it and have `registry-db` read `NFR-X` rows from `conception-systeme.md`. |
| 3 | L9-08 | Minor | B | N-14, N-06, N-07, D-151, D-129, NFR-X-5 | New, from the fix of the last report's finding 5. The graph draws `N06 -.->\|plantage, sans donnée d'entité\| N14` and the same from N07 (`conception-systeme.md` lines 1854-1855), and the YAML has no flow for them; N-14 is in `noeuds` (line 1908) but no DF reaches it. L9-08: « no node or edge exists only in the picture ». D-151 (`registry.md` line 2522) chose it on purpose: « aucun flux DF ne le cite, mais le graphe montre ce chemin pour le threat model ». | — | See question 1. |
| 4 | B7-02 | Minor | B | NFR-X-10, NFR-X-11, NFR-X-12, NFR-X-13, D-126 | Unchanged. D-126 (`registry.md` line 2372) gives « au plus 2 s », « au plus 0,5 s », « au plus 2 s » and « 60 images par seconde », with no percentile. The NFRs add « au 90e centile … 20 lancements » (NFR-X-10, `conception-systeme.md` line 1217), « au 95e centile » (NFR-X-11 and X-12, lines 1218-1219), « moins de 1 % d'images manquées sur 30 s » (NFR-X-13, line 1220). | — | See question 2. |
| 5 | B1-01 | Minor | C | P-03, P-10, F-036, F-052, D-074, D-086, D-139 | Unchanged (no `.dc.html` changed). `Main.dc.html` still holds a story player (line 319 `<sc-if value="{{storyOn}}"`, line 951 `storyOn: !!storyView`) that nothing on the Accueil opens, and a search state (lines 966-969) with no entry that searches by colour name (line 820), against F-052 and D-139. `Profile.dc.html` computes `usageHint` (line 610) and `leaves` (lines 524-529), never shown, the latter contradicting D-074, D-086 and D-119. | — | See question 3. |
| 6 | G-04 | Minor | C | F-015, F-015.a, P-03, P-03.c, P-22, P-22.a, P-22.b | Unchanged. The Premium post says « Plus d’une heure passée ici. » (`Main.dc.html` line 70, `Etat-P03-premium-echec.dc.html` line 26) where P-22 says « Une heure passée ici. » (`Profile.dc.html` line 250, `Etat-P22-paiement-echec.dc.html` and `Etat-P22-paiement-annule.dc.html` line 40). | — | See question 4. |
| 7 | G-04 | Minor | A | D-137, FL-03, FL-11, FL-12 | Unchanged. D-137 (`registry.md` line 2438: « connexion (FL-01) », « médias (FL-03, FL-14) », « amis et notifications (FL-04) », « minuteur et temps d'utilisation (FL-05, FL-09) ») differs from the table it points to (`conception-systeme.md` lines 1262, 1264, 1265, 1266: « FL-01, FL-11 », « FL-03, FL-12, FL-14 », « FL-03, FL-04 », « FL-05, FL-09, FL-12 »). The table is the detail, so it is probably right. | — | In the registry Claude Doc, drop the flows in brackets from D-137, or copy the table's. Then import and promote. |
| 8 | G-04 | Minor | A | P-13.c, D-040, D-041, D-120 | Unchanged. « plus 60 états de page dessinés à part » (`inventaire-des-ecrans.md` line 6); the design has 61 `Etat-*.dc.html` artboards and the registry 61 page states. | — | In the inventory Claude Doc, write « 61 états de page » (or drop the number). Then import and promote. |
| 9 | T-04 | Minor | A | D-147, D-105, F-073, FL-09 | Remainder of the last report's finding 9. D-147 now « Précise D-105 et D-117 » (`registry.md` line 2498) and names F-073 in `impacte`, and E-14, E-15, F-024, SM-E-14, FL-12 and the TLA+ description carry its exception. Two places still state D-105 alone: F-073 « deux téléphones ouverts en même temps ne comptent qu'une fois (D-105) » (`registry.md` line 1511), and FL-09's table « Le temps ne compte qu'une fois (D-105) » (`conception-systeme.md` line 559). | — | In the registry Claude Doc, end F-073's description « …(D-105), sauf une période arrivée plus de 7 jours après sa fin (D-147) »; in the flows Claude Doc, the same in FL-09 line 559. Then import and promote. |
| 10 | T-04 | Minor | A | D-131, F-007, F-008, P-02 | Unchanged. The inventory still says « vérification réelle : à confirmer, la maquette accepte tout code » (`inventaire-des-ecrans.md` line 49) and « Nouvel envoi du code (à confirmer) » (line 51), settled by D-131. | — | In the inventory Claude Doc, « vérifié par le serveur (D-131) » and « Nouvel envoi du code, qui remplace le précédent (D-131) ». Then import and promote. |
| 11 | T-04 | Minor | A | D-139, D-151, F-053, F-053.a, D-089, NFR-X-1, FL-08, P-15 | Unchanged. Still written with a palette and no note: F-053.a « … 3 bandes de la palette d'arrivée » (`registry.md` line 1242); FL-08 « les tendances comptent les posts visibles de leur palette » (`conception-systeme.md` line 511); the inventory (`inventaire-des-ecrans.md` lines 349, 366, 370, 372). NFR-X-1 cites D-139, and now D-151, in its text but not in its source column (line 1196). | — | In the registry Claude Doc, F-053.a « … et 3 bandes de couleur (ce qu'elles montrent est ouvert dans F-053, D-139) »; in the flows Claude Doc, end line 511 with « ; depuis D-139, ce que compte ce nombre est ouvert dans F-053 », and add D-139 and D-151 to NFR-X-1's sources; in the inventory, note on P-15 « la maquette classe par palette ; l'appli cherche par graine (D-139) ». Then import and promote. |
| 12 | T-04 | Minor | A | D-112, D-095, E-16, SM-E-16 | Unchanged. E-16 « renvoyé à chaque ouverture tant que le serveur ne l'a pas enregistré (D-095) » (`registry.md` line 1692), SM-E-16 « Renvoyé sans message à chaque ouverture jusque-là (D-095) » (`conception-systeme.md` line 1168), and D-112's `impacte` (line 2286) does not name E-16. | — | In the registry Claude Doc, E-16 « … renvoyé par FL-12 tant que le serveur ne l'a pas enregistré (D-095, D-112) » and E-16 in D-112's `impacte`; in the flows Claude Doc, SM-E-16 « Renvoyé sans message par FL-12 jusque-là (D-095, D-112) ». Then import and promote. |
| 13 | T-04 | Minor | A | D-119, D-125, E-04, FL-07, FL-11, F-042, F-058 | Unchanged. D-119 (`registry.md` line 2326): « seule la graine quitte le téléphone. Le serveur choisit l'algorithme ». FL-07 step 7 and FL-11 step 4 still write « E-04 (graine et algorithme, D-086) » from the phone (`conception-systeme.md` lines 416, 598), without D-125's erasure of the old seed; FL-11's decisions name neither D-122 nor D-125. | — | In the flows Claude Doc, both cells « E-04 (graine ; algorithme choisi par le serveur, D-086, D-119) », « ; graine de l'ancienne photo effacée (D-125) » in FL-11's, and D-122, D-125 in its decisions. Then import and promote. |
| 14 | T-04 | Minor | A | D-089, F-053, P-14 | Unchanged. « origine des suggestions : à confirmer » (`inventaire-des-ecrans.md` line 348), settled by D-089. | — | In the inventory Claude Doc, « tirées au hasard par l'app à chaque ouverture (D-089) ». Then import and promote. |
| 15 | T-04 | Minor | A | D-040, P-03.b, P-03.c | Unchanged. D-040 (`registry.md` line 1903) says « lettré dans l'ordre du canvas », but `canvas.json` puts « Paiement échoué » (x=-470) before « Fil : erreur de chargement » (x=1880) on row y=2364, while the registry has P-03.b « Fil : erreur de chargement » and P-03.c « Paiement échoué ». | — | Reword D-040 in the registry Claude Doc: « lettrés dans l'ordre du canvas, sauf P-03.b et P-03.c, groupés par feature », or drop the order clause. Then import and promote. |
| 16 | T-04 | Minor | A | D-042, F-028, F-028.a, P-04.d, P-04.e | Unchanged. F-028 `etats_ui` says only « réponse en cours : anneau dans « Accepter », les deux boutons désactivés » (`registry.md` line 864), and the inventory's « Refuser une invitation » row lists « La ligne disparaît » alone (`inventaire-des-ecrans.md` line 115), while D-042 (line 1911) gives both buttons the ring and the error. | — | In the registry Claude Doc, add to F-028 `etats_ui` « mêmes états pour Refuser (F-028.a), par analogie (D-042) », and the same note in the inventory. Then import and promote. |
| 17 | T-04 | Minor | A | F-010, F-010.a, D-046, D-049 | Unchanged. F-010's merge note « P-16 sans actions en variante » (`registry.md` line 2545), while F-010.a « se comporte comme un post du fil, avec les mêmes actions (D-046, D-049) » (line 570). | — | In the registry Claude Doc, end the F-010 row with « ; actions ajoutées par D-046 et D-049 ». Then import and promote. |
| 18 | T-04 | Minor | A | D-056, D-066, P-04.a | Unchanged. D-056 (`registry.md` line 1983) still gives P-04.a's old text, and D-066 (line 2033) sets another without naming D-056. | — | In the registry Claude Doc, add to D-066's `choix` « ; remplace le texte de D-056 ». Then import and promote. |
| 19 | T-04 | Minor | A | D-056, D-061, F-022, P-04 | Unchanged. « Voir le post liké \| Miniature carrée à droite de chaque like » (`inventaire-des-ecrans.md` line 117), and F-022's question « Ouvrir le post liké depuis sa miniature » (`registry.md` line 783), though every notification has a thumbnail. | — | « Voir le post concerné \| Miniature carrée à droite de chaque notification » in the inventory, « Ouvrir le post concerné depuis sa miniature » in F-022. Then import and promote. |
| 20 | T-04 | Minor | A | D-024, D-054, F-019 | Unchanged. F-019's `questions_ouvertes` still holds « Un lien de post ouvert sans connexion mène à la connexion (P-01) » (`registry.md` line 736), settled by D-024 and D-054. | — | Remove that line from F-019's questions in the registry Claude Doc. Then import and promote. |
| 21 | T-04 | Minor | A | D-138, D-088, F-050, FL-03, FL-08 | Unchanged. FL-03 « F-050 : règle de l'audience (qui voit le post et agit dessus). » (`conception-systeme.md` line 216) and FL-08 « F-050 : agir sur un post suit-il aussi son audience ? » (line 517) are still listed as open, settled by D-088 and D-138 (`registry.md` line 2442). | — | In the flows Claude Doc, end both lines « ; réglé depuis : qui le voit (D-088), agir dessus (D-138) ». Then import and promote. |
| 22 | T-04 | Minor | A | D-082, F-019, F-019.a, E-10 | Unchanged. F-019 still asks « Envoyer à un ami (F-019.a) : amis seulement (ami ou non, E-09) » (`registry.md` line 735), FL-02 lists « F-019 : rangée limitée aux amis » as open (`conception-systeme.md` line 137), and D-082's `impacte` (line 2115) does not name F-019. | — | Remove F-019's question or turn it into « amis seulement (D-082) », add F-019 to D-082's `impacte`, drop « rangée limitée aux amis » from FL-02's list. Then import and promote. |
| 23 | T-04 | Minor | A | D-086, D-119, F-010, P-03 | Unchanged. F-010's question « Vrais médias à la place des formes générées » (`registry.md` line 577) and the inventory's « vrais médias : à confirmer » (`inventaire-des-ecrans.md` line 67) cite neither D-086 nor D-119. | — | Reword F-010's question « Art généré à partir de la graine de chaque photo (D-086, D-119) : voir F-042 », or remove it; in the inventory, « vrais médias : art généré, D-086 ». Then import and promote. |
| 24 | T-04 | Minor | A | D-086, D-119, E-12, E-04, F-036, FL-06, FL-13, SM-E-04 | Unchanged. E-12 still has a plain « images » field (`registry.md` line 1649), F-036 reads `[E-12, E-09]` without E-04 (line 943), D-086's `impacte` (line 2135) names neither E-12 nor F-036, FL-06 step 2 reads « E-12 (images, …) » (`conception-systeme.md` line 356), and FL-13 step 2 « avec ses images » (line 721), while the data model keeps them as E-04 in TB-07.story_id (line 1743). | — | In the registry Claude Doc, E-12 « images (médias E-04 : graine, algorithme choisi par le serveur, D-086, D-119) », and E-12, F-036 in D-086's `impacte`; in the flows Claude Doc, FL-13 step 2 « … avec ses médias (E-04) et sa liste « vue par » ». Then import and promote. |

## Questions for the owner

1. **The edges to the crash-report service (finding 3, class B).**
   - a. Keep the dotted edges as they are: D-151 already records that no DF reaches N-14 and why. Recommended: a flow with no entity does not fit the DF format, and the threat model gets the path from the graph and « Flux sensibles ».
   - b. Add one DF from each app to N-14, with no entity and `sensible: true`, so the graph again holds only flows of the YAML.
2. **Numbers the speed NFRs add to D-126 (finding 4, class B).**
   - a. Record them in D-126 or a new decision. Recommended: « au plus » cannot be tested as an absolute.
   - b. One percentile for all four, recorded.
   - c. Keep D-126 absolute and drop the percentiles from the NFRs.
3. **Leftover code in the design (finding 5, class C).**
   - a. Remove the story player and the search state from `Main.dc.html`, `leaves` and `usageHint` from `Profile.dc.html`. Recommended.
   - b. Keep the story player with an entry on the Accueil (prompt 9 adds P-03 to F-036); remove the rest.
   - c. Keep them, with a decision that they are unused design code.
4. **Wording of the support offer (finding 6, class C).**
   - a. « Une heure passée ici. » everywhere. Recommended: FL-09 and the inventory quote it.
   - b. « Plus d’une heure passée ici. » everywhere.
   - c. Keep both on purpose, noted on F-015.a.

## What was sampled
Mode B: the queries covered every ID and link (2 roles, 29 pages, 61 page states, 67 features, 21 variants, 17 entities, 151 decisions, 16 flows, 33 tables, 14 nodes, 84 data flows); the 9 state diagrams and the 17 NFRs are read. `newest_claude_design/` and `newest_claude_docs/` were ignored.

- Read in full: the diff of `claude_docs/` from 6d380a1 to the working tree, and around each change: SM-E-02, SM-E-08, SM-E-14, FL-12, FL-13, FL-09, FL-16, NFR-X-1, NFR-X-5, TB-01, TB-33, « Flux de données », D-129, D-144, D-145, D-147, D-151, E-01, E-14, E-15, F-024, F-070, F-073.
- L9-06 and L9-08 by a script over the YAML: every `sensible` mark against D-151's entity list and the ranges of « Flux sensibles » (78 and 78, no difference); every DF against the edges of the mermaid graph.
- Every place that states D-105's « une seule fois », by search, for D-147's exception; every mention of capitals in the identifier, for D-145.
- Every finding of the last report was checked again at its lines.
- Design: unchanged since the last check; the live canvas was not opened.
- L6-05: `docs/system-design/` unchanged since the last green run; nothing was run.
- T-01, T-02 and U-01 need page contracts.

## Hand-off to the code check
Commit checked: 6d380a1 with the uncommitted `claude_docs/` changes of the `data-model` worktree. Verdict: ready for the code check; no document holds an open Blocking finding.

There is little for the code checker to verify yet: no feature is at step 10, and there is no code.

| Expectation | From the documents today |
| --- | --- |
| One folder per canonical feature at step 10 or beyond | None: no feature has a spec |
| One route per page that holds such a feature | None yet; the registry has 29 pages |
| A test identifier for every component of such a feature | None: no page contract |
| A contract file for every data flow between an app and the server | None yet: no feature at step 10. 44 such flows exist, DF-10 to DF-53 (10 API groups and the WebSocket, each way, for iOS and Android) |
| A job folder for every background flow that is built | Five server jobs: FL-13 to FL-17; one phone job: FL-12 |
| A test for every rule (`BR`) and criterion (`AC`) | None: no spec. NFR-X-1 to NFR-X-17 each name a test, for when the code exists |
| A screenshot for every visible criterion per platform | None: no proof block. The `app` command is Maestro (D-143) |
| A test for every model-checker failure trace | One trace, settled by D-116. The 6 models pass in CI |
| A hidden test for every rule and criterion, and the guards against gamed tests | None: no `BR` or `AC` yet |
| Every table and column of the data model | 33 tables: TB-01 to TB-26 and TB-33 in PostgreSQL (N-01), TB-27 to TB-31 in SQLite (N-02), TB-32 in the secure storage (N-03), with the rules of D-144 |
| Every event named in a spec | None |
| One flag per feature not fully released | None: no backlog |
| The import rules | None yet. The stack is React Native with Expo and a Fastify server, in TypeScript (D-132, D-133) |
