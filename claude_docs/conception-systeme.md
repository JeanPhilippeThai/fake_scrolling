<!-- Source: https://claude.ai/artifact/V35ZLk13bPhs4byZvSoaXg, tab "Tab 1", rev 4, exported 2026-11-24 -->
# Conception système – Fake scrolling

Nov 24, 2026 · @Jp

Les flows de l'appli (prompt 5 de la méthode), un par section, écrits uniquement avec les IDs du [Registre canonique – Fake scrolling](https://claude.ai/artifact/A5qaJU9xAkPWfJ6JUNfWHV). Les choix qu'ils ont demandés sont dans les `decisions` du registre.

## FL-01 Se connecter

Une personne non connectée (R-01) arrive sur P-01 et en ressort connectée (R-02) sur P-03, par un compte tiers ou par un code reçu par e-mail. Mobile seulement. Décisions : D-024, D-052, D-053, D-054.

### Entrées

- Ouverture de l'appli sans session sur l'appareil → P-01. Avec une session ouverte, l'appli s'ouvre sur P-03 sans passer par ce flow (D-053).
- Lien de post ouvert sans connexion → P-01 ; le post attend la fin du flow (D-024, D-054).
- Déconnexion F-071 sur P-21, ou suppression du compte F-063 → P-01 (D-053).

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Accueil de la connexion | P-01 | F-002, F-004 | E-17 (thème de l'icône) | — |
| 2a. Compte tiers | P-01 → P-01.a | F-001 (Google) ou F-001.a (Apple) | E-02 (fournisseur), E-01 (compte existant ?) | E-02 (fournisseur, session) |
| 2b. Demande du code | P-01 → P-01.d | F-003 | — | E-02 (adresse e-mail, code à 6 chiffres, délai avant renvoi) |
| 3b. Saisie du code | P-02 | F-006, F-007 | E-02 (adresse, code), E-01 (compte existant ?) | E-02 (session) |
| 3b'. Renvoi du code | P-02 | F-008 | E-02 (délai avant renvoi) | E-02 (nouveau code) |
| 4. Inscription, si aucun compte | P-27 | F-070 | E-02 (fournisseur ou adresse) | E-01 (pseudo, identifiant), E-02 (session) |
| 5. Arrivée sur le fil | P-03.a → P-03 | F-009 | E-03 (posts ; d'abord le post du lien, D-054) | — |

Suite simple : P-01 → F-001 / F-001.a → (P-27 → F-070) → P-03, ou P-01 → F-003 → P-02 → F-007 → (P-27 → F-070) → P-03. Les entités suivent les `operations` des features : F-003, F-008 écrivent E-02 ; F-006 la lit ; F-001, F-007, F-070 lisent et écrivent. À partir de P-03, le grisage F-024 s'applique ; P-01, P-02 et P-27 ne sont jamais grisées (D-009, D-019, D-052).

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-01 | Compte tiers ou e-mail | F-001 / F-001.a, ou F-003 |
| P-01.a | Le fournisseur échoue | P-01.b : réessayer F-001 / F-001.a, ou passer à F-003 |
| P-01.a | Annulation sur l'écran du fournisseur | Retour à P-01, à confirmer avec cet écran (question ouverte de F-001) |
| P-01 | Adresse invalide | P-01.c : bouton désactivé, on reste sur P-01 |
| P-01.d | L'envoi du code échoue | P-01.e : « Réessayer » relance P-01.d |
| P-02 | Mauvaise adresse | F-005 : retour à P-01 |
| P-02 | Code faux | P-02.a : corriger les cases, puis F-007 |
| P-02 | Code expiré | P-02.b : F-008 « Renvoyer un code », puis P-02 |
| P-02 | Code pas reçu | F-008 après le décompte de 30 s |
| F-001, F-007 | Compte trouvé (lecture E-01) | P-03 |
| F-001, F-007 | Aucun compte | P-27, F-070 (D-052) |
| P-27 | Abandon | F-005 : retour à P-01, sans compte créé |
| P-27 | Identifiant pris, erreur d'enregistrement | Non dessinés (questions ouvertes de F-070) |
| P-03.a | Le fil ne charge pas | P-03.b : « Réessayer » (F-009) |
| P-03 | Post du lien expiré, supprimé ou hors audience | Non défini (question ouverte de F-009) |

Fin du flow : P-03, en R-02, session ouverte (D-053).

### Manques du registre

Ajoutés le 24 novembre 2026 :

- P-27 Inscription et F-070 Créer son compte : aucun écran ne faisait choisir le pseudo et l'identifiant d'un nouveau compte (D-052). À dessiner.
- F-071 Se déconnecter sur P-21, et la session dans E-02 : la seule sortie était la suppression du compte (D-053). À dessiner.
- La suite d'un lien de post après la connexion (D-054).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-001 : l'écran d'autorisation du fournisseur et son annulation.
- F-007 : durée de validité du code et nombre d'essais faux avant blocage.
- F-070 : règles de l'identifiant ; photo et description à l'inscription ou plus tard ; états de chargement et d'erreur.
- F-071 : confirmation avant la déconnexion.
- F-009 : post du lien devenu invisible.

## FL-02 Parcourir le fil et réagir à un post

Un utilisateur connecté (R-02) fait défiler le fil de P-03 et réagit à un post : like, commentaires sur P-05, enregistrement sur P-06, partage sur P-07. Chaque panneau se ferme sur P-03 (F-027). Mobile seulement. Décisions : D-030, D-043, D-049, D-050, D-051, D-055, D-056, D-057, D-058.

### Entrées

- Arrivée sur P-03, à la fin de FL-01 ou depuis le menu (F-025).
- Un résultat de recherche ouvert sur P-16 offre les mêmes réactions et les mêmes panneaux (D-049, D-050) ; le retour vers P-15 passe par F-010.a.

Hors de ce flow : le post Premium (F-015.a), les notifications reçues (F-022), le grisage (F-024), la création de post (F-026).

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Faire défiler | P-03.a → P-03 | F-009 | E-03 | — |
| 2. Regarder un post | P-03 | F-010, F-011, F-012, F-012.a, F-014, F-020, F-021 | E-03, E-04 ; E-17 pour F-012.a (carrousels de pause activés ?) | — |
| 3. Liker ou retirer le like | P-03 | F-016, F-016.a | E-03 | E-06 (like), E-03 (nombre de likes), E-08 (notification à l'auteur, D-055) ; le retrait supprime E-06 et E-08 |
| 4. Ouvrir les commentaires | P-03 → P-05.a → P-05 | F-017 | E-05, E-03 | — |
| 4'. Liker un commentaire | P-05 | F-016.b | E-05 | E-06 (cible : commentaire), E-05 (nombre de likes) ; pas de notification (D-055) |
| 4''. Publier un commentaire | P-05 | F-030 | — | E-05, E-03 (nombre de commentaires), E-08 (notification « commentaire » à l'auteur du post, D-056) |
| 5. Enregistrer | P-03 → P-06 | F-018 | E-07 (collections, celle du post) | E-07 (posts enregistrés), E-03 (nombre d'enregistrements) ; retirer = suppression (D-057) |
| 5'. Nouvelle collection | P-06 → P-06.a | F-031 | — | E-07 (« Collection N », avec le post) |
| 6. Partager | P-03 → P-07 | F-019 | E-03 | — |
| 6a. Envoyer à un ami | P-07 | F-019.a | E-10 (rangée de contacts) | E-11 (message avec le post partagé), E-10 (dernier message), E-03 (nombre de partages, D-058) |
| 6b. Copier le lien | P-07 | F-019.b | E-03 (lien) | E-03 (nombre de partages, D-058) |
| 6c. Partager ailleurs | P-07 | F-019.c | E-03 | E-03 (nombre de partages, D-058) |
| 7. Fermer le panneau | P-05, P-06, P-07 → P-03 | F-027 | — | — |

Suite simple : P-03 → F-009 → F-016 / F-016.a, ou P-03 → F-017 → P-05 → F-030 / F-016.b → F-027 → P-03, ou P-03 → F-018 → P-06 → P-03, ou P-03 → F-019 → P-07 → P-03. Les entités suivent les `operations` des features : F-009, F-010, F-011, F-012, F-014, F-017, F-020, F-021 lisent ; F-030, F-031 écrivent ; F-016 et F-018 lisent, écrivent et suppriment ; F-019 lit et écrit.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-03.a | Les posts suivants ne chargent pas | P-03.b : « Réessayer » (F-009, D-032) |
| P-03 | Like non enregistré | P-03.e : le cœur redevient vide, message 2 s, on reste sur P-03 |
| P-03 | Double tap sur un post déjà liké | F-016.a ne retire jamais le like |
| P-05.a | Les commentaires ne chargent pas | P-05.d : « Réessayer » (F-017) |
| P-05 | Aucun commentaire | P-05.b : « Écris le premier. », F-030 |
| P-05 | Champ vide | Bouton « Publier » gris (F-030) |
| P-05 | Commentaire non publié | P-05.c : « Non publié. » avec « Réessayer » (D-030) |
| P-05 | Like de commentaire non enregistré | Petit cœur redevenu gris, message 2 s en bas du panneau (D-043) |
| P-03 | Signet vide ou plein | Les deux ouvrent P-06 ; plein : la collection du post est encadrée (D-057) |
| P-06 | Tap sur la collection encadrée | Post retiré, « Retiré de … », retour à P-03 (D-057) |
| P-06 | Tap sur une autre collection | Post déplacé, « Enregistré dans … », retour à P-03 (D-057) |
| P-06.a | La collection n'est pas créée | P-06.b : « Réessayer » (F-031) |
| P-03 | Enregistrement échoué | P-03.f : signet redevenu vide, message 2 s |
| P-07 | Rangée d'amis en chargement ou en échec | Anneau, puis message sur place avec « Réessayer » (D-043) |
| P-07 | Envoi à un ami échoué | P-07.a : ami cerclé de rouge, « Non envoyé à … », « Réessayer », le panneau reste ouvert |
| P-07 | Partage réussi | Message 2 s sur P-03 ou P-16 : « Envoyé à … », « Lien copié. » ou « Partagé. » (D-051) |
| P-05, P-06, P-07 | Croix, « OK » ou tap sur le fond | F-027 : retour à P-03 |

Fin du flow : retour au fil, P-03 (ou P-16), avec les compteurs du post à jour.

### Manques du registre

Réglés le 24 novembre 2026 :

- Aucune feature n'écrivait les notifications de like : F-016 écrit E-08 (D-055).
- Un commentaire notifie l'auteur du post : E-08 a un type « commentaire », F-030 l'écrit, P-04 est à redessiner (F-022, D-056).
- Le signet plein et le nombre de collections par post (F-018, D-057).
- Les partages qui comptent (F-019, D-058).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-016, F-017, F-018, F-019, F-020, F-030 : accès supposé à tout post qu'on peut voir, selon son audience (F-050).
- F-019 : rangée limitée aux amis ; partage d'un post « Amis proches » ; aspect du post reçu sur P-09.
- F-031 : saisie du nom de la collection.
- F-011 : pause et déplacement dans la vidéo.
