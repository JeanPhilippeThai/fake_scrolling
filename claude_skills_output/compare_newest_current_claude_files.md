# Design and docs: newest vs current

Compared on 2026-11-27. The docs now describe the four redrawn features: a new account starts with only « Favoris », the place is typed freely, a chat shows a sent post as a card (or a grey box when it is gone) that opens a new full-screen page P-30, and an expired sign-up has its own state P-27.c with « Me reconnecter ». The design is the one the repo published, unchanged.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 521 -> 542)
- New page P-30 « Messages — post ouvert » and new feature F-075 « Ouvrir un post reçu » (pages P-09, P-30): a tap on a post card in a chat opens the post alone, full screen; the arrow returns to the chat (D-163).
- New page state P-27.c « Inscription expirée »: « Ton inscription a expiré. Reconnecte-toi pour la finir. » and a green button « Me reconnecter » that opens P-01 (D-164).
- New decisions: D-162 (a post sent to a friend shows in the chat as a card: round photo, pseudo and @ of its author, then the blurred photo), D-163 (P-30, and like, comments, save and share work there as on P-16), D-164 (the « Me reconnecter » button).
- F-005, F-010, F-016, F-017, F-018, F-019, F-020, F-024, F-073 list P-30 in their pages; P-09 lists F-075.
- F-018, F-019, F-049, F-070: `design_a_mettre_a_jour` cleared (prompt 9: the design now matches).
- F-019: open question on how a received post looks is closed by D-162.
- F-038: reads E-03 too; new UI states for the post card and for « Ce post n’est plus disponible. » (D-153).
- F-049: UI states lose « Aucun lieu trouvé. » and the search's loading and error; they gain the « Lieu » field of 60 characters at most, « OK » keeping what was typed (D-157).
- F-070: new UI state for P-27.c (D-154, D-164).

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 156 -> 162)
- 30 screens (P-01 to P-30) and 61 drawn states.
- P-06: one collection at the start, « Favoris » (D-161).
- P-09: new row « Voir un post reçu » with the grey box case.
- P-25: the place list, its search and « Aucun lieu trouvé. » are gone; a « Lieu » field of 60 characters at most (D-157).
- P-27: state P-27.c added.
- New section P-30.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 237 -> 239)
- « Contrats de pages » now covers P-01 to P-30.

## Unchanged

Design canvas « Fake scrolling — app »: 72 files, the same as the repo.

## Second import (registre rev 542 -> 549, conception système rev 239 -> 249)

- E-01, E-03, E-04 and E-11 list F-075 in `utilisee_par`, and E-03 lists F-038 (check L3-04).
- P-30 no longer lists F-010: F-075 covers the opened post there; F-010 is back to P-03 and P-16.
- FL-07 gains step 5 « Ouvrir un post reçu » (P-09 → P-30 → P-09), and its open question on F-019 now asks only whether a sent post marks the chat unread.
- DF-35 and DF-37 carry E-03 and F-075; DF-84 lists F-075 (checks L5-07, L9-05).
