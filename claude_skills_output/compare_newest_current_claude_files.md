# Design and docs: newest vs current

Compared on 2026-11-25. New decision D-120: a photo's seed leaves the phone as soon as the photo is chosen, and publishing ends with a fade from the real photo and caption to the generated art and the charabia (new state P-13.c, drawn in the repo and published to claude.ai).

## Design

### fake-scrolling-app
- **P-13 · F-051 · Transformation avant publication (`Etat-P13-transformation.dc.html`)**: new artboard. It shows the publish screen with the 72 px thumbnail and the caption crossfading in a 4.5 s loop: the real photo (a sunset) and « Fin de journée au bord de l’eau 🌅 » become the generated art and « Vrol tusé mizapo ka bri dulon 🌅 ». The button keeps the spinner and « Publication… », and the rest of the page is dimmed. With reduced motion, only the final state shows.
- `canvas.json`: the artboard is placed at x 1880 on the P-13 row and ordered after « Publication en cours ».

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 399 -> 407)
- **D-120 added**: the seed is sent and the art prepared in the background as soon as a photo is chosen or taken. P-13.a stays until the post is saved and the art is ready, then P-13.c fades to the art and charabia, then the success toast appears (D-031). On failure there is no fade. This applies to posts and stories.
- **P-13.c added** (« Transformation avant publication », F-051).
- **F-044, F-046**: the seed leaves the phone right away. F-044 gets a new open question: what the server does with seeds of a deselected photo or an abandoned draft.
- **F-051**: the description, the `P-13.c` page and the « transformation » UI state are added; « envoi » now waits for the art.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 88 -> 100)
- **FL-03**: the intro, steps 1, 1' and 9, the « Suite simple » line, and the success and failure rows now cite D-120 and P-13.c.
- **SM-E-03, SM-E-12**: the draft sends only seeds early, and publishing shows P-13.c before the toast.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 147 -> 151)
- **P-12** « Choisir une photo »: the seed is sent on choice.
- **P-13** « Partager le post »: data is now the charabia caption and art (no longer « à confirmer »); the states add the fade, and the error has no fade.
- **P-13.c** row added to « États dessinés à part ».
