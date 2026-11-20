# Design and docs: newest vs current

Compared on 2026-11-20. Three new decisions settle the six « à confirmer » items of finding L2-03: D-044 (the real app does what the mockup simulates), D-045 (an abandoned draft is lost) and D-046 (a search result gets the feed's actions, so P-16 must be redrawn).

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 107 -> 115)
- **D-044 « Ce que la maquette simule »** (new): outside the demo, P-04 shows the real pending invitations (E-09); a post sent to a friend (F-019.a) arrives as a message (E-11) in their conversation (E-10, P-09); « Copier le lien » (F-019.b) copies to the phone's clipboard; « Partager ailleurs » (F-019.c) opens the phone's share sheet.
- **D-045 « Brouillon abandonné »** (new): the cross of P-12 (F-005.a) drops the post being drafted, with no confirmation and no save.
- **D-046 « Actions sur un résultat de recherche »** (new): a post opened from search (P-16) gets the like, comment, save and share actions of the feed (F-016, F-017, F-018, F-019); P-16 must be redrawn.
- **F-010.a**: the difference is now « Résultat de recherche : par-dessus la grille, flèche retour vers P-15 ; mêmes actions que sur P-03 (D-046) » (was « aucune action »).
- **F-010, F-016, F-017, F-018, F-019**: now carry `design_a_mettre_a_jour: true` until P-16 is redrawn (D-046).
- **F-019**: new open question « Aspect du post reçu dans la conversation de l'ami (F-019.a, D-044) : non dessiné sur P-09 ».
- **E-11 Message**: new field `post partagé`.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 98 -> 105)
- P-04 « Voir les invitations d'amis », P-07 « Envoyer à un ami », « Copier le lien », « Partager ailleurs »: their « à confirmer » notes are replaced with what D-044 settles.
- P-12 « Fermer la création »: « Brouillon abandonné, sans confirmation ni sauvegarde (D-045) ».
- P-16 « Liker, commenter, enregistrer, partager »: « à ajouter comme sur P-03 (D-046) », still not drawn.

## Unchanged

Design canvas `fake-scrolling-app` (66 files).
