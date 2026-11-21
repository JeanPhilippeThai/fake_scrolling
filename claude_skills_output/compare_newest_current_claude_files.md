# Design and docs: newest vs current

Compared on 2026-11-21. One screen changed: the search result viewer (P-16, in `Search.dc.html`) was redrawn per D-046. A result now opens in a vertical feed of all 18 results, with the same actions as the main feed (like, comment, save, share). The search by colour name was removed, which brings the design in line with F-052. The docs did not change.

## Design

### fake-scrolling-app
- **Recherche, résultat ouvert, P-16 (`Search.dc.html`)**: redrawn as D-046 asked.
  - **Feed of results**: a tile no longer opens a lone post. It opens a full-screen viewer on a dark background (`#1C1C1C`) that moves vertically through the 18 results. You can swipe, with resistance at the first and last post and a snap back if the swipe is too short. The mouse wheel and the keys ↓/PageDown/Space and ↑/PageUp also move it, and Escape closes it. The dialog is labelled « Résultats pour … », and each post is announced as « Résultat n sur 18 ». The back arrow « Retour aux résultats » is unchanged.
  - **Actions column, as on P-03**: avatar, then J’aime (F-016), Commentaires (F-017), Enregistrer dans une collection (F-018) and Partager (F-019), each with its count. A double tap likes the post with a pink heart that pops (`#FF5C7A`), and the pop is turned off under « réduire les animations ».
  - **Caption**: cut at 80 characters with « plus » / « moins ».
  - **Save sheet**: « Enregistrer dans une collection » lists the collections « Pour plus tard », « Formes calmes » and « Couleurs à garder », plus « Nouvelle collection ». Picking one shows the toast « Enregistré dans « … » ». Picking it again shows « Retiré de « … » ».
  - **Share sheet**: « Partager » has the row « Envoyer à » with 8 friends (toast « Envoyé à X. »), then « Copier le lien » (« Lien copié. ») and « Partager ailleurs » (« Partagé. »).
  - **Comments sheet**: « Commentaires » shows 6 comments, each with a heart to like it. The field « Ajouter un commentaire… » takes 150 characters at most, and « Publier » is greyed out while it is empty. Your comment appears as « moi.ici · à l’instant », and 0.9 s later turns into gibberish, keeping its emojis.
- **Recherche (`Search.dc.html`), search by colour removed**: typing a colour word (« rouge », « bleu marine », etc.) no longer gives posts in that colour. Every query now goes to one of the 5 palettes, as F-052 says (« Toute saisie donne 18 posts dans l’une des 5 palettes »). The registry never described the colour search. It came from an earlier drawing on claude.ai, not from the repo's last round.
- **`Search.dc.html`, cleanup only**: a duplicated usage counter and some unused state of the colour timer were removed. The greying by cycle (10 % per cycle) works as before.

## Unchanged

The canvas layout (`canvas.json`), the other 65 design files, Registre canonique – Fake scrolling (`registry.md`, rev 130), Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 106).
