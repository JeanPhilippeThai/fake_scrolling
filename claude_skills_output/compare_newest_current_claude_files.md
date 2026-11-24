# Design and docs: newest vs current

Compared on 2026-11-24. Only the docs changed: a new decision D-067 says that P-28's loading and error states follow D-043. The design is the same on claude.ai and in the repo.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 208 -> 211)
- **D-067** added, « États de chargement et d'erreur du panneau Amis proches »: the friends list of P-28 (F-072) follows D-043, as P-24 does: « un anneau centré dans la liste pendant le chargement, puis un message sur place avec « Réessayer » si elle échoue. Pas de nouvel artboard. » `impacte: [F-072, P-28]`.
- **F-072** `etats_ui`: the loading and load-failure states now cite D-067 instead of « comme D-043 ».

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 132 -> 133)
- P-28, row « Choisir un ami proche »: the undrawn states now cite D-067: « (F-072, D-067, non dessinés) ».

## Unchanged

Canvas « Fake scrolling — app » (69 files); « Conception système – Fake scrolling » (rev 14).
