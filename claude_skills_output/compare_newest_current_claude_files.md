# Design and docs: newest vs current

Compared on 2026-11-20. The registry gains two decisions (D-041: draw the loading, error and failure states of 16 more features; D-042: how a one-tap action fails) and 25 page states, P-03.e to P-17.c. The inventory lists them under their pages. The design on claude.ai is the one the repo just published: no difference.

## Design

### fake-scrolling-app
- No change: the 66 files on claude.ai are the repo's, published just before this import (the 25 new state artboards and `canvas.json`).

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 55 -> 101)
- **D-041 « États encore non dessinés »**: the missing states of 16 features are drawn as for D-025 and D-026. Lists get loading and error: F-017, F-022, F-036, F-037, F-038, F-043, F-052, F-053, F-062. Actions get failure: F-016, F-018, F-019.a, F-028, F-031, F-034, F-042. The 25 artboards are page states (D-040). Drawn and matched to the registry in the same pass (prompt 9), so these features carry no `design_a_mettre_a_jour`.
- **D-042 « Échec d'une action en un tap »**: like (F-016) and save (F-018) change at once. If the server fails, they go back and a message says so at the bottom of the feed for 2 s. Accepting or refusing an invitation (F-028), adding a friend (F-034) and creating a collection (F-031) show the ring in the button (D-028), then the error in place with « Réessayer » (D-027). Sending a post to a friend (F-019.a) or a photo (F-042) follows D-027: « Non envoyé » with « Réessayer ».
- **25 page states added**, each listing the one feature whose state it shows:
  - P-03.e Like non enregistré (F-016)
  - P-03.f Enregistrement : échec (F-018)
  - P-04.b Notifications : chargement (F-022)
  - P-04.c Notifications : erreur (F-022)
  - P-04.d Invitation : réponse en cours (F-028)
  - P-04.e Invitation : erreur (F-028)
  - P-05.d Commentaires : erreur (F-017)
  - P-06.a Nouvelle collection : création (F-031)
  - P-06.b Nouvelle collection : erreur (F-031)
  - P-07.a Envoi à un ami : échec (F-019.a)
  - P-08.c Discussions : chargement (F-037)
  - P-08.d Discussions : erreur (F-037)
  - P-09.d Conversation : erreur (F-038)
  - P-09.e Photo non envoyée (F-042)
  - P-10.a Story : chargement (F-036)
  - P-10.b Story : erreur (F-036)
  - P-11.a Recherche de comptes : chargement (F-043)
  - P-11.b Recherche de comptes : erreur (F-043)
  - P-11.c Demande d’ami : envoi (F-034)
  - P-11.d Demande d’ami : erreur (F-034)
  - P-14.a Suggestions : chargement (F-053)
  - P-14.b Suggestions : erreur (F-053)
  - P-15.c Recherche : erreur (F-052)
  - P-17.b Mes posts : chargement (F-062)
  - P-17.c Mes posts : erreur (F-062)
- **17 features changed** (F-016, F-017, F-018, F-019, F-019.a, F-022, F-028, F-031, F-034, F-036, F-037, F-038, F-042, F-043, F-052, F-053, F-062): each lists its new states in `pages`, and its `etats_ui` gains the copy shown. Examples:
  - F-017: « erreur : « Les commentaires n’ont pas pu être chargés. » avec « Réessayer » »
  - F-034: « envoi : anneau dans « Ajouter », désactivé » and « erreur : « La demande n’a pas été envoyée. » avec « Réessayer » ; le bouton redevient « Ajouter » »
  - F-053 had no `etats_ui`. It now has loading and error.
- No ID removed (G-03: 0).

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 76 -> 94)
- Intro: « plus 58 états de page dessinés à part (D-040, D-041) » (was 33).
- The « États dessinés à part » tables of P-03, P-04, P-05, P-08, P-09, P-15 and P-17 gain their new rows.
- P-06, P-07, P-10, P-11 and P-14 get that table for the first time.
- The « États visibles » column of the elements concerned cites the new IDs, e.g. « Liker ou retirer son like »: « … ; échec : redevient vide (P-03.e) ».
