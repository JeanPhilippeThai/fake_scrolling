# Design and docs: newest vs current

Compared on 2026-11-25. Feed posts no longer expire (D-097): the « jours restants » field, copy and questions are gone from the docs, and F-062 waits for P-17 and P-17.a to be redrawn without them. The design is unchanged.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 318 -> 325)
- New decision **D-097** « Durée de vie d'un post du fil »: a feed post (E-03) never expires; it stays in the feed, the search and the profile as long as its author's account exists (F-063). No expiry flow. Stories keep their 24 h (D-079).
- **E-03** Post: field « jours restants avant expiration » removed.
- **F-062** Voir ses posts: description is now « Grille de 9 posts floutés. »; the empty state's text is « Tes posts s’affichent ici. » (D-097); new open question « Combien de posts montre la grille, maintenant qu’ils n’expirent plus (D-097) : tous, avec défilement et chargement par lots ? »; `design_a_mettre_a_jour: true` (P-17 still draws « 7 j » badges and the old empty-state text).
- **F-051**: open question narrowed to « Palette du post (E-03) : qui la fixe à la publication ? Le post n’expire pas (D-097) ».
- **F-009**: open question no longer mentions an expired post: « Post du lien partagé supprimé ou hors de son audience après la connexion (D-054) ».

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 137 -> 139)
- P-17 « Voir ses posts »: « 9 posts floutés, sans jours restants : un post n’expire pas (D-097) ».
- P-17.a: text « Tes posts s’affichent ici. » (D-051, D-097).

### Conception système – Fake scrolling (`conception-systeme.md`, rev 34 -> 38)
- FL-01: the error row reads « Post du lien supprimé ou hors audience ».
- FL-03 and FL-08: the open points on F-051 keep only the palette; they cite D-097 for the lifetime.

## Unchanged

Design canvas « Fake scrolling — app » (69 files).

## Second pass, same day

Claude redrew P-17 in the repo (`Profile.dc.html`: no « X j » badges, tiles labelled « Post flouté »; `Etat-P17-posts-vide.dc.html`: « Tes posts s’affichent ici. »), published it to the canvas, and prompt 9 cleared `design_a_mettre_a_jour` on F-062 (registry rev 325 -> 326).
