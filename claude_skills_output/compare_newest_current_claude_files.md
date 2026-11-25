# Design and docs: newest vs current

Compared on 2026-11-25. Two new decisions: every text a user writes is sent as charabia (D-118), and the server chooses each photo's art algorithm while the phone draws it (D-119). The design is unchanged.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 387 -> 399)
- **D-118 added, "Tout texte écrit part en charabia"**: the phone turns every text a user writes into charabia (made-up words you can pronounce), keeping emojis, before sending it. This covers captions of posts and stories, comments, messages, pseudo and description. Only the @ handle and the app's own text stay readable. A caption stays readable in the draft on the phone and goes out as charabia when it is published.
- **D-119 added, "Art généré : le serveur choisit, le téléphone dessine"**: only the seed leaves the phone. The server chooses each media's algorithm and stores it (E-04), and can reassign it. It sends the phone the seed plus the algorithm as data (building blocks and their settings), and the phone draws the art. A new block needs an app update; a new combination of existing blocks does not.
- **D-086, D-091, D-100**: each ends with "Remplacée en partie par D-119", since the phone no longer sends an algorithm.
- **F-030**: the description now says the comment is sent as charabia (D-118).
- **F-047**: the description now says the caption is sent as charabia when it is published (D-118).
- **F-051**: the open question "Envoi et charabia de la légende côté amis ; photos : art généré (D-086)" is closed by D-118, D-086 and D-119.
- **F-042**: the open question becomes "Art généré (D-086, D-119) : quelles briques au départ, et comment pour une vidéo ?".
- **E-03** `légende`, **E-05** `texte` and **E-12** `texte` are marked "en charabia (D-118)". **E-04** `algorithme` is now "choisi par le serveur et décrit en données (D-086, D-119)".

### Conception système – Fake scrolling (`conception-systeme.md`, rev 84 -> 88)
- **FL-03**: "Hors de ce flow" now names the caption in charabia (D-118) and the photos as generated art (D-086, D-119). F-051's list of open points keeps only the post's palette.
- **FL-07**: F-042's open point becomes "briques de l'art généré au départ, et vidéos (D-086, D-119)".
- **FL-12**: the pending profile photo is now "dont la graine n'est pas enregistrée (D-100, D-119)".

## Unchanged

Design canvas `fake-scrolling-app` (69 files) · `inventaire-des-ecrans.md`
