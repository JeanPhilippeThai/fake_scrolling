# Design and docs: newest vs current

Compared on 2026-11-25. New decision D-121: the server deletes a seed right away when its photo is removed from the selection or the draft is closed. The design is unchanged.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 407 -> 409)
- **D-121 added, « Graines d'une photo qui ne sera pas publiée »**: removing a chosen photo (F-044) or closing the draft with « Fermer » (F-005.a) makes the server delete the seeds already sent (D-120) and their algorithm (E-04) at once. A seed not yet sent is never sent.
- **F-044**: the seed question is closed. A narrower one replaces it: a draft lost without « Fermer » (app force-closed, phone turned off), and when the server deletes its seeds.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 100 -> 103)
- **FL-03**: D-121 is cited in the intro and on the « Fermer » row. **SM-E-03**: the abandoned draft has its seeds deleted.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 151 -> 152)
- **P-12** « Choisir une photo »: a second tap removes the photo and the server deletes its seed.

## Unchanged

Design canvas `fake-scrolling-app`
