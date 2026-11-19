# Design and docs: newest vs current

Compared on 2026-11-19. The 33 artboards of page states already in the design now have IDs: the registry adds them as page states P-01.a … P-22.b, links them to their features and records the rule in D-040. The screen inventory names each one and gives its artboard. The design itself did not change.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 16 -> 54)

- **D-040 added**, « États de page dessinés à part ». Each of the 33 state artboards (D-025, D-026) is a page state `P-xx.a`, `P-xx.b`…, lettered in canvas order and listed right after its page in `pages`. A state lists only the feature whose state it shows, plus the feature started by a button of its own: P-08.a → F-034, P-12.a → F-069, P-17.a → F-026. The bottom menu and the rest of the screen stay on the page. Success toasts belong to the page that shows them (D-031): P-03.d and P-08.b. The design is not modified. Impacts P-01, P-02, P-03, P-04, P-05, P-08, P-09, P-12, P-13, P-15, P-17, P-18, P-19, P-21, P-22.
- **33 page states added** under `pages`, all `plateforme: mobile`:

  | Page | States (name → feature) |
  | --- | --- |
  | P-01 | P-01.a « Compte tiers : chargement » → F-001 · P-01.b « Compte tiers : erreur » → F-001 · P-01.c « Adresse invalide » → F-003 · P-01.d « Envoi du code » → F-003 · P-01.e « Envoi du code : erreur » → F-003 |
  | P-02 | P-02.a « Code faux » → F-007 · P-02.b « Code expiré » → F-007 |
  | P-03 | P-03.a « Fil : chargement » → F-009 · P-03.b « Fil : erreur de chargement » → F-009 · P-03.c « Paiement échoué » → F-015.a · P-03.d « Post publié » → F-051 |
  | P-04 | P-04.a « Aucune notification » → F-022 |
  | P-05 | P-05.a « Commentaires : chargement » → F-017 · P-05.b « Aucun commentaire » → F-017 · P-05.c « Commentaire non publié » → F-030 |
  | P-08 | P-08.a « Aucune discussion » → F-037, F-034 · P-08.b « Story publiée » → F-051 |
  | P-09 | P-09.a « Conversation : chargement » → F-038 · P-09.b « Aucun message » → F-038 · P-09.c « Message non envoyé » → F-041 |
  | P-12 | P-12.a « Galerie vide » → F-044, F-069 · P-12.b « Accès aux photos refusé » → F-044 |
  | P-13 | P-13.a « Publication en cours » → F-051 · P-13.b « Publication : erreur » → F-051 |
  | P-15 | P-15.a « Recherche : chargement » → F-052 · P-15.b « Aucun résultat » → F-052 |
  | P-17 | P-17.a « Aucun post » → F-062, F-026 |
  | P-18 | P-18.a « Photo : erreur de fichier » → F-058 |
  | P-19 | P-19.a « Profil : enregistrement » → F-056 · P-19.b « Profil : erreur » → F-056 |
  | P-21 | P-21.a « Suppression échouée » → F-063 |
  | P-22 | P-22.a « Paiement échoué » → F-015 · P-22.b « Paiement annulé » → F-015 |

- **22 features and variants get their states in `pages`** (the mirror of the table above; no page removed): F-001, F-003, F-007, F-009, F-015, F-015.a, F-017, F-022, F-026, F-030, F-034, F-037, F-038, F-041, F-044, F-051, F-052, F-056, F-058, F-062, F-063, F-069. For example F-051 goes from `[P-13]` to `[P-13, P-03.d, P-08.b, P-13.a, P-13.b]`.
- No ID removed, no link removed. On the newest docs, `registry_db.py check` passes every reached check except L0-05, which only flags the `newest_claude_docs/` path and clears once promoted.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 54 -> 76)

- **Intro**: now « Le design compte 26 écrans, de P-01 à P-26, plus 33 états de page dessinés à part (D-040). »
- **New paragraph « États de page »**: a separately drawn screen showing a page in a state (chargement, vide, erreur, succès); its ID is its page's plus a letter (P-01.a); each page lists its states under its table, with their artboard (D-040).
- **New « États dessinés à part » table** (État · Nom · Ce qu'il montre · Artboard) under 15 pages: P-01, P-02, P-03, P-04, P-05, P-08, P-09, P-12, P-13, P-15, P-17, P-18, P-19, P-21, P-22. 33 rows, one per state, each naming an existing `Etat-*.dc.html` artboard. The success toasts sit under the page that shows them: P-03.d → `Etat-P13-publication-succes.dc.html`, P-08.b → `Etat-P13-story-succes.dc.html`. Each row quotes the state's copy, for example P-13.b « Le post n’a pas été publié. Tes photos et ta légende sont gardées. » avec « Réessayer ».
- **20 « États visibles » cells** replace « aucun … dessiné » with the state IDs: Continuer avec Google (P-01.a, P-01.b), Saisir son adresse e-mail (P-01.c), Recevoir un code (P-01.d, P-01.e), Se connecter (P-02.a, P-02.b), Passer au post suivant (P-03.a, P-03.b), Soutenir le projet on P-03 (P-03.c), Voir les likes reçus (P-04.a), Lire les commentaires (P-05.a, P-05.b), Publier un commentaire (P-05.c), Lire l'aperçu d'une discussion (P-08.a), Lire les messages (P-09.a, P-09.b), Envoyer un message (P-09.c), Choisir une photo (P-12.a, P-12.b), Partager le post (P-13.a, P-13.b, toasts P-03.d / P-08.b), Parcourir les résultats (P-15.a, P-15.b), Voir ses posts (P-17.a), Choisir dans sa galerie (P-18.a), Enregistrer le profil (P-19.a, P-19.b), Confirmer la suppression (P-21.a), Soutenir le projet on P-22 (P-22.a, P-22.b).
- **Continuer avec Apple**: now « chargement et erreur comme pour Google, non dessinés (D-036) ». **Choisir dans sa galerie** still says the access-refused state is « non dessiné ».

## Unchanged

Design canvas `fake-scrolling-app` (all 41 files identical to the current design, 40 artboards and `canvas.json`).
