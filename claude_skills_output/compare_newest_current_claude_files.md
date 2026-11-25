# Design and docs: newest vs current

Compared on 2026-11-25. The docs gain flow FL-11 « Gérer son profil et son compte » and the seven decisions it needed (D-098 to D-104). The most important: deleting an account now erases everything it owns, at once and for good (D-101). The design is unchanged.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 326 -> 355)

- **D-098**: the phone turns the pseudo and the description into charabia before sending them, like a message (D-083). E-01 keeps only the charabia, P-19 is pre-filled with it, and the `@` stays in clear. F-056 (description, `etats_ui`) and E-01 (`champs`: « pseudo, en charabia », « description, en charabia ») follow.
- **D-099**: an empty pseudo keeps the old one, without a message; the description can be emptied. F-056 gets the state « pseudo vide : l'ancien est gardé, sans message ; description vidable », and its open question is closed.
- **D-100**: a new profile photo applies at once on the phone, then is resent silently until the server has it, like D-077. F-058 gets that `etats_ui` line.
- **D-101**: « Supprimer définitivement » (F-063) erases everything the account owns, at once and for good: its sessions on every phone, posts, media, stories, comments, likes, collections, notifications, friendships, conversations and messages (they vanish from the friends' P-08 too), timer, usage time and support. Other accounts' counters drop. It is all or nothing (P-21.a). F-063's `entites` grows from E-01, E-02 to E-01 … E-12, E-14, E-15, E-16, and E-03 to E-16 list F-063 in `utilisee_par`. The open question « Effacement réel des données » is closed.
- **D-102**: a deleted account's `@` is freed at once. F-063's description says so.
- **D-103**: E-17 (icon theme, pause carousels) belongs to the phone, never the account. A new phone starts at Noir with carousels on. E-17 gets the field « téléphone, pas le compte (D-103) ». F-002's description says « thème choisi sur ce téléphone ». The account-or-device questions of F-002, F-066 and F-067 are closed.
- **D-104**: on logout (F-071), whatever is waiting to be resent (D-077, D-095, D-100) stays on the phone for that account and goes out at its next login there, never for another account. F-071's description says so.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 139 -> 147)

- P-19: pseudo and description pre-filled « avec le charabia » (D-098); « description vidable » (D-099).
- P-21: « effacement réel : à confirmer » becomes « effacés tout de suite et pour de bon, partout (D-101) ».
- P-23: theme and pause-carousel toggle « gardé sur le téléphone (D-103) ».
- P-03 and P-22: « paiement par le store : à confirmer » becomes « achat unique dans le store, D-092 » (catching up with a decision already taken).

### Conception système – Fake scrolling (`conception-systeme.md`, rev 38 -> 39)

- New section **FL-11 Gérer son profil et son compte**: P-17 → P-19 / P-18 → P-17, P-17 → P-20 → P-23 or P-21 → logout or deletion → P-01. It has 9 steps, 20 decision and error cases, the gaps it settled (D-098 to D-104) and those left open (F-057, F-058, F-062, F-066, F-070).

## Unchanged

Design canvas `fake-scrolling-app` (all 69 files identical).
