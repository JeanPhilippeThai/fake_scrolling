# Design and docs: newest vs current

Compared on 2026-11-27. The three Major findings of the design and docs check are fixed in the docs: the themed logo of P-29 now belongs to F-002, search (F-052, FL-08) names the media seeds it reads (E-04), and D-135 and NFR-X-3 no longer speak of a search history. The design was not imported: nothing changed on its side, and `claude_design/` stays as it is.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 455 -> 463)
- F-002 « Afficher l'icône de l'appli »: `pages` gains P-29, and P-29's `features` gains F-002. The logo of « Mise à jour requise » follows the icon theme, as on P-01 (owner's confirmation, D-103, D-142). The merge note of F-002 names P-29.
- D-142: `impacte` gains F-002.
- F-052 « Rechercher des posts »: `entites` gains E-04; E-04's `utilisee_par` gains F-052; D-139's `impacte` gains E-04. Search compares against the seed of each post's media, as D-139 already said.
- D-135: « l'historique de recherche (E-13) » becomes « l'état de la recherche (E-13, sans historique, D-089) ». The phone keeps no search history (owner's confirmation of D-089).

### Conception système – Fake scrolling (`conception-systeme.md`, rev 167 -> 171)
- FL-08, steps 2, 2' and 3: E-04 added to the entities read (« graine des médias de chaque post, D-139 »).
- NFR-X-3: « l'historique de recherche (E-13) » becomes « l'état de la recherche (E-13, sans historique, D-089) ».

## Unchanged

Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 155).
