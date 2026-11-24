# Design and docs: newest vs current

Compared on 2026-11-24. The search flow FL-08 « Rechercher » is written, and four decisions settle it (D-087 to D-090): the typed text never leaves the phone, only its palette does; the audience of a post decides who can see it; suggestions and trends are gibberish drawn by the app; closing a post creation opened from the search goes back to P-14. The design did not change.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 269 -> 281)
- **D-087** « FL-08 : ce que trouve une recherche »: the phone turns the text into one of the 5 palettes (sum of character codes modulo 5) and sends only the palette. Results are up to 18 posts of that palette that the user can see, newest first. P-15.b « Aucun résultat » shows only when none is left. E-13 stays on the phone.
- **D-088** « FL-08 : qui voit un post »: « Tout le monde » = any signed-in user (R-02); « Amis » = the author's friends; « Amis proches » = the friends ticked in their list (D-060). The author always sees their own posts. Search results (F-052) and the post opened from them (F-054, P-16) show only posts the user can see. F-052 reads E-09.
- **D-089** « FL-08 : suggestions et tendances »: gibberish words the app draws itself; 8 random suggestions each time P-14 opens, no search history; 6 trends ranked by the number of visible posts in their palette, and that number is the one shown. F-053 reads E-03.
- **D-090** « FL-08 : fermer une création ouverte depuis la Recherche »: opened from P-14, P-15 or P-16, post creation closes (F-005.a) on P-14, as the mock does; D-062 holds for the other pages.
- **F-052**: new description (only the palette is sent; up to 18 visible posts); reads E-09; its open access question is closed.
- **F-053**: reads E-03; open question « Origine des suggestions et des tendances » replaced by « Tendances : choix des 6 mots et rythme de leur renouvellement… ».
- **F-054**, **F-010**: their open access questions are closed by D-088.
- **F-050**: open question narrowed to « agir sur un post (liker, commenter, enregistrer, partager) suit-il aussi son audience ? ».
- **E-13**: fields now say what stays on the phone (typed text), what is sent (palette), and how suggestions and trends are made.
- **E-03** `utilisee_par` adds F-053; **E-09** `utilisee_par` adds F-052.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 27 -> 29)
- **FL-08 Rechercher** added: entries (search icon, closing a creation opened from the search), 8 steps P-14 → P-15 → P-16 → P-15 with the entities read, 11 decision points and errors (P-14.b, P-15.b, P-15.c, the end of the results on P-16, failed reactions as P-03.e and P-03.f), what was settled, and the questions still open (F-053, F-050, F-051).

## Unchanged

Design canvas « Fake scrolling — app » (only its sync stamp); inventaire des écrans (rev 137).
