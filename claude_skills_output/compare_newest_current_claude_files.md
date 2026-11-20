# Design and docs: newest vs current

Compared on 2026-11-20. New decision D-043 gives the friends list of P-24, the place search of P-25 and the row of friends of P-07 a loading and an error state by analogy (D-027, D-028), and it puts the failed like of a comment at the bottom of the P-05 panel. No artboard was added.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 101 -> 107)
- **D-043 added**, « États de chargement et d'erreur par analogie »: P-24 (F-048), P-25 (F-049) and the P-07 row (F-019.a) show « un anneau centré dans la liste pendant le chargement, puis un message sur place avec « Réessayer » si elle échoue ». When liking a comment fails (F-016.b), « le petit cœur redevient gris et « Le like n’a pas été enregistré. » s'affiche pendant 2 s en bas du panneau des commentaires (P-05), au-dessus du champ « Ajouter un commentaire… » ». « Pas de nouvel artboard. »
- **D-042**: its `choix` now says where the message goes on P-05: « (en bas du panneau des commentaires pour le like d'un commentaire, D-043) ».
- **F-016** `etats_ui`: adds the failure of F-016.b.
- **F-019** `etats_ui`: adds the loading and the error of the row of friends (F-019.a).
- **F-048**, **F-049** `etats_ui`: each adds a loading state (centred ring) and an error state (message in place with « Réessayer »), citing D-043.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 94 -> 98)
- The « États visibles » column gets the same states, each marked « D-043, non dessiné(s) »: « Liker un commentaire » (P-05), « Envoyer à un ami » (P-07), « Identifier un ami » (P-24), « Choisir un lieu » (P-25).

## Unchanged

Design canvas « Fake scrolling — app » (`fake-scrolling-app`): no file changed.
