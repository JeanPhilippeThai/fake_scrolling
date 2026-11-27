<!-- Source: https://claude.ai/artifact/V35ZLk13bPhs4byZvSoaXg, tab "Tab 1", rev 249, exported 2026-11-27 -->
# Conception système – Fake scrolling

Nov 24, 2026 · @Jp

Les flows de l'appli (prompt 5 de la méthode), un par section, écrits uniquement avec les IDs du [Registre canonique – Fake scrolling](https://claude.ai/artifact/A5qaJU9xAkPWfJ6JUNfWHV). Les choix qu'ils ont demandés sont dans les `decisions` du registre.

## FL-01 Se connecter

Une personne non connectée (R-01) arrive sur P-01 et en ressort connectée (R-02) sur P-03, par un compte tiers ou par un code reçu par e-mail. Mobile seulement. Décisions : D-024, D-052, D-053, D-054, D-069, D-114, D-127, D-131, D-141.

### Entrées

- Ouverture de l'appli sans session sur l'appareil → P-01. Avec une session ouverte, l'appli s'ouvre sur P-03 sans passer par ce flow (D-053). Si la version de l'appli est trop vieille pour le serveur, P-29 s'ouvre à la place de toute page, avec ou sans session, jusqu'à la mise à jour (F-074, D-141).
- Lien de post ouvert sans connexion → P-01 ; le post attend la fin du flow (D-024, D-054).
- Déconnexion F-071 sur P-21, ou suppression du compte F-063 → P-01 (D-053) ; après la suppression, « Compte supprimé » reste 2 s avant P-01 (D-069).

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Accueil de la connexion | P-01 | F-002, F-004 | E-17 (thème de l'icône) | — |
| 2a. Compte tiers | P-01 → P-01.a | F-001 (Google) ou F-001.a (Apple) | E-02 (fournisseur), E-01 (compte existant ?) | E-02 (fournisseur, session) |
| 2b. Demande du code | P-01 → P-01.d | F-003 | — | E-02 (adresse e-mail, code à 6 chiffres, heure d'envoi, délai avant renvoi) |
| 3b. Saisie du code | P-02 | F-006, F-007 | E-02 (adresse, code), E-01 (compte existant ?) | E-02 (essais faux, D-127 ; session) |
| 3b'. Renvoi du code | P-02 | F-008 | E-02 (délai avant renvoi) | E-02 (nouveau code, heure d'envoi, essais faux remis à 0 ; l'ancien code ne marche plus, D-131) |
| 4. Inscription, si aucun compte | P-27 | F-070 | E-02 (fournisseur ou adresse) | E-01 (pseudo, identifiant), E-02 (session), E-14, E-15 et E-16 (valeurs de départ, D-114) |
| 5. Arrivée sur le fil | P-03.a → P-03 | F-009 | E-03 (posts ; d'abord le post du lien, D-054) | — |

Suite simple : P-01 → F-001 / F-001.a → (P-27 → F-070) → P-03, ou P-01 → F-003 → P-02 → F-007 → (P-27 → F-070) → P-03. Les entités suivent les `operations` des features : F-003 écrit E-02 ; F-006 la lit ; F-001, F-007, F-008, F-070 lisent et écrivent. À partir de P-03, le grisage F-024 s'applique ; P-01, P-02 et P-27 ne sont jamais grisées (D-009, D-019, D-052).

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
| P-02 | Code expiré : 10 min écoulées, ou 5e code faux, même si le suivant est juste (D-127) | P-02.b : F-008 « Renvoyer un code », puis P-02 ; seul ce nouveau code marche (D-131) |
| P-02 | Code pas reçu | F-008 après le décompte de 30 s |
| F-001, F-007 | Compte trouvé (lecture E-01) | P-03 |
| F-001, F-007 | Aucun compte | P-27, F-070 (D-052) |
| P-27 | Abandon | F-005 : retour à P-01, sans compte créé |
| P-27 | Identifiant pris, erreur d'enregistrement | Erreur : P-27.b, « Réessayer », saisies gardées (D-064) ; identifiant pris : question ouverte de F-070 |
| P-03.a | Le fil ne charge pas | P-03.b : « Réessayer » (F-009) |
| P-03 | Post du lien supprimé ou hors audience | Non défini (question ouverte de F-009) |

Fin du flow : P-03, en R-02, session ouverte (D-053).

### Manques du registre

Ajoutés le 24 novembre 2026 :

- P-27 Inscription et F-070 Créer son compte : aucun écran ne faisait choisir le pseudo et l'identifiant d'un nouveau compte (D-052). Dessinés depuis, avec P-27.a et P-27.b (D-063, D-064).
- F-071 Se déconnecter sur P-21, et la session dans E-02 : la seule sortie était la suppression du compte (D-053). Dessiné depuis, sans confirmation (D-065).
- La suite d'un lien de post après la connexion (D-054).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-001 : l'écran d'autorisation du fournisseur et son annulation.
- F-007 : réglé depuis, le code vaut 10 min et 5 essais faux (D-127), seul le dernier envoyé marche (D-131).
- F-070 : règles de l'identifiant (photo et description viennent plus tard, D-063 ; états dessinés, D-064).
- F-071 : réglé depuis, pas de confirmation (D-065).
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
- Un commentaire notifie l'auteur du post : E-08 a un type « commentaire », F-030 l'écrit, P-04 redessiné depuis (F-022, D-056).
- Le signet plein et le nombre de collections par post (F-018, D-057).
- Les partages qui comptent (F-019, D-058).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-016, F-017, F-018, F-019, F-020, F-030 : accès supposé à tout post qu'on peut voir, selon son audience (F-050) ; réglé depuis : agir sur un post suit son audience (D-138).
- F-019 : rangée limitée aux amis ; partage d'un post « Amis proches » ; aspect du post reçu sur P-09.
- F-031 : saisie du nom de la collection.
- F-011 : pause et déplacement dans la vidéo.

## FL-03 Publier un post

Un utilisateur connecté (R-02) choisit des photos sur P-12, écrit la légende et règle ses options sur P-13, puis publie dans le fil (P-03) ou en story (P-08). Avant la publication, seule la graine de chaque photo part au serveur, pour préparer l'art généré ; le reste n'est enregistré qu'à la publication (D-045, D-120). Mobile seulement. Décisions : D-001, D-012, D-031, D-033, D-034, D-035, D-045, D-047, D-059, D-060, D-061, D-062, D-068, D-120, D-121, D-122, D-123.

### Entrées

- Bouton + du menu (F-026) sur P-03, P-08, P-14, P-15, P-16 ou P-17 → P-12, destination « Fil d'actualité ».
- « Créer un post » de l'état vide P-17.a (F-026, D-035) → P-12.
- Rond « Ta story » de P-08 (F-026.a, D-001) → P-12, destination « Story » présélectionnée (F-068).

Hors de ce flow : la légende du post publié, en charabia (D-118) et ses photos en art généré (D-086, D-119) ; un post n’expire jamais (D-097) ; le grisage F-024, qui s'applique à toutes ces pages.

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Choisir les photos | P-12 | F-044, F-045 | E-04 (galerie, album) | E-04 (graine, envoyée au serveur dès le choix, D-120 ; sans réseau, en attente dans FL-12, D-122), E-03 ou E-12 (brouillon : photos choisies, rang dans le carrousel, D-068) |
| 1'. Prendre une photo | P-12 ou P-12.a | F-046, F-046.a | — | E-04 (graine, envoyée au serveur, D-120 ; sans réseau, en attente dans FL-12, D-122), E-03 ou E-12 (brouillon : la photo prise devient celle du post ou de la story, D-047, D-068) |
| 2. Passer à la légende | P-12 → P-13 | F-044 (« Suivant ») | — | — |
| 3. Écrire la légende | P-13 | F-047 | — | E-03 ou E-12 (brouillon : légende, D-068) |
| 4. Choisir où publier | P-13 | F-068 | — | E-03 ou E-12 (destination) |
| 5. Identifier des personnes | P-13 → P-24 | F-048 | E-09 (amis) | E-03 ou E-12 (personnes identifiées, D-059) |
| 6. Ajouter un lieu | P-13 → P-25 | F-049 | — (aucune entité pour les lieux) | E-03 ou E-12 (lieu, D-059) ; « Retirer le lieu » le supprime |
| 7. Choisir l'audience | P-13 → P-26 | F-050 | — | E-03 ou E-12 (audience, D-059) |
| 7'. Modifier la liste d'amis proches | P-26 → P-28 | F-072 | E-09 (amis) | E-09 (ami proche, D-060) |
| 8. Fermer un panneau | P-24, P-25, P-26 → P-13 ; P-28 → P-26 | F-027 | — | — |
| 9. Publier | P-13 → P-13.a → P-13.c | F-051 | E-03 ou E-12 (brouillon), E-04 | E-03 et E-04 (post), ou E-12 (story) ; E-08 (une notification « identification » par personne identifiée, D-061) |
| 10. Arrivée | P-03.d ou P-08.b | F-051 | E-03 ou E-12 | — |

Suite simple : P-03 → F-026 → P-12 → F-044 → P-13 → F-047 → (P-24 F-048, P-25 F-049, P-26 F-050 → P-28 F-072) → F-051 → P-03, ou P-08 → F-026.a → P-12 → … → F-068 « Story » → F-051 → P-08. Les entités suivent les `operations` des features : F-045 lit ; F-046, F-047, F-050, F-068 écrivent ; F-044, F-048, F-051, F-072 lisent et écrivent ; F-049 lit, écrit et supprime. Avant F-051, ces écritures ne touchent que le brouillon sur l'appareil, sauf la graine de chaque photo, envoyée dès le choix (D-120), ou par FL-12 dès que le réseau revient (D-122).

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-12 | Galerie vide | P-12.a : « Ouvrir l'appareil photo » (F-046.a, D-033, D-047) |
| P-12 | Accès aux photos refusé | P-12.b : « Ouvrir les réglages » du téléphone (F-044, D-034) |
| P-12 | Prise de vue refusée ou annulée | Non dessinée (questions ouvertes de F-046) |
| P-12 | Sélection simple ou multiple | Une photo, ou jusqu'à 10 numérotées (F-044) |
| P-12 | « Suivant » | Toujours actif : une photo au moins est choisie |
| P-12 | Croix « Fermer » (F-005.a) | Brouillon abandonné sans confirmation (D-045), ses graines effacées du serveur, par FL-12 sans réseau, et celles qui attendaient encore jamais envoyées (D-121, D-122), retour à la page d'origine (D-062) ; ouverte depuis la Recherche (P-14 à P-16), retour sur P-14 (D-090) |
| P-12 | Photo retirée de la sélection (F-044) | Sa graine effacée du serveur, par FL-12 sans réseau ; jamais envoyée si elle attendait encore (D-121, D-122) |
| P-12, P-13 | Brouillon perdu sans « Fermer » (appli fermée de force, téléphone éteint) | Ses graines en attente ne partent jamais (D-122) ; celles déjà envoyées sont effacées par FL-14, 24 h après leur arrivée (D-123) |
| P-13 | Flèche retour (F-005) | P-12, photos choisies gardées |
| P-13 | Fil d'actualité ou Story (F-068) | Bouton « Partager dans le fil » ou « Partager en story » |
| P-24, P-25 | Liste en chargement ou en échec | Anneau, puis message sur place avec « Réessayer » (D-043) |
| P-24, P-25 | Aucun résultat | « Aucun ami trouvé. » ou « Aucun lieu trouvé. » |
| P-25 | Un lieu est déjà choisi | « Retirer le lieu » (F-049) |
| P-26 | « Amis proches » avec une liste vide | Non défini (question ouverte de F-072) |
| P-28 | Liste en chargement ou en échec | Anneau, puis message sur place avec « Réessayer » (F-072) |
| P-13.a | Graines encore en attente, ou déjà effacées par FL-14 | Elles partent avec la publication (D-120, D-122, D-123) |
| P-13.a | La publication échoue | P-13.b : pas de fondu, photos et légende gardées (D-120), « Réessayer » relance F-051 (D-027) |
| P-13.a | Publié dans le fil | Fondu vers l'art généré et le charabia (P-13.c, D-120), puis P-03 avec le toast « Post publié. » (P-03.d, D-031) |
| P-13.a | Publié en story | Fondu vers l'art généré et le charabia (P-13.c, D-120), puis P-08 avec le toast « Story publiée. » (P-08.b, D-031) |

Fin du flow : P-03 avec le post publié, ou P-08 avec la story publiée ; les personnes identifiées en sont notifiées sur P-04 (D-061).

### Manques du registre

Réglés le 24 novembre 2026 :

- Une story n'avait ni audience, ni personnes identifiées, ni lieu : E-12 les prend, F-048, F-049 et F-050 l'écrivent (D-059).
- Aucune liste d'« Amis proches » : E-09 prend « ami proche », F-072 la règle sur le nouveau panneau P-28, ouvert depuis P-26 (D-060). P-26 et P-28 dessinés depuis.
- Une identification ne notifiait personne : E-08 a un type « identification », F-051 l'écrit (D-061). P-04 redessiné depuis (F-022).
- La croix de P-12 ramenait toujours à l'Accueil : elle ramène à la page d'origine (D-062). Design mis à jour depuis (F-005).

Réglés le 25 novembre 2026 : sans réseau, les graines et leurs effacements attendent dans FL-12 (D-122) ; les graines d'un brouillon perdu sont effacées 24 h après leur arrivée par FL-14 (D-123), et la question ouverte de F-044 est close.

Restent ouverts, dans les `questions_ouvertes` des features :

- F-044, F-045 : vraie galerie, autorisation d'accès, liste des albums.
- F-046 : écran de prise de vue, autorisation de l'appareil photo.
- F-047 : limite de longueur de la légende.
- F-048 : liste de démo ; seuls des amis peuvent être identifiés.
- F-049 : réglé par D-157, le lieu est tapé librement, 60 caractères au plus.
- F-050 : règle de l'audience (qui voit le post et agit dessus).
- F-051 : réglé depuis, un post n’a plus de palette (D-139).
- F-072 : liste vide ; l'effet d'un changement sur les posts déjà publiés est réglé : la liste du moment vaut pour tout (D-146).

## FL-04 Ajouter un ami

Un utilisateur connecté (R-02) cherche un compte par son @ sur P-11 et lui envoie une demande ; l'autre utilisateur (R-02) l'accepte ou la refuse sur P-04. Une fois acceptée, les deux ont une conversation vide dans P-08. Mobile seulement. Décisions : D-006, D-035, D-042, D-044, D-048, D-070, D-071, D-072, D-073, D-106.

### Entrées

- Bouton + de P-08 (F-034) → P-11.
- « Ajouter un ami » de l'état vide P-08.a (F-034, D-035) → P-11.
- Pour le destinataire : la cloche de P-03 (F-022) → P-04, section « Invitations » (D-044).

Hors de ce flow : écrire au nouvel ami (F-041, flow des messages) ; les listes d'amis de F-019.a, F-048 et F-072 ; le grisage F-024, qui s'applique à P-04, P-08 et P-11.

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Ouvrir l'ajout d'un ami | P-08 ou P-08.a → P-11 | F-034 (bouton +, « Ajouter un ami ») | — | — |
| 2. Chercher un compte | P-11 → P-11.a → P-11 | F-043 | E-01 (pseudo, identifiant, photo), E-09 (statut de chaque compte) | — |
| 3. Envoyer la demande | P-11 → P-11.c → P-11 | F-034 | E-09 | E-09 (« demandé » chez l'expéditeur, « en attente » chez le destinataire), E-08 (notification « invitation » au destinataire, D-070) |
| 3'. Ajouter un compte qui nous a déjà invité | P-11 → P-11.c → P-11 | F-034 | E-09 (« en attente ») | E-09 (« ami »), E-10 (conversation vide), E-08 (invitation supprimée) (D-073) |
| 4. Voir l'invitation (destinataire) | P-03 → P-04.b → P-04 | F-022 | E-08 (pastille), E-09 (invitations en attente) | E-08 (toutes vues, la pastille disparaît, D-106) |
| 5a. Accepter | P-04 → P-04.d → P-04 | F-028 | — | E-09 (« ami » des deux côtés), E-10 (conversation vide, D-071), E-08 (invitation supprimée, D-070) |
| 5b. Refuser | P-04 | F-028.a | — | E-09 (demande supprimée, D-048), E-08 (invitation supprimée, D-070) |
| 6. Fermer le panneau | P-04 → P-03 | F-027.a | — | — |

Suite simple : P-08 → F-034 → P-11 → F-043 → F-034, puis chez le destinataire P-03 → F-022 → P-04 → F-028 (ou F-028.a) → F-027.a → P-03. Les entités suivent les `operations` des features : F-043 lit ; F-022 lit et marque les notifications vues (D-106) ; F-028 écrit et supprime ; F-034 lit, écrit et supprime.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-11 | Champ vide | Rien n'est affiché (F-043) |
| P-11.a | La recherche échoue | P-11.b : « Réessayer » (F-043) |
| P-11 | Aucun compte | « Aucun compte trouvé. » |
| P-11 | Compte déjà ami | « Ami » gris et désactivé |
| P-11 | Demande déjà envoyée | « Demandé » gris et désactivé ; pas d'annulation (question ouverte de F-034) |
| P-11 | Le compte nous a déjà invité | « Ajouter » accepte son invitation et devient « Ami » (D-073) |
| P-11.c | L'envoi échoue | P-11.d : « La demande n’a pas été envoyée. » avec « Réessayer » ; le bouton redevient « Ajouter » (D-042) |
| P-04.b | Les notifications ne chargent pas | P-04.c : « Réessayer » (F-022) |
| P-04 | Aucune invitation | Section « Invitations » masquée ; P-04.a si rien d'autre |
| P-04.d | La réponse échoue | P-04.e : « Ta réponse n’a pas été envoyée. » avec « Réessayer » (D-042) |
| P-04 | Refus | La ligne disparaît ; l'expéditeur revoit « Ajouter » et peut redemander (D-048) |
| F-028 | Acceptation | Pas de notification à l'expéditeur (D-072) : il voit la conversation dans P-08 et « Ami » dans P-11 |

Fin du flow : les deux comptes sont amis (E-09 « ami »), avec une conversation vide dans P-08 qui s'ouvre sur P-09.b.

### Manques du registre

Réglés le 24 novembre 2026 :

- Aucune feature n'écrivait la notification « invitation » : F-034 l'écrit, F-028 la supprime (D-070).
- Aucune conversation ne s'ouvrait avec un nouvel ami : l'acceptation en crée une vide (D-071).
- L'acceptation ne notifie pas l'expéditeur (D-072).
- Une demande vers un compte qui nous a déjà invité accepte son invitation (D-073).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-034 : annuler une demande envoyée ; retirer un ami ou bloquer un compte.
- F-043 : vrai annuaire ; comptes privés ou bloqués ; son propre compte dans les résultats.
- F-022, F-028 : accès supposé aux seules invitations reçues et en attente.
- F-037 : peut-on écrire à un non-ami ? Réglé depuis par FL-07 : amis seulement (D-082).

## FL-05 Griser l'app par cycles

Tâche de fond, sans geste de l'utilisateur : tant qu'un utilisateur connecté (R-02) a l'appli ouverte, le minuteur de couleur de son compte (E-14) avance, et chaque cycle terminé retire 10 % de couleur à toutes les pages de F-024. Après 10 cycles, l'appli reste en noir et blanc jusqu'à « Réinitialiser » (F-061). Mobile seulement. Décisions : D-009, D-019, D-052, D-074, D-075, D-076, D-077, D-105, D-117.

### Entrées

- Fin de FL-01 : la connexion ouvre P-03 et le minuteur du compte reprend où il en était (D-074).
- Ouverture de l'appli avec une session ouverte (D-053), ou retour de l'appli au premier plan.
- Sur P-17 : changer la durée du cycle (F-060) ou réinitialiser (F-061).

Hors de ce flow : P-01, P-02 et P-27, jamais grisées (D-009, D-019, D-052) ; le temps d'utilisation (E-15) et le post Premium (F-015, F-065), dans FL-09.

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Reprendre le minuteur | Appli ouverte ou revenue au premier plan, connecté | Pages de F-024 | F-024 | E-14 (durée, cycles écoulés, temps passé dans le cycle) | — |
| 2. Avancer | Chaque seconde, appli au premier plan | Pages de F-024 | F-024 | E-14 | E-14 (temps passé dans le cycle en cours, D-075) |
| 3. Finir un cycle | Le temps passé atteint la durée | Pages de F-024 | F-024 | E-14 | E-14 (cycles écoulés + 1, 10 % de gris en plus, temps remis à 0) |
| 4. Noir et blanc | 10 cycles écoulés | Pages de F-024 | F-024 | E-14 | — (le minuteur s'arrête) |
| 5. Suivre le minuteur | L'utilisateur ouvre P-17 | P-17 | F-059 | E-14 (cycle sur 10, % de gris, temps restant) | — |
| 6. Changer la durée | Flèche haut ou bas | P-17 | F-060 | — | E-14 (durée ; cycles gardés, D-076) |
| 7. Réinitialiser | Bouton « Réinitialiser » | P-17 | F-061 | — | E-14 (cycle 1, 0 % de gris) |
| 8. S'arrêter | Appli fermée ou en arrière-plan, déconnexion (F-071) | — | F-024 | — | E-14 (temps passé gardé sur le serveur, D-074) |

Suite simple : ouverture → F-024 (1 → 2 → 3, dix fois) → noir et blanc, et sur P-17 : F-059, F-060, F-061 → retour aux couleurs. Les entités suivent les `operations` des features : F-059 lit ; F-060 et F-061 écrivent ; F-024 lit et écrit (D-075).

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| Pages de F-024 | Appli au premier plan | Le minuteur avance (D-075), même sans réseau : le téléphone grise de lui-même et ses secondes repartent par FL-12 (D-117) |
| Toutes | Appli fermée ou en arrière-plan | Le minuteur s'arrête, rien ne grise (D-075) |
| P-01, P-02, P-27 | Pas encore connecté, ou inscription | Jamais grisées (D-009, D-019, D-052) |
| FL-01 | Reconnexion, ou autre téléphone | Le minuteur du compte reprend au même gris (D-074) |
| Pages de F-024 | 10 cycles écoulés | Noir et blanc sans message ; sur P-17, F-059 dit « Noir et blanc. Réinitialise pour retrouver les couleurs. » |
| P-17 | Flèche à 1 ou 30 min | Flèche grisée (F-060) |
| P-17 | Nouvelle durée en cours de cycle | Cycles gardés, la durée vaut pour la suite (D-076) |
| P-17 | Le serveur n'enregistre pas la durée ou la réinitialisation | Appliquée sur le téléphone, renvoyée sans message (D-077, FL-12) |
| P-17 | Réinitialiser | Cycle 1, couleurs revenues sur toutes les pages (F-061) |

Fin du flow : aucune ; le minuteur s'arrête quand l'appli se ferme et reprend à l'ouverture.

### Manques du registre

Réglés le 24 novembre 2026 :

- Le minuteur appartient au compte, pas au téléphone (D-074) : les questions ouvertes de F-059, F-060 et F-061 sont closes.
- Seul le temps passé appli ouverte fait griser (D-075) : E-14 garde ce temps au lieu du début du cycle, et F-024 l'écrit.
- Changer la durée garde les cycles écoulés (D-076).
- Un réglage non enregistré est renvoyé sans message (D-077).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-024 : deux téléphones ouverts en même temps sur le même compte ; réglé depuis par D-105 (le temps ne compte qu'une fois).
- F-065 : temps d'utilisation (E-15) compté par compte ou par appareil ; réglé depuis par D-093 (FL-09).

## FL-06 Voir une story

Un utilisateur connecté (R-02) touche le cercle d'un ami dans P-08 ou P-09 et regarde ses stories en cours dans P-10, image par image ; à la fermeture, elles comptent comme vues pour lui seul. Mobile seulement. Décisions : D-059, D-060, D-078, D-079, D-080, D-081.

### Entrées

- P-08, rangée de stories : rond cerclé d'un ami (F-036) → P-10.
- P-08, liste des discussions : photo cerclée d'une discussion (F-036) → P-10.
- P-09 : photo cerclée du contact en haut (F-036) → P-10.

Hors de ce flow : publier une story (FL-03, F-026.a, F-051) ; voir sa propre story (question ouverte de F-036) ; ouvrir une discussion (F-037) ; le grisage F-024, qui s'applique aussi à P-10 (FL-05).

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Voir qui a une story | P-08, P-09 | F-036 (cercles vert ou gris) | E-12 (auteur, fin, audience, vue par), E-09 (ami, ami proche) | — |
| 2. Ouvrir les stories d'un ami | P-08 ou P-09 → P-10.a → P-10 | F-036 | E-12 (images, texte, ancienneté, auteur) | — |
| 3. Regarder | P-10 | F-036 (5 s par image, barres de progression) | E-12 | — |
| 4. Image suivante ou précédente | P-10 | F-036 (tap sur les deux tiers droits ou le tiers gauche) | E-12 | — |
| 5. Story suivante du même ami | P-10 | F-036 (D-081) | E-12 | — |
| 6. Fermer | P-10 → P-08 ou P-09 | F-036 (croix, ou fin après la dernière image) | — | E-12 (vue par : le compte qui regarde, D-078) |

Suite simple : P-08 (ou P-09) → F-036 → P-10.a → P-10 → F-036 (images, puis stories suivantes) → fermeture → P-08 (ou P-09), cercle gris. Les entités suivent les `operations` de F-036 : il lit E-12 et E-09, et écrit « vue par » dans E-12.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-08, P-09 | L'ami n'a aucune story en cours | Pas de rond dans la rangée ; photo sans cercle dans la liste et en haut de P-09 |
| P-08, P-09 | Story « Amis proches » et je ne suis pas dans la liste de l'auteur | Elle ne m'est pas montrée (D-080) |
| P-08, P-09 | Toutes les stories de l'ami sont vues | Cercle gris ; elles se rouvrent quand même |
| P-10.a | Le chargement échoue | P-10.b : « La story n’a pas pu être chargée. » avec « Réessayer » ; fermer sans image montrée laisse la story non vue (D-078) |
| P-10 | La story a atteint ses 24 h pendant qu'on est sur P-08 | P-10.b ; son cercle disparaît au chargement suivant (D-079) |
| P-10 | Tap à gauche sur la première image | Reste sur la première image |
| P-10 | Fin d'une story, l'ami en a une autre en cours | La suivante commence, ses barres repartent (D-081) |
| P-10 | Fin de la dernière image de la dernière story | Le lecteur se ferme et revient à la page d'où il a été ouvert |
| P-10 | Le serveur n'enregistre pas « vue » | Cercle gris sur le téléphone, renvoyé sans message (D-078, FL-12) |

Fin du flow : retour sur P-08 ou P-09 ; le cercle de l'ami est gris s'il n'a plus de story non vue.

### Manques du registre

Réglés le 24 novembre 2026 :

- « Vue » était un seul champ de la story : E-12 garde les comptes qui l'ont vue, écrits à la fermeture (D-078).
- Aucune story ne finissait : elle dure 24 h après la publication (D-079).
- Accès : amis seulement, « Amis proches » filtre (D-080) ; F-036 lit E-09.
- Plusieurs stories d'un même ami s'enchaînent sous un seul cercle (D-081).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-036 : voir sa propre story et qui l'a vue ; ordre des ronds de la rangée de P-08.
- F-072 : un changement de la liste d'amis proches vaut-il pour les stories déjà publiées ?

## FL-07 Discuter avec un ami

Un utilisateur connecté (R-02) ouvre Messages, choisit la conversation d'un ami dans P-08 et échange avec lui dans P-09 : messages en charabia, photos en art généré, réponses citées. Les messages de l'ami arrivent en direct. Mobile seulement. Décisions : D-027, D-030, D-042, D-044, D-071, D-082, D-083, D-084, D-085, D-086, D-153, D-162, D-163.

### Entrées

- Icône bulle du menu du bas (F-025) → P-08.
- Fin de FL-04 : la conversation vide avec le nouvel ami apparaît dans P-08 (D-071).
- Un post envoyé à un ami (F-019.a, FL-02) arrive en message dans sa conversation (D-044).

Hors de ce flow : ajouter un ami (FL-04, F-034) ; voir une story depuis P-08 ou P-09 (FL-06, F-036) ; publier une story depuis « Ta story » (FL-03) ; le grisage F-024, qui s'applique à P-08 et P-09 (FL-05).

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Ouvrir Messages | P-03 → P-08.c → P-08 | F-025, F-037 | E-10 (contact, dernier message, heure, lu / non lu) | — |
| 2. Chercher une discussion | P-08 | F-033 | E-10 (prénom, @) | — |
| 3. Ouvrir une conversation | P-08 → P-09.a → P-09 | F-037, F-038 | E-10, E-11 | E-10 (lu, D-085) |
| 4. Lire et recevoir | P-09 | F-038 | E-11 (messages en direct, saisie de l'ami, D-084) | E-10 (reste lu, D-085) |
| 5. Ouvrir un post reçu | P-09 → P-30 → P-09 | F-075, puis F-016, F-017, F-018, F-019 comme FL-02, et F-005 | E-11 (post partagé), E-03, E-04, E-01 (D-162, D-163) | Comme FL-02 |
| 6. Citer un message | P-09 | F-040 | — | E-11 (message cité, écrit avec l'envoi) |
| 7. Envoyer un message | P-09 | F-041 | — | E-11 (charabia, D-083), E-10 (dernier message, heure, non lu chez l'ami, D-085) |
| 8. Envoyer une photo | P-09 | F-042 | — | E-11 (photo), E-04 (graine et algorithme, D-086), E-10 (« Photo », heure, non lu chez l'ami, D-085) |
| 9. Revenir aux discussions | P-09 → P-08 | F-005 | — | — |

Suite simple : P-03 → F-025 → P-08 → F-037 → P-09 → F-040 (au besoin) → F-041 ou F-042 → F-005 → P-08. Un post reçu s'ouvre en P-30 (F-075), et sa flèche ramène à P-09. Les entités suivent les `operations` des features : F-033 et F-039 lisent ; F-040, F-041 et F-042 écrivent ; F-037 et F-038 lisent et écrivent (lu, D-085).

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-08.c | Les discussions ne chargent pas | P-08.d : « Les discussions n’ont pas pu être chargées. » avec « Réessayer » |
| P-08 | Aucune discussion | P-08.a : « Ajouter un ami » ouvre P-11 (FL-04, D-035) |
| P-08 | La recherche ne trouve rien | Liste vide sans message (F-033) |
| P-08 | Écrire à un non-ami | Impossible : une conversation n'existe qu'entre amis (D-082) |
| P-08 | Message reçu hors de sa conversation | La discussion passe en gras avec le point bleu ; ni notification ni pastille (D-084) |
| P-09.a | Les messages ne chargent pas | P-09.d : « Les messages n’ont pas pu être chargés. » avec « Réessayer » |
| P-09 | Conversation vide (nouvel ami) | P-09.b : « Aucun message » · « Écris le premier message à … » |
| P-09 | L'ami écrit | Bulle grise à trois points (F-038, D-084) |
| P-09 | Message reçu, P-09 ouverte | Il s'ajoute en bas ; la conversation reste lue (D-085) |
| P-09 | Champ vide | L'icône image tient la place d'« Envoyer » (F-042) |
| P-09 | Croix du bandeau « Réponse à … » | La citation est annulée (F-040) |
| P-09.c | L'envoi d'un message échoue | Le message reste, « Non envoyé. » avec « Réessayer » seulement (D-027, D-030) |
| P-09.e | L'envoi d'une photo échoue | Photo cerclée de rouge, « Non envoyée. » avec « Réessayer » (D-042) |
| P-09 | Icône téléphone | Sans effet (question ouverte de F-039) |

Fin du flow : retour sur P-08 ; la conversation montre le dernier message et l'heure, et passe en non lu chez l'ami.

### Manques du registre

Réglés le 24 novembre 2026 :

- On ne savait pas si l'on pouvait écrire à un non-ami : amis seulement (D-082) ; les questions d'accès de F-037 à F-042 sont closes.
- Rien ne disait ce que contient un message : seul le charabia quitte le téléphone (D-083).
- La réception n'était que simulée : messages et saisie de l'ami en direct, sans notification (D-084).
- Aucune feature ne mettait la conversation à jour à l'envoi : F-041 et F-042 écrivent E-10, et « lu / non lu » est gardé pour chacun des deux amis (D-085).
- Dans toute l'app, photos et vidéos deviennent un art généré à partir d'une graine, seule envoyée ; le flou du design en tient lieu (D-086).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-038 : jusqu'où remonte une conversation, et chargement des anciens messages.
- F-039 : appel à concevoir ou à retirer.
- F-042 : choix de la photo ; briques de l'art généré au départ, et vidéos (D-086, D-119).
- F-019 : un post envoyé à un ami passe-t-il la conversation en non lu chez lui ? (Son aspect est réglé par D-162.)
- F-034 : retirer un ami ou bloquer un compte, et donc le sort de la conversation.

## FL-08 Rechercher

Un utilisateur connecté (R-02) ouvre la Recherche, tape un mot ou touche une suggestion ou une tendance sur P-14, parcourt la grille de P-15, puis ouvre un résultat sur P-16, où il réagit comme dans le fil. Le texte tapé ne quitte jamais le téléphone : seule sa graine est envoyée (D-139). Mobile seulement. Décisions : D-046, D-049, D-050, D-051, D-062, D-087, D-088, D-089, D-090, D-139.

### Entrées

- Icône loupe du menu du bas (F-025), depuis toute page qui l'a → P-14, champ vide.
- Fermer une création de post ouverte depuis P-14, P-15 ou P-16 (F-005.a) → P-14 (D-090).

Hors de ce flow : les réactions sur P-16 et leurs panneaux P-05 à P-07 (FL-02, D-049, D-050) ; publier un post avec le bouton + (FL-03) ; chercher un compte (F-043, FL-04) ou une discussion (F-033, FL-07) ; le grisage F-024, qui s'applique à P-14, P-15 et P-16 (FL-05).

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Ouvrir la Recherche | P-03 (ou une autre page) → P-14.a → P-14 | F-025, F-053 | E-13 (8 suggestions tirées au hasard, 6 tendances, sur le téléphone, D-089), E-03 (nombre de posts de chaque tendance, D-089 ; ce qu'il compte est ouvert dans F-053, D-139) | — |
| 2. Taper une recherche | P-14 → P-15.a → P-15 | F-052 | E-13 (texte saisi → graine, sur le téléphone, D-139) ; E-03, E-04, E-09 (graine des médias de chaque post, D-139 ; jusqu'à 18 posts visibles, les plus proches de la graine, D-088, D-139) | — |
| 2'. Lancer une suggestion ou une tendance | P-14 → P-15.a → P-15 | F-053, F-053.a, puis F-052 | E-13 (champ rempli), E-03, E-04, E-09 | — |
| 3. Modifier la recherche | P-15 | F-052 | E-13 (nouvelle graine à chaque frappe), E-03, E-04, E-09 | — |
| 4. Revenir aux suggestions | P-15 → P-14 | F-052 (champ vidé) | E-13 | — |
| 5. Ouvrir un résultat | P-15 → P-16 | F-054, F-010.a | E-03, E-04 | — |
| 6. Passer d'un résultat à l'autre | P-16 | F-009.a, F-010.a, F-020, F-021 | E-03, E-04 | — |
| 7. Réagir | P-16 → P-05, P-06, P-07 → P-16 | F-016, F-016.a, F-017, F-018, F-019, F-027 | Comme FL-02 | Comme FL-02 (E-06, E-03, E-08, E-05, E-07, E-11, E-10) |
| 8. Revenir aux résultats | P-16 → P-15 | F-010.a | — | — |

Suite simple : P-14 → F-052 (ou F-053) → P-15 → F-054 → P-16 → F-009.a → F-010.a → P-15. Les entités suivent les `operations` des features : F-052, F-053 et F-054 lisent seulement. E-13 vit sur le téléphone : rien de la recherche n'est écrit sur le serveur (D-087, D-089).

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-14.a | Les suggestions ne chargent pas | P-14.b : « Les suggestions n’ont pas pu être chargées. » avec « Réessayer » ; le champ reste utilisable (F-053) |
| P-15 | Chaque frappe | La graine est recalculée sur le téléphone et la grille change (F-052, D-139) |
| P-15 | Champ vidé | Retour à P-14 |
| P-15.a | La recherche n'aboutit pas | P-15.c : « La recherche n’a pas abouti. » avec « Réessayer » |
| P-15.a | Aucun post à montrer (un post trop loin de la graine est-il écarté ? ouvert dans F-052, D-139) | P-15.b : « Aucun résultat » · « Aucun post ne correspond à « … ». Essaie un autre mot. » (D-087) |
| P-15 | Post hors de son audience pour l'utilisateur | Jamais dans les résultats ni dans les tendances (D-088, D-089) |
| P-16 | Premier ou dernier résultat | Résistance, pas de posts suivants à charger (F-009.a, D-049) |
| P-16 | Like ou enregistrement échoué | Comme P-03.e et P-03.f (FL-02, D-046) |
| P-16 | Partage réussi | Message 2 s sur P-16 : « Envoyé à … », « Lien copié. » ou « Partagé. » (D-051) |
| P-16 | Flèche retour ou Échap | P-15, même recherche (F-010.a) |
| P-12 | Création ouverte depuis la Recherche, puis fermée | P-14, champ vide (D-090) |

Fin du flow : retour sur P-15 avec la même recherche, ou sur P-14 champ vide.

### Manques du registre

Réglés le 24 novembre 2026 :

- Rien ne disait si le texte cherché quittait le téléphone, ni quand s'affiche « Aucun résultat » : seule la palette part, et la grille montre jusqu'à 18 posts visibles de cette palette (D-087). Depuis le 26 novembre 2026, une graine remplace la palette (D-139).
- Qui voit un post n'était pas réglé : son audience décide, et la recherche ne montre que les posts qu'on peut voir ; F-052 lit E-09 (D-088). Les questions d'accès de F-010, F-052 et F-054 sont closes.
- L'origine des suggestions et des tendances : du charabia tiré par l'app, sans historique ; les tendances comptent les posts visibles de leur palette ; F-053 lit E-03 (D-089).
- D-062 ne disait pas où revient une création ouverte depuis P-15 ou P-16 : sur P-14, comme la maquette (D-090).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-053 : choix des 6 mots des tendances et rythme de leur renouvellement.
- F-050 : agir sur un post suit-il aussi son audience ? (accès supposés de F-016, F-017, F-018, F-019, F-020 et F-030, FL-02)
- F-051 : qui fixe la palette d'un post à la publication ; réglé depuis, un post n’a plus de palette (D-139). F-052 : la règle de la recherche par graine. F-053 : aussi ce que comptent et montrent les tendances (D-139).

## FL-09 Soutenir le projet

Un utilisateur connecté (R-02) cumule du temps d'utilisation sur son compte (E-15) ; à 1 h, P-22 et un post sur 20 du fil (F-015.a) lui proposent de soutenir le projet pour 1,99 €, payés une seule fois dans l'App Store ou Google Play. Mobile seulement. Décisions : D-005, D-022, D-027, D-036, D-075, D-077, D-092, D-093, D-094, D-095, D-096, D-105, D-115, D-116, D-117.

### Entrées

- Fin de FL-01 : dès la connexion, F-073 ajoute à E-15 chaque seconde passée appli ouverte et au premier plan (D-093, D-096).
- Panneau Options (P-20), ligne « Premium » → P-22.
- Le fil P-03, après 1 h : le post Premium (F-015.a), 1 post sur 20.

Hors de ce flow : le minuteur de couleur (E-14) et le grisage F-024, qui s'appliquent aussi à P-22 (FL-05) ; l'icône du thème en tête de P-22 (F-002.a).

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Compter le temps | Chaque seconde, appli au premier plan, connecté | Pages de F-073 | F-073 | E-15 | E-15 (durée cumulée, D-093 ; secondes sans réseau renvoyées par FL-12, D-117) |
| 2. Suivre son temps | Ligne « Premium » de P-20 | P-20 → P-22 | F-065 | E-15 (temps passé, minutes restantes avant 1 h) | — |
| 3. Voir l'offre | E-15 atteint 1 h | P-22 ; P-03 (1 post sur 20) | F-015, F-015.a | E-15, E-16 (non soutenu) | — |
| 4. Payer | Bouton « Soutenir le projet » | P-22 ou P-03 → paiement du store | F-015 ou F-015.a | E-16 | — |
| 5. Être remercié | Le store confirme l'achat | P-22 ou P-03 | F-015 ou F-015.a | — | E-16 (soutenu, achat du store, D-092, D-095) |
| 6. Après le soutien | Revenir sur P-22, ou recharger le fil | P-22 ; P-03 | F-015, F-015.a | E-16 (soutenu) | — |
| 7. Changer de téléphone | Connexion (FL-01) sur un autre téléphone, ou après réinstallation | P-22 | F-015, F-065 | E-15, E-16 du compte | — |

Suite simple : F-073 (jusqu'à 1 h) → P-20 → P-22 (F-065) → F-015 → store → « Merci pour ton soutien. » ; ou P-03 → F-015.a → store → même merci. Les entités suivent les `operations` des features : F-073 lit et écrit E-15 ; F-065 lit E-15 ; F-015 lit E-15 et E-16, et écrit E-16.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| Toutes | Appli fermée ou en arrière-plan | Le temps ne compte pas (D-075, D-093) |
| P-22 | Moins de 1 h | Anneau, « Après une heure dans l'appli, tu pourras soutenir le projet. » et « encore X min » ; pas d'offre (F-065, D-005) |
| P-22 | 1 h atteinte sur la page | L'offre apparaît : « Une heure passée ici. Soutiens un projet indépendant. », 1,99 €, « Soutenir le projet » |
| P-03 | Moins de 1 h, ou compte soutenu avant ce chargement du fil | Aucun post Premium (F-015.a, D-094) |
| Store | Paiement échoué, rien débité | P-22.a ou P-03.c : « Le paiement n’a pas abouti. Tu n’as pas été débité. » avec « Réessayer » (D-027) |
| Store | Paiement annulé | P-22.b : « Paiement annulé. Tu n’as pas été débité. » et de nouveau « Soutenir le projet » ; même état sur F-015.a (D-036) |
| Serveur | Le store a débité, le serveur n'enregistre pas | « Merci pour ton soutien. » quand même ; l'achat est renvoyé sans message par FL-12 (D-095, D-112) ; le serveur n'enregistre qu'un soutien par compte, même si un autre téléphone a payé entre-temps (D-115) |
| P-22 | Compte déjà soutenu | Anneau et offre gardés, « Merci pour ton soutien. » à la place du bouton (D-094) |
| FL-01 | Autre téléphone, réinstallation ou déconnexion | Même temps et même soutien : ils appartiennent au compte (D-092, D-093) |
| Toutes | Deux téléphones ouverts en même temps sur le compte | Le temps ne compte qu'une fois (D-105) |
| Store | Remboursement, ou achat en attente | Ouvert : F-015 |

Fin du flow : « Merci pour ton soutien. » sur P-22 ou dans le post Premium ; le compte reste « soutenu » pour de bon.

### Manques du registre

Réglés le 25 novembre 2026 :

- Le moyen de paiement : un achat unique dans l'App Store ou Google Play, une fois par compte (D-092). La question ouverte de F-015 est close.
- Le temps d'utilisation appartient au compte, comme le minuteur de couleur (D-093) : la question de F-065, laissée par FL-05, est close.
- Ce qui reste visible après le soutien : comme la maquette (D-094). La règle « masquée si le compte a déjà soutenu » de F-015 est close.
- Un achat débité mais pas enregistré n'affiche jamais d'erreur (D-095).
- Aucune feature n'écrivait E-15 : nouvelle feature F-073 « Compter le temps d'utilisation », sur les pages de F-024 (D-096).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-015 : remboursement par le store ; achat en attente (à approuver par un parent, paiement différé).
- F-073 : deux téléphones ouverts en même temps sur le même compte, comme F-024 ; réglé depuis par D-105.

## FL-11 Gérer son profil et son compte

Un utilisateur connecté (R-02) consulte son profil (P-17), change son pseudo, sa description (P-19) ou sa photo (P-18), règle l'interface de l'appli (P-23), puis peut se déconnecter ou supprimer son compte (P-21). Mobile seulement. Décisions : D-023, D-053, D-063, D-065, D-069, D-083, D-086, D-091, D-098, D-099, D-100, D-101, D-102, D-103, D-104, D-116, D-128.

### Entrées

- Icône Profil du menu du bas (F-025), depuis P-03, P-08, P-14, P-15 ou P-16 → P-17.
- Fin de FL-01 avec un nouveau compte : la photo et la description se règlent ici, sur P-18 et P-19 (D-063).

Hors de ce flow : le minuteur de couleur de P-17 (F-059 à F-061) et le grisage F-024 (FL-05) ; « Créer un post » de P-17.a et le bouton + (F-026, FL-03) ; la ligne « Premium » de P-20 et le comptage F-073 (FL-09) ; la Connexion qui suit la déconnexion ou la suppression (FL-01) ; ce que le serveur garde 7 jours après la suppression, ses sauvegardes et le seul numéro interne du compte (FL-15, D-128).

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Voir son profil | Icône Profil (F-025) | P-17 (P-17.b pendant le chargement des posts) | F-057, F-062 | E-01 (pseudo et description en charabia, @, photo, compteurs), E-03 (ses posts) | — |
| 2. Ouvrir la modification | Lien « Modifier » | P-17 → P-19 | F-056 | E-01 (charabia actuel, prérempli, D-098) | — |
| 3. Enregistrer | Lien « Enregistrer » | P-19 → P-19.a → P-17 | F-056 | — | E-01 (pseudo et description, en charabia fait sur le téléphone, D-098, D-099) |
| 3'. Annuler | Lien « Annuler » | P-19 → P-17 | F-005.b | — | — |
| 4. Changer sa photo | Photo ronde de P-17 | P-17 → P-18 → P-17 | F-058, F-027 | — | E-04 (graine et algorithme, D-086), E-01 (photo) ; renvoyés sans message (D-100) |
| 5. Ouvrir les options | Engrenage | P-17 → P-20 | F-055, F-027.b | — | — |
| 6. Régler l'interface | Ligne « Interface de l'appli » | P-20 → P-23 → P-20 (F-005, D-023) | F-002.b, F-066, F-067 | E-17 (sur le téléphone, D-103) | E-17 |
| 7. Voir son compte | Ligne « Gérer mon compte » | P-20 → P-21 | F-057.a | E-01 (@) | — |
| 8a. Se déconnecter | Bouton « Se déconnecter », sans confirmation | P-21 → P-01 | F-071 | — | E-02 (session de ce téléphone fermée, D-053, D-065) |
| 8b. Supprimer son compte | « Supprimer mon compte », puis « Supprimer définitivement » | P-21 → « Compte supprimé » 2 s → P-01 (D-069) | F-063 | — | Tout le compte effacé (D-101) : E-01 à E-12, E-14, E-15, E-16 ; seul son numéro interne est gardé 7 jours, et les sauvegardes qui le portent sont effacées en 7 jours (D-128, FL-15) |

Suite simple : P-17 → F-056 → P-19 → P-17 ; P-17 → F-058 → P-18 → P-17 ; P-17 → F-055 → P-20 → P-23 (F-066, F-067) ou P-21 → F-071 / F-063 → P-01. Les entités suivent les `operations` des features : F-057 et F-062 lisent E-01 et E-03 ; F-056 lit et écrit E-01 ; F-058 écrit E-01 et E-04 ; F-066 et F-067 écrivent E-17, que F-002 lit ; F-071 et F-063 suppriment.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-17 | Ses posts chargent | P-17.b : anneau centré (F-062) |
| P-17 | Ses posts ne chargent pas | P-17.c : « Tes posts n’ont pas pu être chargés. » avec « Réessayer » |
| P-17 | Aucun post | P-17.a : « Créer un post » ouvre P-12 (F-026, D-035, FL-03) |
| P-19 | Pseudo vide | L'ancien pseudo est gardé, sans message (D-099) |
| P-19 | Description vide | Enregistrée vide (D-099) |
| P-19 | Frappe au-delà de 16 ou 80 caractères | Bloquée |
| P-19.a | L'enregistrement échoue | P-19.b : « Tes modifications n’ont pas été enregistrées. Vérifie ta connexion et réessaie. » avec « Réessayer », saisies gardées (D-027) |
| P-18 | Fichier inutilisable | P-18.a : « Cette image n’a pas pu être utilisée. Choisis-en une autre. » |
| P-18 | Pas de réseau | Photo appliquée sur le téléphone, renvoyée sans message (D-100, FL-12) |
| P-18 | Accès à la galerie refusé | Ouvert : F-058 |
| P-23 | Nouveau téléphone ou réinstallation | Thème Noir, carrousels de pause activés (D-103) |
| P-21 | « Annuler » dans la fenêtre | La fenêtre se ferme, rien n'est effacé |
| P-21 | La suppression échoue | P-21.a : « Ton compte n’a pas pu être supprimé. Rien n’a été effacé. » avec « Réessayer » : tout ou rien (D-101) |
| F-071 | Envois en attente (D-077, D-078, D-095, D-100 ; D-109) | Gardés pour la prochaine connexion du compte sur ce téléphone, jamais pour un autre compte (D-104) |
| F-063 | Envois en attente | Abandonnés avec le compte (D-101), soutien compris (D-116) |
| Autre téléphone | Compte supprimé ailleurs | P-01 à son prochain échange avec le serveur (D-101) |
| F-070 | Quelqu'un prend le @ d'un compte supprimé | Permis tout de suite (D-102) |
| P-17 | Ouvrir un de ses posts ; combien de posts montre la grille | Ouvert : F-062 |
| P-17 | Calcul réel des compteurs | Ouvert : F-057 |

Fin du flow : P-17 ou P-20 après une modification ou un réglage ; P-01 après la déconnexion ou la suppression (FL-01).

### Manques du registre

Réglés le 25 novembre 2026 :

- Ce qui quitte le téléphone quand on modifie son profil : seulement le charabia (D-098). La règle du pseudo vide, laissée en question par F-056, est close (D-099).
- L'enregistrement de la photo sans réseau (D-100).
- Ce qu'efface la suppression du compte : F-063 n'écrivait que E-01 et E-02 ; elle efface désormais tout le compte, tout de suite (D-101), et libère son @ (D-102). Le 26 novembre 2026, D-128 a précisé ce qui reste 7 jours : les sauvegardes et le seul numéro interne du compte (FL-15). La question ouverte de F-063 est close.
- Où vivent les préférences d'interface : sur le téléphone (D-103). Les questions de F-002, F-066 et F-067 sont closes, et P-23, qui n'était dans aucun flow, entre dans FL-11.
- Ce que devient un envoi en attente à la déconnexion (D-104).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-057 : calcul réel des compteurs.
- F-058 : autorisation d'accès à la galerie, et l'état si elle est refusée.
- F-062 : ouvrir un de ses posts ; nombre de posts de la grille.
- F-066 : changement réel de l'icône du téléphone.
- F-070 : règles de l'identifiant (longueur, caractères permis, message s'il est pris).

## FL-12 Renvoyer les envois en attente

Tâche de fond, sans geste de l'utilisateur : ce qu'un utilisateur connecté (R-02) a changé sur son téléphone sans que le serveur l'enregistre attend sur ce téléphone, rattaché à son compte, puis repart sans message jusqu'à ce que le serveur l'enregistre ou le refuse pour de bon. Mobile seulement. Décisions : D-077, D-078, D-095, D-100, D-101, D-104, D-108, D-109, D-111, D-112, D-113, D-116, D-117, D-120, D-121, D-122.

### Entrées

- FL-03 : la graine d'une photo choisie ou prise (F-044, F-046, D-120), ou l'effacement des graines d'une photo retirée ou d'un brouillon fermé (F-044, F-005.a, D-121), que le serveur n'a pas reçus (D-122).
- FL-05 : une durée (F-060) ou une réinitialisation (F-061) que le serveur n'a pas enregistrée (D-077) ; une période passée appli ouverte au premier plan sans réseau (F-024, F-073, D-117).
- FL-06 : une « vue » de story (F-036) que le serveur n'a pas enregistrée (D-078).
- FL-09 : un soutien débité par le store que le serveur n'a pas enregistré (F-015, D-095).
- FL-11 : une photo de profil (F-058) dont la graine n'est pas enregistrée (D-100, D-119).

Hors de ce flow : les envois qui montrent une erreur avec « Réessayer » (publier, commenter, envoyer un message…), que l'utilisateur relance lui-même ; l'effacement par le serveur des graines que rien n'a prises, dans FL-14 (D-123).

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Garder l'envoi | Le serveur n'enregistre pas un changement de FL-03, FL-05, FL-06, FL-09 ou FL-11 | — | F-044, F-046, F-005, F-060, F-061, F-036, F-015, F-058, F-024, F-073 | — | Sur le téléphone : l'envoi, son compte et l'heure où il a été fait |
| 2. Partir | Ouverture de l'appli ou retour au premier plan, ou retour du réseau appli ouverte, connecté au compte de l'envoi (D-112) | — | Celle de l'envoi | — | — |
| 3. Envoyer | Un envoi après l'autre, du plus ancien au plus récent | — | Celle de l'envoi | — | E-14 (durée ou cycles, D-077 ; secondes au premier plan, D-117), E-15 (secondes au premier plan, D-117), E-12 (vue par, D-078), E-16 (soutien, D-095), E-04 et E-01 (photo, D-100), E-04 (graine d'un brouillon, D-120 ; graines effacées, D-121) |
| 4. Enregistré | Le serveur l'enregistre | — | — | — | L'envoi quitte le téléphone |
| 5. Attendre | Réseau ou serveur injoignable | — | — | — | — (l'envoi repart au prochain départ, étape 2) |

Suite simple : changement non enregistré → 1 → 2 → 3 → 4, ou 5 puis de nouveau 2. Le téléphone montre déjà le changement pendant toute l'attente ; rien n'est affiché par ce flow.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| Serveur | Réseau ou serveur injoignable | L'envoi reste sur le téléphone et repart au prochain départ (D-112) ; aucun message |
| Serveur | Deux téléphones ont changé le minuteur hors connexion | Le changement fait le plus tard, selon l'heure des téléphones corrigée par celle du serveur (D-140), est gardé (D-111) ; leurs secondes sans réseau se fusionnent, une seconde commune ne comptant qu'une fois, sauf pour une période arrivée plus de 7 jours après sa fin (D-147), et seules celles d'après la dernière réinitialisation comptent pour le minuteur (D-105, D-117) |
| Serveur | Refus pour de bon : données invalides, story déjà effacée (FL-13), graine déjà effacée (FL-14) | Envoi abandonné sans message ; au chargement suivant, le téléphone montre ce que le serveur a (D-113) |
| Serveur | Soutien refusé | Jamais abandonné : renvoyé jusqu'à ce qu'il soit enregistré (D-095, D-113), sauf si le compte est supprimé (D-116) |
| Téléphone | Le brouillon d'une graine en attente disparaît (« Fermer », photo retirée, appli fermée de force, téléphone éteint) | La graine est abandonnée, jamais envoyée (D-121, D-122) |
| F-051 | Publication avec des graines en attente | Elles partent avec la publication et quittent le téléphone (D-120, D-122) |
| F-071 | Déconnexion | Les envois restent sur le téléphone, rattachés au compte, et repartent à sa prochaine connexion sur ce téléphone ; jamais pour un autre compte (D-104, D-109) |
| F-063 | Compte supprimé sur ce téléphone | Envois abandonnés avec le compte (D-101, D-109) |
| Autre téléphone | Compte supprimé ailleurs | Le serveur refuse ses envois pour de bon : abandonnés, soutien compris (D-101, D-113, D-116) ; un téléphone qui n'est plus connecté à ce compte les abandonne à son prochain échange avec le serveur, quel que soit le compte connecté (D-101) |

Fin du flow : chaque envoi finit enregistré ou abandonné, sans rien montrer à l'utilisateur.

### Manques du registre

Réglés le 25 novembre 2026 :

- Le renvoi a son propre flow (D-108) ; une « vue » en attente suit les mêmes règles que les autres envois (D-109).
- Deux téléphones qui changent le minuteur : le changement fait le plus tard gagne (D-111) ; la question ouverte de F-060 est close.
- Les envois partent à l'ouverture, au retour au premier plan et au retour du réseau (D-112).
- Un refus pour de bon abandonne l'envoi, sauf un soutien (D-113), abandonné seulement avec son compte (D-116).
- Le temps passé appli ouverte sans réseau compte, et passe par ce flow (D-117).
- La graine d'une photo et l'effacement des graines sont des envois en attente comme les autres ; une graine dont le brouillon a disparu n'est jamais envoyée (D-122).

Aucune feature ni page ne manque : la tâche n'a rien à l'écran.

## FL-13 Finir une story

Tâche de fond du serveur, sans geste de l'utilisateur : 24 h après sa publication, une story passe à Finie et le serveur l'efface. Mobile seulement. Décisions : D-079, D-101, D-110, D-113, D-148.

### Entrées

- Une story enregistrée (F-051, destination Story, F-068) prend sa fin : publication + 24 h (D-079, SM-E-12).

Hors de ce flow : regarder une story, dans FL-06 ; l'effacement de toutes les stories d'un compte supprimé (F-063, D-101), dans FL-11.

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Finir | La fin (E-12) est atteinte | — | — | E-12 (fin) | E-12 (Finie) |
| 2. Effacer | Tout de suite après | — | — | — | E-12 effacée du serveur, avec ses images et sa liste « vue par » (D-110) ; E-08 : ses notifications effacées (D-148) |
| 3. Disparaître des téléphones | Chargement suivant de P-08 ou de P-09 | P-08, P-09 | F-036 | E-12 | — (plus de rond ni de cercle, D-079) |

Suite simple : fin atteinte → 1 → 2 → 3. F-036 lit E-12 ; la tâche du serveur n'est portée par aucune feature.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-10 | Story ouverte après sa fin, avant le chargement suivant | P-10.b ; son cercle disparaît au chargement suivant (D-079) |
| Serveur | « Vue » renvoyée après la fin (FL-12) | Refus pour de bon : abandonnée sans message (D-110, D-113) |
| F-063 | L'auteur supprime son compte avant la fin | La story est effacée avec le compte (D-101) |

Fin du flow : la story n'existe plus nulle part et ne se rouvre jamais (D-079).

### Manques du registre

Réglé le 25 novembre 2026 : une story finie est effacée du serveur dès sa fin (D-110) ; la question ouverte de F-036 est close.

Reste ouvert, dans les `questions_ouvertes` de F-036 : une story en cours de lecture sur P-10 quand sa fin arrive va-t-elle jusqu'au bout ?

Aucune feature ni page ne manque.

## FL-14 Effacer les graines orphelines

Tâche de fond du serveur, sans geste de l'utilisateur : 24 h après son arrivée, une graine rattachée à rien est effacée avec son algorithme. Mobile seulement. Décisions : D-101, D-113, D-120, D-121, D-122, D-123.

### Entrées

- Une graine reçue avant la publication de son post ou de sa story (F-044, F-046, D-120), par FL-03 ou FL-12 (D-122).

Hors de ce flow : l'effacement demandé par le téléphone quand une photo est retirée ou le brouillon fermé (D-121), dans FL-03 et FL-12 ; l'effacement de tous les médias d'un compte supprimé (F-063, D-101), dans FL-11.

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Attendre | Une graine arrive sans post ni story (D-120) | — | F-044, F-046 | — | E-04 (graine, heure d'arrivée, D-123) |
| 2. Effacer | 24 h après son arrivée, si rien ne l'a prise : ni post, ni story, ni message, ni photo de profil | — | — | E-04 (heure d'arrivée) | E-04 effacée du serveur, avec son algorithme (D-123) |

Suite simple : graine arrivée → 1 → 2. Publiée avant, elle est rattachée au post ou à la story (F-051) et sort de ce flow. F-044 et F-046 écrivent E-04 ; la tâche du serveur n'est portée par aucune feature.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| Serveur | Publication dans les 24 h | La graine est rattachée au post ou à la story, et n'est pas effacée (F-051) |
| P-13.a | Publication après l'effacement | La publication renvoie les graines que le serveur n'a plus (D-123) |
| Serveur | Effacement demandé par le téléphone (FL-12) après celui de FL-14 | Refus pour de bon : abandonné sans message (D-113, D-122) |
| F-063 | Compte supprimé avant les 24 h | Ses graines sont effacées avec lui (D-101) |

Fin du flow : aucune graine que rien n'a prise ne reste plus de 24 h sur le serveur.

### Manques du registre

Réglé le 25 novembre 2026 : les graines d'un brouillon perdu sont effacées 24 h après leur arrivée (D-123) ; E-04 prend l'heure d'arrivée de la graine, et la question ouverte de F-044 est close.

Aucune feature ni page ne manque : la tâche n'a rien à l'écran.

## FL-15 Oublier un compte supprimé

Tâche de fond du serveur, sans geste de l'utilisateur : 7 jours après sa suppression, un compte n'est plus dans aucune sauvegarde du serveur, et le serveur oublie son numéro interne. Mobile seulement. Décisions : D-101, D-102, D-128.

### Entrées

- La suppression d'un compte (F-063), à l'étape 8b de FL-11 (D-101).
- Les sauvegardes du serveur, faites sans geste de personne (D-128).

Hors de ce flow : l'effacement du compte lui-même, tout de suite et tout ou rien, dans FL-11 (D-101) ; l'effacement des stories finies (FL-13) et des graines orphelines (FL-14).

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Noter le compte supprimé | Le serveur efface le compte (F-063, D-101) | — | F-063 | — | Liste des comptes supprimés : son numéro interne seul et l'heure de la suppression, ni @, ni adresse, ni contenu (D-102, D-128) |
| 2. Sauvegarder | Chaque sauvegarde du serveur | — | — | Tout ce que garde le serveur | Une sauvegarde, gardée 7 jours au plus (D-128) |
| 3. Effacer les vieilles sauvegardes | 7 jours après une sauvegarde | — | — | — | La sauvegarde effacée (D-128) |
| 4. Oublier le numéro | 7 jours après la suppression | — | — | Liste des comptes supprimés (heure de la suppression) | Son numéro interne effacé de la liste (D-128) |

Suite simple : F-063 → 1 → 4 ; à côté, 2 → 3 pour chaque sauvegarde. F-063 écrit la liste des comptes supprimés ; la tâche du serveur n'est portée par aucune feature.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| Serveur | Une sauvegarde est restaurée après une panne | Chaque compte de la liste des comptes supprimés en est effacé à nouveau, tout comme à l'étape 8b de FL-11 (D-101, D-128) |
| Serveur | Sauvegarde faite avant la suppression | Elle porte encore le compte jusqu'à son effacement, au plus 7 jours après la suppression (D-128) |
| Serveur | Sauvegarde restaurée plus de 7 jours après une suppression | Impossible : aucune sauvegarde n'a plus de 7 jours, donc aucune ne porte un compte dont le numéro est déjà oublié (D-128) |
| F-070 | Quelqu'un a pris le @ du compte supprimé, puis une sauvegarde est restaurée | L'ancien compte est effacé par son numéro interne ; le nouveau titulaire garde le @ (D-102, D-128) |

Fin du flow : 7 jours après sa suppression, rien du compte ne reste sur le serveur, ni dans une sauvegarde, ni dans la liste des comptes supprimés.

### Manques du registre

Réglé le 26 novembre 2026 : D-128 n'était dans aucun flow ; FL-15 le décrit, et FL-11, NFR-X-4, D-101 et D-102 disent ce qui reste 7 jours.

Aucune feature ni page ne manque : la tâche n'a rien à l'écran. La liste des comptes supprimés n'est pas une entité du registre : elle ne garde qu'un numéro, sans rien du compte ; sa table est TB-26 (« Modèle de données »).

## FL-16 Oublier les connexions inachevées

Tâche de fond du serveur, sans geste de l'utilisateur : 1 h au plus après l'envoi d'un code ou le début d'une inscription, le serveur oublie l'adresse e-mail, ou le compte Google ou Apple, qui n'a pas mené à un compte. Mobile seulement. Décisions : D-127, D-131, D-149.

### Entrées

- FL-01 : un code envoyé à une adresse (F-003, F-008) ; une inscription commencée (P-27), après le bon code (F-007) ou un compte Google ou Apple sans compte de l'appli (F-001).

Hors de ce flow : la vérification du code et ses 10 min, dans FL-01 (D-127) ; la création du compte (F-070), qui efface l'inscription.

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Effacer les vieux codes | 1 h après l'envoi d'un code qui n'a pas servi | — | — | E-02 (heure d'envoi) | E-02 : le code et son adresse effacés (D-149) |
| 2. Effacer les vieilles inscriptions | 1 h après le début d'une inscription que F-070 n'a pas finie | — | — | E-02 (début de l'inscription) | E-02 : l'inscription et son adresse ou son compte tiers effacés (D-149) |

Suite simple : code envoyé → 1 ; inscription commencée → 2. Ni l'une ni l'autre n'est portée par une feature.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| F-007 | Bon code donné avant l'effacement | Le code est effacé tout de suite par FL-01 ; rien à faire ici |
| F-008 | Nouveau code demandé | Il remplace l'ancien, et l'heure d'envoi repart (D-131) |
| F-070 | Compte créé plus d'1 h après le début de l'inscription | L'inscription n'existe plus : P-27 le dit, puis P-01 s'ouvre (D-154) |

Fin du flow : 1 h après, le serveur ne garde rien d'une personne qui n'a pas créé de compte.

### Manques du registre

Réglé le 27 novembre 2026 : D-149 fixe le délai, et TB-03 et TB-04 sont les tables effacées (« Modèle de données »).

Ce que voit quelqu'un qui finit son inscription plus d'1 h après l'avoir commencée est fixé par D-154.

## FL-17 Oublier les vieilles périodes au premier plan

Tâche de fond du serveur, sans geste de l'utilisateur : 7 jours après sa fin, une période où l'appli d'un compte était au premier plan est effacée ; le minuteur et le temps d'utilisation l'ont déjà comptée. Mobile seulement. Décisions : D-105, D-117, D-147.

### Entrées

- FL-05 et FL-12 : les périodes au premier plan des téléphones du compte (F-024, F-073, D-117), que le serveur fusionne pour compter chaque seconde une fois (D-105).

Hors de ce flow : la fusion elle-même et le compte des secondes, dans FL-05 et FL-12 ; l'effacement de tout le compte (F-063, D-101), dans FL-11.

### Séquence

| Étape | Déclencheur | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- | --- |
| 1. Effacer | 7 jours après la fin d'une période | — | — | E-15 (fin de chaque période) | E-15 : la période effacée ; la durée cumulée ne change pas (D-147) |

Suite simple : période fusionnée → 1. La tâche n'est portée par aucune feature.

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| Serveur | Période arrivée plus de 7 jours après sa fin (FL-12) | Elle compte en entier, sans être comparée aux autres téléphones, puis est effacée (D-147) |
| F-063 | Compte supprimé | Ses périodes sont effacées avec lui (D-101) |

Fin du flow : le serveur ne garde jamais plus de 7 jours de l'usage de l'appli.

### Manques du registre

Réglé le 27 novembre 2026 : D-147 fixe le délai, et TB-23 est la table effacée (« Modèle de données »).

Aucune feature ni page ne manque : la tâche n'a rien à l'écran.

## États des entités

Étape 6 de la méthode : un diagramme d'états `SM-E-xx` par entité aux états non triviaux (D-107), tiré des flows FL-01 à FL-09 et FL-11 à FL-14 et des décisions du registre. Chaque passage cite la feature ou la tâche de fond qui le déclenche. Les autres entités (E-01, E-05 à E-07, E-11, E-13, E-15, E-17) ne font qu'exister puis être effacées ; leurs échecs d'envoi (« Non envoyé. », « Non publié. ») restent sur le téléphone et sont décrits dans les flows. Le seuil d'1 h de E-15 est une garde de SM-E-16. Partout, la suppression du compte (F-063) efface tout, tout de suite (D-101) ; seuls les sauvegardes du serveur et le numéro interne du compte restent 7 jours au plus (D-128, FL-15).

### SM-E-02 Connexion

Une par téléphone (D-053). Pas de modèle TLA+ : un seul téléphone, une suite linéaire.

```mermaid
stateDiagram-v2
    state "Déconnecté (P-01)" as deconnecte
    state "Code envoyé (P-02)" as code_envoye
    state "Code renvoyable (P-02)" as code_renvoyable
    state "Code expiré (P-02.b)" as code_expire
    state "Inscription (P-27)" as inscription
    state "Session ouverte (P-03)" as session
    [*] --> deconnecte
    deconnecte --> code_envoye : F-003
    code_envoye --> code_renvoyable : 30 s
    code_renvoyable --> code_envoye : F-008
    code_envoye --> code_expire : validité écoulée
    code_renvoyable --> code_expire : validité écoulée
    code_envoye --> code_expire : F-007, 5e code faux
    code_renvoyable --> code_expire : F-007, 5e code faux
    code_expire --> code_envoye : F-008
    code_envoye --> deconnecte : F-005
    code_renvoyable --> deconnecte : F-005
    code_envoye --> session : F-007, compte trouvé
    code_envoye --> inscription : F-007, aucun compte
    code_renvoyable --> session : F-007, compte trouvé
    code_renvoyable --> inscription : F-007, aucun compte
    deconnecte --> session : F-001, compte trouvé
    deconnecte --> inscription : F-001, aucun compte
    inscription --> session : F-070
    inscription --> deconnecte : F-005
    inscription --> deconnecte : 1 h, FL-16
    code_expire --> deconnecte : 1 h, FL-16
    session --> deconnecte : F-071, F-063, suppression ailleurs
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| Déconnecté → Code envoyé | F-003 | Code à 6 chiffres envoyé ; si l'envoi échoue, P-01.e et on reste Déconnecté |
| Code envoyé → Code renvoyable | 30 s écoulées | F-008 devient possible |
| Code renvoyable → Code envoyé | F-008 | Nouveau code, nouveau décompte de 30 s ; l'ancien code ne marche plus, 10 min et 5 essais neufs (D-131) |
| Code envoyé ou renvoyable → Code expiré | 10 min écoulées depuis l'envoi ; ou F-007, 5e code faux | P-02.b ; le code ne marche plus, même juste (D-127) |
| Code expiré → Code envoyé | F-008 | Nouveau code, 10 min et 5 essais neufs (D-131). Sans nouveau code, le serveur oublie le code et l'adresse 1 h après l'envoi (FL-16, D-149) |
| Code envoyé ou renvoyable → Code envoyé ou renvoyable | F-007, code faux | P-02.a ; un essai faux de plus, Code expiré au 5e (D-127) |
| Code envoyé ou renvoyable → Déconnecté | F-005 | Mauvaise adresse, retour à P-01 |
| Code envoyé ou renvoyable, ou Déconnecté → Session ouverte | F-007 bon code, ou F-001 / F-001.a, compte trouvé | P-03 |
| Code envoyé ou renvoyable, ou Déconnecté → Inscription | Même déclencheur, aucun compte | P-27 (D-052) |
| Inscription → Session ouverte | F-070 | Compte créé, avec son minuteur, son temps d'utilisation et son soutien (D-052, D-064, D-114) |
| Inscription → Déconnecté | F-005 | Abandon, aucun compte créé. Sans F-070, le serveur oublie l'inscription 1 h après son début (FL-16, D-149) ; ce que voit alors la personne est fixé par D-154 |
| Session ouverte → Déconnecté | F-071 ; F-063 ; compte supprimé sur un autre téléphone, au prochain échange avec le serveur | P-01 (D-053, D-065, D-069, D-101) ; les envois en attente restent rattachés au compte après F-071 (D-104) |

### SM-E-03 Post

Le brouillon est commun avec la story (SM-E-12) : F-068 choisit la destination juste avant F-051. Pas de modèle TLA+ : une suite linéaire, sans expiration (D-097).

```mermaid
stateDiagram-v2
    state "Brouillon, sur le téléphone" as brouillon
    state "En publication (P-13.a)" as en_publication
    state "Échec (P-13.b)" as echec
    state "Publié" as publie
    [*] --> brouillon : F-026, F-044, F-046
    brouillon --> [*] : F-005.a
    brouillon --> en_publication : F-051, Fil d'actualité
    en_publication --> publie : enregistré
    en_publication --> echec : refusé ou réseau
    echec --> en_publication : Réessayer, F-051
    publie --> [*] : F-063 de l'auteur
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| → Brouillon | F-026 ou F-026.a, puis F-044, F-045, F-046 | Seule la graine de chaque photo part au serveur avant F-051 (D-120, SM-E-04) ; le reste ne quitte pas le téléphone (D-045, D-068) ; F-047 à F-050 et F-068 le complètent |
| Brouillon → (abandonné) | F-005.a | Sans confirmation ni sauvegarde (D-045), retour à la page d'origine (D-062, D-090) ; le serveur efface aussitôt les graines déjà envoyées (D-121, SM-E-04) |
| Brouillon → En publication | F-051, destination « Fil d'actualité » (F-068) | Avec « Story », voir SM-E-12 |
| En publication → Publié | Le serveur enregistre | Fondu P-13.c (D-120), puis P-03.d (D-031) ; une notification « identification » par personne identifiée (D-061, SM-E-08) |
| En publication → Échec | Le serveur ou le réseau échoue | P-13.b, photos et légende gardées (D-027) |
| Échec → En publication | « Réessayer » (F-051) | — |
| Publié → (effacé) | F-063 de l'auteur | Seule fin d'un post : il n'expire jamais (D-097) et aucune feature n'efface un post seul (D-101) |

### SM-E-04 Média

Une graine par photo ou vidéo ; seuls la graine et son algorithme quittent le téléphone (D-086, D-119). Modèle TLA+ : le téléphone, les envois en attente (FL-12) et le ménage des 24 h (FL-14) se croisent (D-124).

```mermaid
stateDiagram-v2
    state "En attente, sur le téléphone (FL-12)" as attente
    state "Graine d'un brouillon, sur le serveur" as brouillon
    state "Rattachée" as rattachee
    [*] --> brouillon : F-044, F-046
    [*] --> attente : F-044, F-046 sans réseau ; F-058
    [*] --> rattachee : F-042 ; F-051 renvoie une graine effacée
    attente --> brouillon : FL-12
    attente --> rattachee : F-051 ; FL-12 pour F-058
    attente --> [*] : photo retirée, brouillon disparu, F-063
    brouillon --> rattachee : F-051
    brouillon --> [*] : photo retirée, F-005.a ; 24 h, FL-14 ; F-063
    rattachee --> [*] : FL-13 ; nouvelle photo de profil ; F-063
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| → Graine d'un brouillon | Photo choisie ou prise (F-044, F-046), avec réseau | Le serveur choisit l'algorithme et note l'heure d'arrivée (D-119, D-120, D-123) |
| → En attente | Même geste sans réseau ; nouvelle photo de profil (F-058) | Part par FL-12 (D-100, D-122) |
| En attente → Graine d'un brouillon | FL-12, quand le réseau revient | L'heure d'arrivée est celle où le serveur la reçoit (D-122, D-123) |
| En attente → Rattachée | F-051 ; FL-12 pour une photo de profil | Les graines qui attendent partent avec la publication (D-120) ; la photo de profil est enregistrée (D-100) |
| En attente → (abandonnée) | Photo retirée (F-044), brouillon fermé (F-005.a) ou perdu (appli fermée de force, téléphone éteint) ; F-063 | Jamais envoyée (D-121, D-122) ; abandonnée avec le compte (D-101) |
| Graine d'un brouillon → Rattachée | F-051 : le serveur enregistre le post ou la story | FL-14 ne l'efface plus (D-123) |
| Graine d'un brouillon → (effacée) | Photo retirée (F-044) ou « Fermer » (F-005.a) | Effacée aussitôt, ou par FL-12 sans réseau ; arrivé après FL-14, l'effacement est refusé pour de bon, sans message (D-113, D-121, D-122) |
| Graine d'un brouillon → (effacée) | 24 h après son arrivée, si rien ne l'a prise (FL-14) | Avec son algorithme (D-123) |
| → Rattachée | Photo envoyée dans un message (F-042) ; publication d'une graine qu'FL-14 a déjà effacée (F-051) | Le message porte la graine (D-086) ; la publication renvoie la graine (D-123) |
| Rattachée → (effacée) | Fin de la story (FL-13) ; nouvelle photo de profil enregistrée (F-058) ; F-063 | Effacée avec la story (D-110), à la place de l'ancienne photo (D-125), avec le compte (D-101) ; un post n'expire jamais (D-097) |

### SM-E-08 Notification

Pas de modèle TLA+.

```mermaid
stateDiagram-v2
    state "Non vue" as non_vue
    state "Vue" as vue
    [*] --> non_vue : F-016, F-030, F-034, F-051
    non_vue --> vue : P-04 ouvert, F-022
    non_vue --> [*] : like retiré, invitation répondue, post ou story effacé, F-063
    vue --> [*] : like retiré, invitation répondue, post ou story effacé, F-063
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| → Non vue | Like d'un post (F-016, D-055), commentaire (F-030, D-056), demande d'ami (F-034, D-070), identification (F-051, D-061) | Compte dans la pastille de la cloche (F-022, D-106) |
| Non vue → Vue | Ouverture du panneau P-04 (F-022) | Toutes les notifications du compte passent en vue ; la pastille disparaît (D-106) |
| Non vue ou Vue → (supprimée) | Like retiré (F-016) ; invitation acceptée ou refusée (F-028, F-028.a, D-070) ou demande croisée (F-034, D-073) ; F-063 de l'auteur ou du destinataire (D-101) ; post ou story effacé, story finie comprise (FL-13, D-148) | La ligne disparaît de P-04 |

### SM-E-09 Relation d'amitié

Entre deux comptes A et B. Modèle TLA+ : deux comptes agissent en même temps (demandes croisées, D-073).

```mermaid
stateDiagram-v2
    state "Aucune" as aucune
    state "Demandée : A demandé, B en attente" as demandee
    state "Amis" as amis
    [*] --> aucune
    aucune --> demandee : F-034 par A
    demandee --> amis : F-028 par B, ou F-034 par B
    demandee --> aucune : F-028.a par B
    amis --> amis : F-072, ami proche
    aucune --> [*] : F-063 de A ou B
    demandee --> [*] : F-063 de A ou B
    amis --> [*] : F-063 de A ou B
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| Aucune → Demandée | F-034 par A | « Demandé » chez A, « en attente » chez B ; notification « invitation » à B (D-070) |
| Demandée → Amis | F-028 par B, ou F-034 par B (demande croisée, D-073) | Conversation vide créée (D-071, SM-E-10) ; invitation supprimée (D-070) ; A n'est pas notifié (D-072) |
| Demandée → Aucune | F-028.a par B | Demande et invitation supprimées ; A revoit « Ajouter » et peut redemander (D-048) |
| Amis → Amis | F-072 | « Ami proche » oui ou non, chacun dans sa propre liste (D-060) |
| Tout état → (effacée) | F-063 de A ou de B | Relation, invitation et conversation effacées (D-101) |

Impossible aujourd'hui : annuler une demande, retirer un ami, bloquer un compte (question ouverte de F-034).

### SM-E-10 Conversation

Une par paire d'amis, avec « lu / non lu » pour chacun des deux (D-085). Pas de modèle TLA+.

```mermaid
stateDiagram-v2
    state "Lu, chez B" as lu
    state "Non lu, chez B" as non_lu
    [*] --> lu : amis, F-028 ou F-034
    lu --> non_lu : A envoie, F-041 ou F-042
    non_lu --> lu : B ouvre, F-037
    lu --> lu : reçu avec P-09 ouverte, F-038
    lu --> [*] : F-063 de A ou B
    non_lu --> [*] : F-063 de A ou B
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| → Lu des deux côtés | Les deux deviennent amis (SM-E-09) | Conversation vide, P-09.b (D-071) ; elle n'existe qu'entre amis (D-082) |
| Lu → Non lu, chez B | A envoie un message (F-041) ou une photo (F-042), P-09 de B fermée sur cette conversation | Dernier message et heure mis à jour ; gras et point bleu dans P-08 de B, sans notification (D-084, D-085) |
| Non lu → Lu, chez B | B ouvre la conversation (F-037) | D-085 |
| Lu → Lu, chez B | Message reçu pendant que B a P-09 ouverte (F-038) | Le message s'ajoute en bas (D-085) |
| Tout état → (effacée) | F-063 de A ou de B | Disparaît aussi de P-08 de l'autre (D-101) |

### SM-E-12 Story

Même brouillon que SM-E-03 jusqu'à F-051. Dans « En cours », chaque ami qui peut la voir (D-080) a son propre « vue / non vue » (D-078). Modèle TLA+ : la fin à 24 h croise « vue par », renvoyé plus tard sans message.

```mermaid
stateDiagram-v2
    state "Brouillon, sur le téléphone" as brouillon
    state "En publication (P-13.a)" as en_publication
    state "Échec (P-13.b)" as echec
    state "Finie" as finie
    brouillon --> en_publication : F-051, Story
    en_publication --> echec : refusé ou réseau
    echec --> en_publication : Réessayer, F-051
    en_publication --> en_cours : enregistrée
    state "En cours, 24 h" as en_cours {
        state "Non vue, pour un ami" as non_vue
        state "Vue, pour cet ami" as vue
        [*] --> non_vue
        non_vue --> vue : P-10 fermé, F-036
    }
    en_cours --> finie : 24 h écoulées, FL-13
    en_cours --> [*] : F-063 de l'auteur
    finie --> [*] : effacée tout de suite, FL-13
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| Brouillon → En publication | F-051, destination « Story » (F-068) | Images, texte, audience, personnes identifiées et lieu viennent du brouillon (D-059, D-068) |
| En publication → En cours | Le serveur enregistre | Fondu P-13.c (D-120), puis P-08.b (D-031) ; fin = publication + 24 h (D-079) |
| En publication → Échec, et retour | Comme SM-E-03 | P-13.b, « Réessayer » (D-027) |
| Non vue → Vue, pour un ami | Il ferme P-10 (croix ou fin) après au moins une image affichée (F-036) | Cercle gris tout de suite sur son téléphone, renvoyé sans message au serveur (D-078) ; P-10.b sans image la laisse non vue |
| En cours → Finie | 24 h écoulées (tâche de fond, FL-13) | Plus de rond ni de cercle, ne se rouvre plus ; ouverte juste après, P-10.b (D-079) |
| En cours ou Finie → (effacée) | F-063 de l'auteur | D-101 ; une story finie n'attend pas : la tâche de FL-13 l'efface dès sa fin, images et « vue par » (D-110) |

### SM-E-14 Minuteur de couleur

Un par compte (D-074). Il garde les cycles écoulés (0 à 10), le temps passé dans le cycle en cours et la durée du cycle ; le gris vaut 10 % par cycle écoulé. Modèle TLA+ : plusieurs téléphones (D-105) et réglages renvoyés (D-077).

```mermaid
stateDiagram-v2
    state "Arrêté" as arrete
    state "En marche" as en_marche
    state "Noir et blanc" as noir_blanc
    [*] --> arrete : F-070
    arrete --> en_marche : appli au premier plan
    en_marche --> arrete : plus aucun téléphone au premier plan
    en_marche --> en_marche : cycle fini, F-024
    en_marche --> noir_blanc : 10e cycle fini
    noir_blanc --> en_marche : F-061
    en_marche --> en_marche : F-060, F-061
    arrete --> [*] : F-063
    en_marche --> [*] : F-063
    noir_blanc --> [*] : F-063
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| Arrêté → En marche | Un téléphone connecté a l'appli ouverte et au premier plan (F-024) | Reprend où il en était, au même gris, sur tout téléphone (D-074) |
| En marche → Arrêté | Plus aucun téléphone au premier plan : appli fermée, en arrière-plan ou déconnectée (F-071) | Temps passé gardé sur le serveur (D-074, D-075) |
| En marche → En marche | Chaque seconde où au moins un téléphone est au premier plan | Temps passé + 1 s, une seule fois même avec deux téléphones (D-075, D-105), sauf une période arrivée plus de 7 jours après sa fin (D-147) ; sans réseau aussi, renvoyé par FL-12 (D-117) |
| En marche → En marche, cycle fini | Le temps passé atteint la durée, moins de 9 cycles écoulés | Cycles + 1, 10 % de gris en plus, temps remis à 0 (F-024) |
| En marche → Noir et blanc | Le 10e cycle finit | Le minuteur s'arrête ; F-059 dit « Noir et blanc. Réinitialise pour retrouver les couleurs. » |
| Tout état → En marche, cycle 1 | F-061 « Réinitialiser » (sur P-17, donc appli ouverte) | 0 cycle écoulé, 0 % de gris ; appliqué sur le téléphone, renvoyé sans message (D-077) |
| Même état | F-060, nouvelle durée | Cycles gardés, la durée vaut pour la suite (D-076, D-077) |
| Tout état → (effacé) | F-063 | D-101 |

### SM-E-16 Soutien

Un par compte (D-092). Modèle TLA+ : le store, le serveur, le renvoi sans message (D-095) et plusieurs téléphones se croisent.

```mermaid
stateDiagram-v2
    state "Non soutenu" as non_soutenu
    state "Paiement en cours, store" as paiement
    state "Soutenu, pas encore enregistré" as a_enregistrer
    state "Soutenu" as soutenu
    [*] --> non_soutenu : F-070
    non_soutenu --> paiement : F-015 ou F-015.a, 1 h atteinte
    paiement --> non_soutenu : échec ou annulation
    paiement --> a_enregistrer : le store confirme
    a_enregistrer --> soutenu : le serveur enregistre
    non_soutenu --> [*] : F-063
    a_enregistrer --> [*] : F-063
    soutenu --> [*] : F-063
```

| Passage | Déclencheur | Effet et décisions |
| --- | --- | --- |
| Non soutenu → Paiement en cours | « Soutenir le projet » (F-015 sur P-22, F-015.a dans le fil) | Seulement quand E-15 atteint 1 h (D-005, D-093, D-105) |
| Paiement en cours → Non soutenu | Paiement échoué ou annulé, rien débité | P-22.a ou P-03.c (D-027) ; P-22.b (D-036) |
| Paiement en cours → Soutenu, pas encore enregistré | Le store confirme l'achat | « Merci pour ton soutien. » tout de suite (D-094, D-095) |
| Soutenu, pas encore enregistré → Soutenu | Le serveur enregistre l'achat | Renvoyé sans message à chaque ouverture jusque-là (D-095), pour ce compte seulement, même après F-071 (D-104) ; un seul soutien enregistré par compte (D-115) |
| Tout état → (effacé) | F-063 | Un achat pas encore enregistré est abandonné, sur ce téléphone ou un autre (D-116) ; un nouveau compte repart non soutenu (D-101) |

Ouverts dans F-015 : remboursement, achat en attente, second achat fait sur un autre téléphone avant que le premier soit enregistré (D-115).

### Modèles TLA+

Choisis par D-107 et D-124, écrits dans le dépôt sous `docs/system-design/` (un fichier `.tla` et son `.cfg` par modèle) et vérifiés par le model checker TLC dans la CI à chaque changement. Chaque règle porte pour l'instant le nom des décisions d'où elle vient ; elle prendra le nom de sa règle métier (`BR_xxx`) quand celle-ci sera écrite, à l'étape 7 ou dans la spec de sa feature (étape 10). Les bornes sont petites (2 ou 3 comptes ou téléphones, quelques secondes), assez pour croiser chaque ordre d'événements ; les horloges des téléphones sont supposées à l'heure, ce que D-140 assure en les corrigeant par l'heure du serveur.

| Modèle | Fichier | Règles vérifiées |
| --- | --- | --- |
| SM-E-04 | `SM_E_04.tla` | `D120_D123_PublishedHasArt` : un post ou une story publié a toujours ses graines, même si FL-14 les avait effacées avant (D-120, D-123) ; `D121_AbandonedNeverAttached`, `D121_AbandonedEndsErased`, `D121_ErasedStaysErased` : une photo retirée ou d'un brouillon perdu n'est jamais rattachée, finit effacée et ne revient pas (D-121, D-122, D-123) ; `D122_DroppedNeverSent`, `D122_EraseNeverHitsPublished` (D-121, D-122) ; `D123_NoOrphanForever` : aucune graine ne reste sur le serveur sans rien qui la prenne (D-123) ; `D125_OneProfilePhoto`, `D100_D125_ProfileIsCurrent`, `D100_ProfileQueueEnds` : le serveur garde une seule graine de photo de profil, celle du téléphone une fois tout envoyé (D-100, D-125) ; `D101_NothingAfterDeletion` (D-101) |
| SM-E-09 | `SM_E_09.tla` | `D073_NoCrossedRequests`, `D073_NoRequestBetweenFriends` : jamais deux demandes en attente dans les deux sens, ni entre amis (D-073) ; `D070_InvitationWhileRequest` : l'invitation existe tant que la demande attend (D-070) ; `D071_D082_ConversationIffFriends` : une conversation existe si et seulement si les deux comptes sont amis (D-071, D-082) ; `D060_CloseFriendIsFriend` : un ami proche est toujours un ami (D-060) ; `D101_NothingLeftOfDeleted` (D-101) |
| SM-E-12 | `SM_E_12.tla` | `D079_FinishedNeverReopens` : une story finie ne se rouvre jamais, même si « vue » arrive après (D-078, D-079) ; `D080_OpensOnlyForAudience` : seuls les amis, et les amis proches pour « Amis proches », l'ouvrent (D-080) ; `D078_SeenOnlyAfterAnImage` (D-078) ; `D110_ErasedKeepsNothing`, `D110_FinishedIsErased` (D-110) ; `D101_DeletedViewerLeavesNothing` (D-101, D-109) ; `D113_WaitingVueEnds` : une « vue » en attente finit enregistrée ou abandonnée (D-108, D-113) |
| SM-E-14 | `SM_E_14.tla` | `D024_GreyTenPercentPerCycle` : 10 % de gris par cycle écoulé, 10 cycles au plus (F-024) ; `D105_SecondCountedOnce`, `D105_D117_UsageIsForegroundTime` : deux téléphones ne font jamais compter une seconde deux fois (hors du modèle : une période arrivée plus de 7 jours après sa fin compte en entier, D-147), et le temps d'utilisation (E-15) finit égal aux secondes où au moins un téléphone était au premier plan, sans réseau compris (D-105, D-117) ; `D111_LatestChangeWins` : le réglage fait le plus tard gagne, quel que soit l'ordre d'arrivée (D-111, D-117) ; `D077_D117_EverythingEndsRecorded` : réglages et secondes renvoyés finissent enregistrés (D-077, D-117) |
| SM-E-16 | `SM_E_16.tla` | `D095_NoErrorAfterDebit` : aucune erreur après un débit (D-095) ; `D115_RecordedOnce` : le serveur n'enregistre qu'un soutien par compte (D-092, D-115) ; `D092_SupportedOnlyIfPaid` ; `D095_D116_PaidEndsRecorded` : un achat confirmé finit enregistré, pour son compte seulement, sauf si le compte est supprimé (D-095, D-104, D-116) |
| Synchronisation | `sync.tla` | `D104_NeverForAnotherAccount` (D-104) ; `D101_NothingKeptForDeleted`, `D101_NothingAfterDeletion` (D-101) ; `D116_SupportDroppedOnlyWithAccount` (D-113, D-116) ; `D122_RecordedOrDropped` : un envoi finit enregistré ou abandonné, jamais les deux ; une graine dont le brouillon a disparu est abandonnée sans partir (D-113, D-121, D-122) ; `D108_SentWhileConnected` : un envoi en attente part dès que son compte est connecté sur le téléphone (D-104, D-108, D-112) ; `D101_DeletedAccountChangesEnd` : ceux d'un compte supprimé finissent abandonnés, même sur un téléphone où il n'est plus connecté (D-101, D-116). Le temps entre téléphones est vérifié par SM-E-14 |

Trouvé par TLC le 25 novembre 2026 : un soutien que le store confirme après la suppression du compte sur un autre téléphone est débité, puis abandonné (D-116) ; son remboursement rejoint la question ouverte de F-015. Un téléphone dont l'horloge est fausse pouvait faire gagner un réglage plus ancien (D-111) : réglé le 26 novembre 2026, le téléphone corrige son heure par celle du serveur (D-140).

## Exigences non fonctionnelles

Les exigences de toute l'appli (étape 7 de la méthode), chacune avec un nombre ou un test et sa source. L'appli n'a pas de page transversale à part : elles vivent ici, en `NFR-X-<n>`. Plateformes : iOS et Android (D-092) ; une exigence qui diffère selon la plateforme le dit. Aucune exigence propre à une seule feature pour l'instant.

### Confidentialité

| ID | Exigence | Nombre ou test | Source |
| --- | --- | --- | --- |
| NFR-X-1 | Aucun texte écrit par un utilisateur ne quitte le téléphone : légende, commentaire, message, pseudo et description partent en charabia ; une recherche n'envoie que sa graine (D-139). Seuls l'identifiant (@), l'adresse e-mail de connexion et le lieu tapé (F-049, D-157) partent lisibles. | Test de bout en bout : un texte repère tapé dans chaque champ n'apparaît dans aucune requête captée, aucun journal ni aucun rapport de plantage. | D-083, D-087, D-098, D-118 |
| NFR-X-2 | Aucune photo ni vidéo ne quitte le téléphone : seule sa graine part. | Même capture : aucune requête n'a un corps image ou vidéo, ni les octets de la photo choisie. | D-086, D-091, D-119 |
| NFR-X-3 | Les préférences d'interface (E-17) et l'état de la recherche (E-13, sans historique, D-089) ne quittent jamais le téléphone. | Même capture, pendant un changement de thème sur P-23 et une recherche sur P-14 : aucune requête ne les porte. | D-087, D-089, D-103 |
| NFR-X-4 | Un compte supprimé n'est plus dans aucun stockage du serveur dès la réponse de F-063, sauf son numéro interne, gardé seul 7 jours (D-128, FL-15), et plus nulle part, sauvegardes comprises, 7 jours après. | Test d'intégration : un compte avec une ligne dans chaque entité est supprimé, puis son numéro interne est cherché dans chaque table : 0 ligne, hors de la liste des comptes supprimés ; 7 jours après, 0 ligne là aussi. Configuration : sauvegardes gardées 7 jours au plus ; une sauvegarde restaurée efface les comptes supprimés depuis. | D-101, D-102, D-128 |
| NFR-X-5 | L'appli ne parle qu'à son serveur, aux services qu'un flow exige (Google, Apple, store, envoi du code) et au service de rapports de plantage. Un rapport de plantage ne porte aucun contenu, texte tapé, graine, identifiant de compte ni adresse e-mail. | Capture : la liste des hôtes contactés pendant le test de bout en bout ne contient que ceux-là. Un plantage provoqué en test donne un rapport sans aucune de ces données. | D-129 |

### Sécurité

| ID | Exigence | Nombre ou test | Source |
| --- | --- | --- | --- |
| NFR-X-6 | Tous les échanges passent en HTTPS, TLS 1.2 ou plus ; aucune connexion en clair, sur iOS (App Transport Security sans exception) comme sur Android (trafic en clair interdit). | Lint de la configuration des deux applis ; la capture ne trouve aucune requête en clair. | Contrainte des plateformes |
| NFR-X-7 | Le serveur vérifie les droits à chaque requête : un compte ne lit jamais un post, une story, une conversation ou un message hors de son audience ou de ses amitiés, ni rien après la fermeture de sa session ou la suppression de son compte. | Test d'autorisation de chaque point d'entrée avec un compte non ami, un ami hors « Amis proches », une session fermée et un compte supprimé : refus à chaque fois. | D-024, D-080, D-082, D-088, D-101 |
| NFR-X-8 | Le code de connexion a 6 chiffres, vaut 10 min et ne marche plus après 5 essais faux ; un nouveau code se demande après 30 s et remplace le précédent. | Tests du serveur : code accepté à 9 min 59 s, refusé à 10 min ; le bon code est refusé au 6e essai après 5 faux ; après un renvoi, l'ancien code est refusé. | FL-01, F-008, D-127, D-131 |
| NFR-X-9 | La session est gardée dans le stockage sécurisé du téléphone (Trousseau sur iOS, Keystore sur Android), jamais en clair ; le serveur la refuse dès l'échange suivant une déconnexion ou une suppression du compte. | Revue du code de stockage ; test du serveur : une session fermée ou d'un compte supprimé reçoit un refus et l'appli ouvre P-01. | D-053, D-101, contrainte des plateformes |

### Rapidité

Mesurée sur les téléphones de référence de D-126 (iPhone 12 sous iOS, Samsung Galaxy A52 sous Android), en 4G.

| ID | Exigence | Nombre ou test | Source |
| --- | --- | --- | --- |
| NFR-X-10 | De l'appui sur l'icône au premier post du fil affiché, appli fermée, session ouverte. | 2 s au plus au 90e centile, sur iOS et sur Android ; 20 lancements mesurés sur appareil réel. | D-126 |
| NFR-X-11 | Posts suivants du fil (F-009) affichés après l'arrivée en bas. | 0,5 s au plus au 95e centile sur le téléphone ; banc de mesure du point d'entrée du fil à chaque pull request qui le touche. | D-126 |
| NFR-X-12 | Message d'un ami affiché sur P-09 ou P-08 après son envoi, les deux téléphones en ligne (D-084). | 2 s au plus au 95e centile ; test de bout en bout à deux téléphones. | D-126 |
| NFR-X-13 | Défilement du fil et de P-09, art généré compris. | 60 images par seconde, moins de 1 % d'images manquées sur 30 s de défilement ; dessiner l'art d'un média prend 16 ms au plus (une image). | D-119, D-126 |

### Accessibilité

Sur iOS et sur Android. Le gris (F-024), le charabia (D-118) et l'art généré (D-086) restent tels quels.

| ID | Exigence | Nombre ou test | Source |
| --- | --- | --- | --- |
| NFR-X-14 | Chaque bouton, champ et lien a un nom accessible, fixé dans le contrat de sa page (`nom_accessible`), lu par VoiceOver et TalkBack. | Lint là où c'est possible ; la commande `app` des tests trouve chaque élément par son nom, avec Maestro (D-143) ; audit d'accessibilité automatique de chaque page : 0 élément sans nom. | D-130, méthode (verification.md) |
| NFR-X-15 | Zones à toucher assez grandes. | 44 × 44 pt au moins sur iOS, 48 × 48 dp au moins sur Android ; audit automatique de chaque page. | D-130, consignes des plateformes |
| NFR-X-16 | Les textes de l'appli elle-même suivent la taille de texte du téléphone et restent lisibles à chaque niveau de gris. | Jusqu'à 200 % sans texte coupé ni chevauché ; contraste 4,5:1 au moins (3:1 en grand texte) ; audit à 100 % et 200 %, à 0 et à 10 cycles de gris. | D-130 |
| NFR-X-17 | Si le téléphone demande moins d'animations, rien ne bouge seul : le fondu de la publication (D-120) devient un changement net et l'art généré des vidéos reste immobile, comme Inspire / Expire (F-014). | Test de bout en bout, réglage du téléphone activé : aucune animation pendant une publication et sur un post vidéo. | D-130 |

## Serveur, téléphone et API

Le serveur décide de tout ce que plusieurs comptes ou plusieurs téléphones partagent ; le téléphone fait ce qui ne doit pas le quitter ou doit marcher sans réseau (D-136). L'appli parle au serveur par une API HTTPS en 10 groupes, et par une connexion WebSocket pour le direct (D-137). C'est la réponse au prompt 6 de la méthode, sur la pile choisie par D-132 à D-135.

### Qui fait quoi

| Sujet | Téléphone | Serveur | Source |
| --- | --- | --- | --- |
| Textes écrits | Les change en charabia avant l'envoi | Ne garde que le charabia | D-118, NFR-X-1 |
| Photos et vidéos | Tire la graine, dessine l'art | Garde la graine, choisit l'algorithme | D-086, D-119, NFR-X-2 |
| Recherche | Change le texte en graine, garde E-13, tire les suggestions | Renvoie jusqu'à 18 posts visibles, les plus proches de la graine | D-088, D-089, D-139 |
| Préférences d'interface (E-17) | Les garde et les applique | Ne les connaît pas | D-103, NFR-X-3 |
| Fil | Place les carrousels de pause (F-012.a), les posts Inspire / Expire (F-014) et le post Premium (F-015.a) | Compose les posts selon l'audience, par pages de 8 ; dit si le post Premium est à proposer | D-088, D-094, D-136 |
| Likes, commentaires, enregistrements, partages | Montre le changement tout de suite, revient en arrière si le serveur refuse | Vérifie le droit, tient les compteurs, écrit les notifications | D-055, D-056, D-138, NFR-X-7 |
| Connexion | Garde la session dans le stockage sécurisé | Envoie et vérifie le code, vérifie le compte Google ou Apple, ouvre et ferme les sessions | D-131, D-135, NFR-X-8, NFR-X-9 |
| Amis, conversations, messages | Affiche ; signale « en train d'écrire » | Tient amitiés, conversations et lu / non lu ; pousse les messages en direct | D-071, D-084, D-085 |
| Stories | Lecteur ; « vue » en attente si le serveur ne répond pas | Audience, liste « vue par », fin à 24 h (FL-13) | D-078, D-080, D-110 |
| Minuteur et temps d'utilisation | Compte les secondes et grise, même sans réseau ; corrige son heure par celle du serveur | Fusionne les secondes et les réglages des téléphones du compte | D-105, D-111, D-117, D-140 |
| Soutien | Lance l'achat du store et envoie sa preuve | Vérifie l'achat auprès du store, l'enregistre une seule fois | D-092, D-095, D-115 |
| Brouillon et envois en attente | Brouillon en mémoire ; envois en attente dans SQLite (FL-12) | Enregistre, ou refuse pour de bon | D-068, D-113, D-135 |
| Tâches de fond | Aucune | Finir les stories (FL-13), effacer les graines orphelines (FL-14), oublier les comptes supprimés (FL-15), les connexions inachevées (FL-16) et les vieilles périodes au premier plan (FL-17) | D-110, D-123, D-128, D-147, D-149 |
| Version de l'appli | Montre P-29 si elle est trop vieille (F-074) | Dit quelles versions il accepte encore | D-141 |

### Groupes de l'API

Chaque point d'entrée appartient à une seule feature ; ses types sont dans le paquet partagé par l'appli et le serveur (D-133). Le détail de chaque point d'entrée vient avec les contrats de page et la spec de sa feature.

| Groupe | Ce qu'il porte | Flows | Features | Entités |
| --- | --- | --- | --- | --- |
| Connexion | Compte tiers, demande, vérification et renvoi du code, inscription, déconnexion | FL-01, FL-11 | F-001, F-003, F-007, F-008, F-070, F-071 | E-01, E-02 |
| Fil et posts | Pages du fil, post d'un lien, likes, commentaires, collections, partages, publication | FL-02, FL-03 | F-009, F-016, F-017, F-018, F-019, F-030, F-031, F-051 | E-03, E-05, E-06, E-07 |
| Médias | Arrivée et effacement des graines, algorithme d'art de chaque média | FL-03, FL-12, FL-14 | F-005, F-044, F-046 | E-04 |
| Amis et notifications | Recherche de comptes, demandes et réponses, amis proches, notifications | FL-03, FL-04 | F-022, F-028, F-034, F-043, F-048, F-072 | E-08, E-09 |
| Minuteur et temps | Minuteur du compte, réglages, secondes passées au premier plan | FL-05, FL-09, FL-12 | F-024, F-059, F-060, F-061, F-065, F-073 | E-14, E-15 |
| Stories | Stories en cours des amis, « vue » | FL-06, FL-13 | F-036 | E-12 |
| Messages | Discussions, messages, photo, lu ; le direct passe par WebSocket | FL-07 | F-037, F-038, F-040, F-041, F-042 | E-10, E-11 |
| Recherche | Résultats pour une graine, nombres des tendances | FL-08 | F-052, F-053, F-054 | E-03 |
| Soutien | Preuve d'achat du store, état « soutenu » | FL-09 | F-015 | E-16 |
| Profil et compte | Profil, ses posts, pseudo et description, photo, suppression du compte | FL-11, FL-15 | F-056, F-057, F-058, F-062, F-063 | E-01, E-03, E-04 |

Les lieux (F-049) n'ont pas de groupe à eux : tapés librement (D-157), ils partent avec le post ou la story.

### Règles communes

- Session : un jeton opaque, gardé par le serveur, envoyé à chaque requête ; le serveur le refuse dès la déconnexion ou la suppression du compte (NFR-X-9).
- Écritures : chacune porte un numéro fait par le téléphone ; un « Réessayer » ou un renvoi de FL-12 avec le même numéro n'est jamais enregistré deux fois (D-115).
- Listes : elles arrivent par pages, 8 posts pour le fil (F-009), 18 résultats au plus pour une recherche (D-139).
- Erreurs : chaque erreur dit si l'envoi peut repartir, ou s'il est refusé pour de bon (D-113).
- Heure : chaque réponse porte l'heure du serveur, dont le téléphone tire son écart (D-140).
- Versions : chaque requête porte la version de l'API ; le serveur garde une version tant qu'une appli acceptée s'en sert, et une appli trop vieille ouvre P-29 (D-141).
- Direct : la connexion WebSocket, ouverte tant que l'appli est au premier plan, ne porte que le message reçu et « en train d'écrire » ; envoyer un message passe par l'API (D-084, D-133).

Restent ouverts, dans les `questions_ouvertes` des features : F-009, quels posts montre le fil et dans quel ordre ; F-052, la règle de la recherche par graine ; F-053, ce que comptent les tendances.

## Modèle de données

33 tables, TB-01 à TB-33, dans trois stockages : la base PostgreSQL du serveur (N-01, D-134), la base SQLite du téléphone (N-02, D-135, D-150) et son stockage sécurisé (N-03). Les stockages sont des nœuds de la section « Flux de données ». Les règles du modèle sont dans D-144 : l'id de ce que crée un geste est fait par le téléphone, tout ce qui vient d'un compte s'efface avec lui, et les compteurs sont comptés à la demande. C'est la réponse au prompt 11 de la méthode.

### Tables

```yaml
tables:
  - id: TB-01
    nom: comptes
    type: table
    stockage: N-01
    entite: E-01
    raison: Un compte par ligne ; son id est le numéro interne du compte (D-102).
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: identifiant, type: text, cle: unique, reference: '', obligatoire: true}
      - {nom: pseudo, type: text, cle: '', reference: '', obligatoire: true}
      - {nom: description, type: text, cle: '', reference: '', obligatoire: false}
    index: []

  - id: TB-02
    nom: identites
    type: table
    stockage: N-01
    entite: E-02
    raison: Comment on se connecte à un compte, par Google, Apple ou e-mail (F-001, F-003).
    colonnes:
      - {nom: fournisseur, type: "enum fournisseur ('google', 'apple', 'email')", cle: primaire, reference: '', obligatoire: true}
      - {nom: cle, type: text, cle: primaire, reference: '', obligatoire: true}
      - {nom: compte_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
    index: [compte_id]

  - id: TB-03
    nom: codes_connexion
    type: table
    stockage: N-01
    entite: E-02
    raison: Le dernier code envoyé à une adresse, seul valable (D-131) ; effacé quand il est bon, sinon par FL-16 1 h après l'envoi (D-149).
    colonnes:
      - {nom: adresse_email, type: citext, cle: primaire, reference: '', obligatoire: true}
      - {nom: code_hash, type: bytea, cle: '', reference: '', obligatoire: true}
      - {nom: envoye_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
      - {nom: essais_faux, type: smallint, cle: '', reference: '', obligatoire: true}
    index: [envoye_le]

  - id: TB-04
    nom: inscriptions
    type: table
    stockage: N-01
    entite: E-02
    raison: L'état « Inscription » de SM-E-02, entre le bon code ou le compte Google ou Apple et F-070 ; effacée par F-070, sinon par FL-16 1 h après (D-149).
    colonnes:
      - {nom: jeton_hash, type: bytea, cle: primaire, reference: '', obligatoire: true}
      - {nom: fournisseur, type: enum fournisseur, cle: '', reference: '', obligatoire: true}
      - {nom: cle, type: text, cle: '', reference: '', obligatoire: true}
      - {nom: cree_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: [cree_le]

  - id: TB-05
    nom: sessions
    type: table
    stockage: N-01
    entite: E-02
    raison: Une session ouverte par téléphone (D-053) ; le jeton n'est gardé que haché (NFR-X-9).
    colonnes:
      - {nom: jeton_hash, type: bytea, cle: primaire, reference: '', obligatoire: true}
      - {nom: compte_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
    index: [compte_id]

  - id: TB-06
    nom: posts
    type: table
    stockage: N-01
    entite: E-03
    raison: Un post du fil publié (SM-E-03, Publié) ; brouillon, publication en cours et échec restent sur le téléphone, en mémoire (D-135).
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: auteur_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: legende, type: text, cle: '', reference: '', obligatoire: false}
      - {nom: audience, type: "enum audience ('tout_le_monde', 'amis', 'amis_proches')", cle: '', reference: '', obligatoire: true}
      - {nom: lieu, type: varchar(60), cle: '', reference: '', obligatoire: false}
      - {nom: publie_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: ['(auteur_id, publie_le)', publie_le]

  - id: TB-07
    nom: medias
    type: table
    stockage: N-01
    entite: E-04
    raison: Une graine et son algorithme par photo ou vidéo (D-086, D-119), rattachée à au plus une chose ; sans rattachement, c'est la graine d'un brouillon de SM-E-04.
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: compte_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: graine, type: bytea, cle: '', reference: '', obligatoire: true}
      - {nom: algorithme, type: jsonb, cle: '', reference: '', obligatoire: true}
      - {nom: duree_video_ms, type: integer, cle: '', reference: '', obligatoire: false}
      - {nom: rang, type: smallint, cle: '', reference: '', obligatoire: false}
      - {nom: arrivee_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
      - {nom: post_id, type: uuid, cle: '', reference: TB-06.id, obligatoire: false}
      - {nom: story_id, type: uuid, cle: '', reference: TB-19.id, obligatoire: false}
      - {nom: message_id, type: uuid, cle: '', reference: TB-18.id, obligatoire: false}
      - {nom: profil_de, type: uuid, cle: unique, reference: TB-01.id, obligatoire: false}
    index: [compte_id, '(post_id, rang)', '(story_id, rang)', message_id, 'arrivee_le, sans rattachement']

  - id: TB-08
    nom: commentaires
    type: table
    stockage: N-01
    entite: E-05
    raison: Un commentaire d'un post (F-030).
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: post_id, type: uuid, cle: '', reference: TB-06.id, obligatoire: true}
      - {nom: auteur_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: texte, type: text, cle: '', reference: '', obligatoire: true}
      - {nom: publie_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: ['(post_id, publie_le)', auteur_id]

  - id: TB-09
    nom: likes_posts
    type: table
    stockage: N-01
    entite: E-06
    raison: Un like d'un post (F-016) ; un seul par compte et par post.
    colonnes:
      - {nom: post_id, type: uuid, cle: primaire, reference: TB-06.id, obligatoire: true}
      - {nom: auteur_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: like_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: [auteur_id]

  - id: TB-10
    nom: likes_commentaires
    type: table
    stockage: N-01
    entite: E-06
    raison: Un like d'un commentaire (F-016) ; un seul par compte et par commentaire.
    colonnes:
      - {nom: commentaire_id, type: uuid, cle: primaire, reference: TB-08.id, obligatoire: true}
      - {nom: auteur_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: like_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: [auteur_id]

  - id: TB-11
    nom: collections
    type: table
    stockage: N-01
    entite: E-07
    raison: Une collection d'un compte (F-031).
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: compte_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: nom, type: text, cle: '', reference: '', obligatoire: true}
      - {nom: couleur, type: text, cle: '', reference: '', obligatoire: true}
    index: [compte_id]

  - id: TB-12
    nom: enregistrements
    type: table
    stockage: N-01
    entite: E-07
    raison: Les posts enregistrés d'une collection ; la clé (compte_id, post_id) met un post dans une collection au plus (D-057).
    colonnes:
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: post_id, type: uuid, cle: primaire, reference: TB-06.id, obligatoire: true}
      - {nom: collection_id, type: uuid, cle: '', reference: TB-11.id, obligatoire: true}
    index: [post_id, collection_id]

  - id: TB-13
    nom: identifications_posts
    type: table
    stockage: N-01
    entite: E-03
    raison: Les personnes identifiées dans un post (F-048).
    colonnes:
      - {nom: post_id, type: uuid, cle: primaire, reference: TB-06.id, obligatoire: true}
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
    index: [compte_id]

  - id: TB-14
    nom: notifications
    type: table
    stockage: N-01
    entite: E-08
    raison: Une notification reçue (SM-E-08) ; effacée avec son post ou sa story (D-148), quand le like est retiré ou l'invitation répondue (D-070).
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: destinataire_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: auteur_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: type, type: "enum type_notification ('like', 'commentaire', 'invitation', 'identification')", cle: '', reference: '', obligatoire: true}
      - {nom: post_id, type: uuid, cle: '', reference: TB-06.id, obligatoire: false}
      - {nom: story_id, type: uuid, cle: '', reference: TB-19.id, obligatoire: false}
      - {nom: vue, type: boolean, cle: '', reference: '', obligatoire: true}
      - {nom: cree_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: ['(destinataire_id, cree_le)', auteur_id, post_id, story_id]

  - id: TB-15
    nom: amities
    type: table
    stockage: N-01
    entite: E-09
    raison: Une demande ou une amitié entre deux comptes (SM-E-09) ; « Aucune » est l'absence de ligne ; une seule ligne par paire, dans un sens ou dans l'autre (D-073).
    colonnes:
      - {nom: demandeur_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: destinataire_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: statut, type: "enum statut_amitie ('demandee', 'amis')", cle: '', reference: '', obligatoire: true}
    index: [destinataire_id, 'unique (least, greatest) des deux comptes']

  - id: TB-16
    nom: amis_proches
    type: table
    stockage: N-01
    entite: E-09
    raison: La liste d'amis proches de chaque compte (D-060), toujours celle du moment (D-146).
    colonnes:
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: ami_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
    index: [ami_id]

  - id: TB-17
    nom: conversations
    type: table
    stockage: N-01
    entite: E-10
    raison: Une conversation par paire d'amis (D-071, D-082), avec « lu » pour chacun des deux (D-085) ; compte_a est le plus petit des deux id.
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: compte_a, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: compte_b, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: lu_par_a, type: boolean, cle: '', reference: '', obligatoire: true}
      - {nom: lu_par_b, type: boolean, cle: '', reference: '', obligatoire: true}
    index: ['unique (compte_a, compte_b)', compte_b]

  - id: TB-18
    nom: messages
    type: table
    stockage: N-01
    entite: E-11
    raison: Un message d'une conversation (F-041, F-042, F-019.a).
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: conversation_id, type: uuid, cle: '', reference: TB-17.id, obligatoire: true}
      - {nom: expediteur_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: texte, type: text, cle: '', reference: '', obligatoire: false}
      - {nom: message_cite_id, type: uuid, cle: '', reference: TB-18.id, obligatoire: false}
      - {nom: post_partage_id, type: uuid, cle: '', reference: TB-06.id, obligatoire: false}
      - {nom: envoye_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: ['(conversation_id, envoye_le)', post_partage_id]

  - id: TB-19
    nom: stories
    type: table
    stockage: N-01
    entite: E-12
    raison: Une story en cours (SM-E-12) ; FL-13 l'efface dès sa fin (D-110).
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: auteur_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
      - {nom: texte, type: text, cle: '', reference: '', obligatoire: false}
      - {nom: audience, type: enum audience, cle: '', reference: '', obligatoire: true}
      - {nom: lieu, type: varchar(60), cle: '', reference: '', obligatoire: false}
      - {nom: publiee_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: [auteur_id, publiee_le]

  - id: TB-20
    nom: vues_stories
    type: table
    stockage: N-01
    entite: E-12
    raison: La liste « vue par » d'une story (D-078) ; pas de ligne = non vue pour cet ami.
    colonnes:
      - {nom: story_id, type: uuid, cle: primaire, reference: TB-19.id, obligatoire: true}
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
    index: [compte_id]

  - id: TB-21
    nom: identifications_stories
    type: table
    stockage: N-01
    entite: E-12
    raison: Les personnes identifiées dans une story (F-048, D-059).
    colonnes:
      - {nom: story_id, type: uuid, cle: primaire, reference: TB-19.id, obligatoire: true}
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
    index: [compte_id]

  - id: TB-22
    nom: minuteurs
    type: table
    stockage: N-01
    entite: E-14
    raison: Le minuteur de couleur du compte (D-074), fusionné entre ses téléphones (D-105, D-111, D-117).
    colonnes:
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: duree_cycle_s, type: integer, cle: '', reference: '', obligatoire: true}
      - {nom: temps_cycle_s, type: integer, cle: '', reference: '', obligatoire: true}
      - {nom: cycles_ecoules, type: smallint, cle: '', reference: '', obligatoire: true}
      - {nom: duree_changee_le, type: timestamptz, cle: '', reference: '', obligatoire: false}
      - {nom: reinitialise_le, type: timestamptz, cle: '', reference: '', obligatoire: false}
    index: []

  - id: TB-23
    nom: periodes_premier_plan
    type: table
    stockage: N-01
    entite: E-15
    raison: Les périodes où au moins un téléphone du compte avait l'appli au premier plan, fusionnées sans chevauchement, pour compter chaque seconde une fois (D-105, D-117) ; gardées 7 jours, puis effacées par FL-17 (D-147). Servent aussi au minuteur (E-14).
    colonnes:
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: debut, type: timestamptz, cle: primaire, reference: '', obligatoire: true}
      - {nom: fin, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: [fin]

  - id: TB-24
    nom: temps_utilisation
    type: table
    stockage: N-01
    entite: E-15
    raison: Le temps d'utilisation cumulé du compte (D-093), qui reste après l'effacement des vieilles périodes.
    colonnes:
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: secondes, type: bigint, cle: '', reference: '', obligatoire: true}
    index: []

  - id: TB-25
    nom: soutiens
    type: table
    stockage: N-01
    entite: E-16
    raison: Le soutien du compte, créé non soutenu avec le compte (D-114) ; un seul achat enregistré par compte (D-115).
    colonnes:
      - {nom: compte_id, type: uuid, cle: primaire, reference: TB-01.id, obligatoire: true}
      - {nom: store, type: "enum store ('app_store', 'google_play')", cle: '', reference: '', obligatoire: false}
      - {nom: achat_store, type: text, cle: unique, reference: '', obligatoire: false}
    index: []

  - id: TB-26
    nom: comptes_supprimes
    type: table
    stockage: N-01
    entite: aucune
    raison: Liste des comptes supprimés de FL-15 (D-128) ; ne garde que le numéro interne et l'heure de la suppression, 7 jours ; pas d'entité, elle ne porte rien du compte (D-102).
    colonnes:
      - {nom: compte_id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: supprime_le, type: timestamptz, cle: '', reference: '', obligatoire: true}
    index: [supprime_le]

  - id: TB-27
    nom: envois_en_attente
    type: table
    stockage: N-02
    entite: aucune
    raison: La file des envois en attente de FL-12 (D-108, D-135), du plus ancien au plus récent ; chaque envoi porte un changement d'une entité (E-01, E-04, E-12, E-14, E-15, E-16), si bien que la file n'en est pas une.
    colonnes:
      - {nom: ordre, type: INTEGER, cle: primaire, reference: '', obligatoire: true}
      - {nom: compte_id, type: TEXT, cle: '', reference: '', obligatoire: true}
      - {nom: sorte, type: TEXT, cle: '', reference: '', obligatoire: true}
      - {nom: contenu, type: TEXT, cle: '', reference: '', obligatoire: true}
      - {nom: fait_le, type: TEXT, cle: '', reference: '', obligatoire: true}
    index: [compte_id]

  - id: TB-28
    nom: recherche
    type: table
    stockage: N-02
    entite: E-13
    raison: L'état de la recherche, une seule ligne, sans historique (D-089, D-135, D-139).
    colonnes:
      - {nom: id, type: INTEGER, cle: primaire, reference: '', obligatoire: true}
      - {nom: texte, type: TEXT, cle: '', reference: '', obligatoire: false}
      - {nom: graine, type: BLOB, cle: '', reference: '', obligatoire: false}
    index: []

  - id: TB-29
    nom: preferences
    type: table
    stockage: N-02
    entite: E-17
    raison: Les préférences d'interface du téléphone, une seule ligne (D-103, D-135).
    colonnes:
      - {nom: id, type: INTEGER, cle: primaire, reference: '', obligatoire: true}
      - {nom: theme_icone, type: TEXT, cle: '', reference: '', obligatoire: true}
      - {nom: carrousels_pause, type: INTEGER, cle: '', reference: '', obligatoire: true}
    index: []

  - id: TB-30
    nom: horloge
    type: table
    stockage: N-02
    entite: aucune
    raison: Le dernier écart connu entre l'heure du téléphone et celle du serveur, gardé sans réseau (D-140) ; une seule ligne ; un réglage technique, pas une entité.
    colonnes:
      - {nom: id, type: INTEGER, cle: primaire, reference: '', obligatoire: true}
      - {nom: ecart_ms, type: INTEGER, cle: '', reference: '', obligatoire: true}
    index: []

  - id: TB-31
    nom: minuteur_connu
    type: table
    stockage: N-02
    entite: E-14
    raison: Le dernier état du minuteur reçu du serveur, pour griser sans réseau après une fermeture de l'appli (D-150) ; effacé à la déconnexion (F-071) et à la suppression du compte (F-063).
    colonnes:
      - {nom: compte_id, type: TEXT, cle: primaire, reference: '', obligatoire: true}
      - {nom: duree_cycle_s, type: INTEGER, cle: '', reference: '', obligatoire: true}
      - {nom: temps_cycle_s, type: INTEGER, cle: '', reference: '', obligatoire: true}
      - {nom: cycles_ecoules, type: INTEGER, cle: '', reference: '', obligatoire: true}
      - {nom: connu_le, type: TEXT, cle: '', reference: '', obligatoire: true}
    index: []

  - id: TB-32
    nom: session_telephone
    type: collection
    stockage: N-03
    entite: E-02
    raison: La session du compte connecté sur ce téléphone (D-053, NFR-X-9) ; une seule entrée.
    colonnes:
      - {nom: jeton, type: string, cle: primaire, reference: '', obligatoire: true}
      - {nom: compte_id, type: string, cle: '', reference: '', obligatoire: true}
    index: []

  - id: TB-33
    nom: partages
    type: table
    stockage: N-01
    entite: E-03
    raison: Les partages d'un post, une ligne par partage, quelle que soit la façon (D-058) ; comptés pour le nombre de partages, et effacés avec le compte qui a partagé (D-101).
    colonnes:
      - {nom: id, type: uuid, cle: primaire, reference: '', obligatoire: true}
      - {nom: post_id, type: uuid, cle: '', reference: TB-06.id, obligatoire: true}
      - {nom: compte_id, type: uuid, cle: '', reference: TB-01.id, obligatoire: true}
    index: [post_id, compte_id]
```

### Champs d'entité sans colonne

| Entité | Champ | Où il est, ou comment il est calculé |
| --- | --- | --- |
| E-01 | photo de profil | Le média dont TB-07.profil\_de vaut l'id du compte (D-125) |
| E-01 | nombre de posts, d'amis, de likes reçus | Comptés à la demande dans TB-06, TB-15 (statut amis) et TB-09 sur ses posts (D-144) |
| E-02 | fournisseur, adresse e-mail | TB-02 (fournisseur, cle) ; TB-03.adresse\_email le temps d'un code |
| E-02 | code à 6 chiffres | TB-03.code\_hash : seul son hachage est gardé |
| E-02 | délai avant renvoi | Calculé : TB-03.envoye\_le + 30 s |
| E-02 | session ouverte sur l'appareil | TB-05 sur le serveur, TB-32 sur le téléphone |
| E-03 | auteur (pseudo, photo) | TB-06.auteur\_id, puis TB-01 et TB-07 |
| E-03 | type | Photo, vidéo ou carrousel : calculé d'après ses médias (un sans durée, un avec durée, plusieurs). Pause, inspire-expire et premium ne sont jamais stockés : le téléphone les place lui-même (D-136) |
| E-03 | nombres de likes, de commentaires, d'enregistrements, de partages | Comptés dans TB-09, TB-08, TB-12 et TB-33 (D-058) |
| E-03 | lien | Calculé à partir de TB-06.id |
| E-03 | personnes identifiées | TB-13 |
| E-05 | ancienneté ; nombre de likes | Calculée d'après TB-08.publie\_le ; compté dans TB-10 |
| E-06 | cible ; date | TB-09 pour un post, TB-10 pour un commentaire ; like\_le |
| E-07 | posts enregistrés | TB-12 |
| E-08 | ancienneté ; post concerné | Calculée d'après TB-14.cree\_le ; TB-14.post\_id ou story\_id |
| E-09 | compte ; statut | L'autre compte de la ligne TB-15 ; « demandé » et « en attente » sont la même ligne « demandee », vue de chaque côté |
| E-09 | ami proche | TB-16 (D-060, D-146) |
| E-10 | contact ; dernier message et heure | L'autre compte de TB-17 ; le dernier message de la conversation dans TB-18 |
| E-11 | photo en graine ; date | TB-07.message\_id ; TB-18.envoye\_le |
| E-12 | images ; ancienneté | TB-07.story\_id ; calculée d'après TB-19.publiee\_le |
| E-12 | fin | Calculée : publiee\_le + 24 h (D-079) |
| E-12 | vue par ; personnes identifiées | TB-20 ; TB-21 |
| E-13 | suggestions | Tirées au hasard sur le téléphone, jamais gardées (D-089) |
| E-13 | tendances | Calculées par le serveur à chaque demande ; leur règle est ouverte dans F-053, et aura sa table si elle en demande une |
| E-14 | compte ; deux téléphones | TB-22.compte\_id ; les périodes fusionnées de TB-23 (D-105) |
| E-14 | pourcentage de gris ; temps restant | Calculés : 10 % par cycle écoulé ; duree\_cycle\_s − temps\_cycle\_s |
| E-15 | compte, durée cumulée | TB-24 |
| E-16 | prix | Fixé dans le store, pas stocké (D-092) |
| E-16 | statut ; achat du store | Soutenu si TB-25.achat\_store est rempli ; TB-25.store et achat\_store |
| E-17 | téléphone, pas le compte | TB-29 est sur le téléphone : aucune colonne de compte |

### Colonnes sans champ d'entité

| Colonnes | Pourquoi |
| --- | --- |
| id de TB-06, TB-07, TB-08, TB-11, TB-14, TB-17, TB-18, TB-19, TB-33 | uuid fait par le téléphone : un « Réessayer » ou un renvoi retombe sur la même ligne (D-144, D-137) |
| TB-01.id | Le numéro interne du compte (D-102), seul gardé 7 jours dans TB-26 |
| TB-03, TB-04 | Le code en cours et l'état « Inscription » de SM-E-02, effacés par FL-16 (D-149) |
| TB-06.publie\_le | L'ordre des posts du profil et du fil (F-062, F-009) |
| TB-07.compte\_id ; TB-11.compte\_id ; TB-12.compte\_id ; TB-33.compte\_id | Le propriétaire, pour les droits (NFR-X-7) et l'effacement avec le compte (D-101) ; dans TB-12, un post par collection au plus (D-057) |
| TB-07.post\_id, story\_id, message\_id, profil\_de | Ce à quoi la graine est rattachée (SM-E-04) |
| TB-14.destinataire\_id | Le compte qui reçoit la notification |
| TB-17.compte\_a, compte\_b | Les deux amis de la conversation (D-082) |
| TB-22.duree\_changee\_le, reinitialise\_le | Le réglage fait le plus tard gagne (D-111, D-140) ; seules les secondes après la réinitialisation comptent (D-117) |
| TB-23 | Les périodes au premier plan, gardées 7 jours (D-105, D-117, D-147) |
| TB-25.store | Le store auprès duquel vérifier l'achat (D-092) |
| TB-26, TB-27, TB-30 | Tables sans entité : comptes supprimés (FL-15), envois en attente (FL-12), écart d'heure (D-140) |
| TB-28.id, TB-29.id, TB-30.id | Une seule ligne par téléphone |
| TB-31.connu\_le | L'heure du dernier état reçu du serveur (D-150) |

### États dans les tables

| Diagramme | Où se lit chaque état |
| --- | --- |
| SM-E-02 | Déconnecté : aucune ligne. Code envoyé, renvoyable, expiré : une ligne de TB-03, selon envoye\_le (30 s, 10 min) et essais\_faux (5). Inscription : TB-04. Session ouverte : TB-05 et TB-32 |
| SM-E-03 | Publié : une ligne de TB-06. Brouillon, En publication, Échec : en mémoire sur le téléphone (D-135) |
| SM-E-04 | En attente : une ligne de TB-27. Graine d'un brouillon : TB-07 sans rattachement. Rattachée : post\_id, story\_id, message\_id ou profil\_de rempli |
| SM-E-08 | Non vue, Vue : TB-14.vue |
| SM-E-09 | Aucune : pas de ligne. Demandée, Amis : TB-15.statut, « demandee » ou « amis » |
| SM-E-10 | Lu, Non lu, pour chacun : TB-17.lu\_par\_a, lu\_par\_b |
| SM-E-12 | En cours : une ligne de TB-19 ; Finie : effacée aussitôt (FL-13). Non vue, Vue pour un ami : pas de ligne ou une ligne de TB-20 |
| SM-E-14 | Arrêté, En marche : pas stockés ; chaque téléphone compte ses secondes (D-117) et le serveur fusionne leurs périodes (TB-23). Noir et blanc : cycles\_ecoules = 10 |
| SM-E-16 | Non soutenu, Soutenu : TB-25.achat\_store vide ou rempli. Paiement en cours : chez le store. Soutenu, pas encore enregistré : une ligne de TB-27 |

Reste ouvert, dans les `questions_ouvertes` de F-053 : ce que comptent les tendances, composées à partir des posts (D-158).

## Flux de données

14 nœuds et 84 flux, DF-01 à DF-84, choisis par D-151 : les deux rôles, une appli par téléphone (iOS, Android), le serveur, les trois stockages et six services tiers, dont les rapports de plantage (N-14), qu'aucun flux DF n'atteint. Chaque flux va dans un seul sens et cite les entités qu'il porte et les features qui le déclenchent. C'est la réponse au prompt 12 de la méthode.

### Le graphe

Tiré du YAML ci-dessous : un trait par paire de nœuds, avec ses flux. Les 11 flux entre chaque appli et le serveur sont les 10 groupes de l'API et le direct par WebSocket (D-137). Les pointillés vers N-14 ne sont pas des flux DF : un rapport de plantage ne porte aucune donnée d'entité (NFR-X-5).

```mermaid
flowchart LR
    N01[("N-01 Base PostgreSQL du serveur")]
    N02[("N-02 Base SQLite du téléphone")]
    N03[("N-03 Stockage sécurisé du téléphone, Trousseau ou Keystore")]
    N04(["N-04 Personne non connectée"])
    N05(["N-05 Utilisateur connecté"])
    N06["N-06 Appli iOS"]
    N07["N-07 Appli Android"]
    N08["N-08 Serveur"]
    N09{{"N-09 Connexion Google"}}
    N10{{"N-10 Connexion Apple"}}
    N11{{"N-11 Service d'envoi des e-mails"}}
    N12{{"N-12 App Store"}}
    N13{{"N-13 Google Play"}}
    N14{{"N-14 Rapports de plantage"}}
    N04 -->|DF-01| N06
    N06 -->|DF-02| N04
    N04 -->|DF-03| N07
    N07 -->|DF-04| N04
    N11 -->|DF-05| N04
    N05 -->|DF-06| N06
    N06 -->|DF-07| N05
    N05 -->|DF-08| N07
    N07 -->|DF-09| N05
    N06 -->|API, 11 flux| N08
    N08 -->|API, 11 flux| N06
    N07 -->|API, 11 flux| N08
    N08 -->|API, 11 flux| N07
    N06 -->|DF-54| N09
    N09 -->|DF-55| N06
    N06 -->|DF-56| N10
    N10 -->|DF-57| N06
    N06 -->|DF-58| N12
    N12 -->|DF-59| N06
    N07 -->|DF-60| N09
    N09 -->|DF-61| N07
    N07 -->|DF-62| N10
    N10 -->|DF-63| N07
    N07 -->|DF-64| N13
    N13 -->|DF-65| N07
    N08 -->|DF-66| N11
    N08 -->|DF-67| N12
    N12 -->|DF-68| N08
    N08 -->|DF-69| N13
    N13 -->|DF-70| N08
    N06 -->|DF-71, DF-73| N02
    N02 -->|DF-72, DF-74| N06
    N06 -->|DF-75| N03
    N03 -->|DF-76| N06
    N07 -->|DF-77, DF-79| N02
    N02 -->|DF-78, DF-80| N07
    N07 -->|DF-81| N03
    N03 -->|DF-82| N07
    N08 -->|DF-83| N01
    N01 -->|DF-84| N08
    N06 -.->|plantage, sans donnée d'entité| N14
    N07 -.->|plantage, sans donnée d'entité| N14
```

### Nœuds et flux

Les flux sont rangés comme le graphe : acteurs, groupes de l'API, direct, services tiers, stockages du téléphone, puis du serveur.

```yaml
noeuds:
  - id: N-01
    type: stockage
    nom: "Base PostgreSQL du serveur (D-134)"
    modele: SQL
  - id: N-02
    type: stockage
    nom: "Base SQLite du téléphone (D-135)"
    modele: SQL
  - id: N-03
    type: stockage
    nom: "Stockage sécurisé du téléphone, Trousseau ou Keystore (D-135)"
    modele: NoSQL
  - id: N-04
    type: acteur
    nom: "Personne non connectée"
    role: R-01
  - id: N-05
    type: acteur
    nom: "Utilisateur connecté"
    role: R-02
  - id: N-06
    type: infra
    nom: "Appli iOS (D-132)"
  - id: N-07
    type: infra
    nom: "Appli Android (D-132)"
  - id: N-08
    type: infra
    nom: "Serveur (D-133)"
  - id: N-09
    type: tiers
    nom: "Connexion Google (F-001)"
  - id: N-10
    type: tiers
    nom: "Connexion Apple (F-001)"
  - id: N-11
    type: tiers
    nom: "Service d'envoi des e-mails (F-003)"
  - id: N-12
    type: tiers
    nom: "App Store (D-092)"
  - id: N-13
    type: tiers
    nom: "Google Play (D-092)"
  - id: N-14
    type: tiers
    nom: "Service de rapports de plantage (D-129, NFR-X-5)"

flux:
  - {id: DF-01, de: N-04, vers: N-06, donnees: [E-02, E-01], features: [F-001, F-003, F-005, F-007, F-008, F-070], flows: [], protocole: "écran tactile", sensible: true}
  - {id: DF-02, de: N-06, vers: N-04, donnees: [E-02, E-17], features: [F-001, F-002, F-004, F-006, F-007, F-008, F-070, F-074], flows: [], protocole: "écran", sensible: true}
  - {id: DF-03, de: N-04, vers: N-07, donnees: [E-02, E-01], features: [F-001, F-003, F-005, F-007, F-008, F-070], flows: [], protocole: "écran tactile", sensible: true}
  - {id: DF-04, de: N-07, vers: N-04, donnees: [E-02, E-17], features: [F-001, F-002, F-004, F-006, F-007, F-008, F-070, F-074], flows: [], protocole: "écran", sensible: true}
  - {id: DF-05, de: N-11, vers: N-04, donnees: [E-02], features: [F-003, F-008], flows: [], protocole: "e-mail", sensible: true}
  - {id: DF-06, de: N-05, vers: N-06, donnees: [E-01, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-13, E-14, E-16, E-17], features: [F-005, F-015, F-016, F-018, F-019, F-022, F-024, F-028, F-030, F-031, F-034, F-036, F-037, F-038, F-040, F-041, F-042, F-044, F-046, F-047, F-048, F-049, F-050, F-051, F-052, F-053, F-056, F-058, F-060, F-061, F-063, F-066, F-067, F-068, F-071, F-072, F-073], flows: [], protocole: "écran tactile", sensible: true}
  - {id: DF-07, de: N-06, vers: N-05, donnees: [E-01, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-13, E-14, E-15, E-16, E-17], features: [F-002, F-009, F-010, F-011, F-012, F-014, F-015, F-016, F-017, F-018, F-019, F-020, F-021, F-022, F-024, F-025, F-026, F-027, F-033, F-036, F-037, F-038, F-039, F-043, F-044, F-045, F-048, F-049, F-052, F-053, F-054, F-055, F-056, F-057, F-059, F-062, F-065, F-072, F-073, F-074], flows: [], protocole: "écran", sensible: true}
  - {id: DF-08, de: N-05, vers: N-07, donnees: [E-01, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-13, E-14, E-16, E-17], features: [F-005, F-015, F-016, F-018, F-019, F-022, F-024, F-028, F-030, F-031, F-034, F-036, F-037, F-038, F-040, F-041, F-042, F-044, F-046, F-047, F-048, F-049, F-050, F-051, F-052, F-053, F-056, F-058, F-060, F-061, F-063, F-066, F-067, F-068, F-071, F-072, F-073], flows: [], protocole: "écran tactile", sensible: true}
  - {id: DF-09, de: N-07, vers: N-05, donnees: [E-01, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-13, E-14, E-15, E-16, E-17], features: [F-002, F-009, F-010, F-011, F-012, F-014, F-015, F-016, F-017, F-018, F-019, F-020, F-021, F-022, F-024, F-025, F-026, F-027, F-033, F-036, F-037, F-038, F-039, F-043, F-044, F-045, F-048, F-049, F-052, F-053, F-054, F-055, F-056, F-057, F-059, F-062, F-065, F-072, F-073, F-074], flows: [], protocole: "écran", sensible: true}
  # Connexion
  - {id: DF-10, de: N-06, vers: N-08, donnees: [E-02, E-01], features: [F-001, F-003, F-007, F-008, F-070, F-071], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-11, de: N-08, vers: N-06, donnees: [E-02, E-01], features: [F-001, F-007, F-008, F-070], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-12, de: N-07, vers: N-08, donnees: [E-02, E-01], features: [F-001, F-003, F-007, F-008, F-070, F-071], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-13, de: N-08, vers: N-07, donnees: [E-02, E-01], features: [F-001, F-007, F-008, F-070], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # Fil et posts
  - {id: DF-14, de: N-06, vers: N-08, donnees: [E-03, E-12, E-05, E-06, E-07], features: [F-009, F-016, F-018, F-019, F-030, F-031, F-051], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-15, de: N-08, vers: N-06, donnees: [E-03, E-04, E-05, E-06, E-07, E-01], features: [F-009, F-010, F-011, F-012, F-016, F-017, F-018, F-020, F-030, F-031, F-051], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-16, de: N-07, vers: N-08, donnees: [E-03, E-12, E-05, E-06, E-07], features: [F-009, F-016, F-018, F-019, F-030, F-031, F-051], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-17, de: N-08, vers: N-07, donnees: [E-03, E-04, E-05, E-06, E-07, E-01], features: [F-009, F-010, F-011, F-012, F-016, F-017, F-018, F-020, F-030, F-031, F-051], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # Médias
  - {id: DF-18, de: N-06, vers: N-08, donnees: [E-04], features: [F-005, F-044, F-046], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: false}
  - {id: DF-19, de: N-08, vers: N-06, donnees: [E-04], features: [F-044, F-046], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: false}
  - {id: DF-20, de: N-07, vers: N-08, donnees: [E-04], features: [F-005, F-044, F-046], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: false}
  - {id: DF-21, de: N-08, vers: N-07, donnees: [E-04], features: [F-044, F-046], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: false}
  # Amis et notifications
  - {id: DF-22, de: N-06, vers: N-08, donnees: [E-09, E-08, E-01], features: [F-022, F-028, F-034, F-043, F-072], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-23, de: N-08, vers: N-06, donnees: [E-09, E-08, E-01, E-04, E-05], features: [F-022, F-028, F-034, F-043, F-048, F-072, F-019], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-24, de: N-07, vers: N-08, donnees: [E-09, E-08, E-01], features: [F-022, F-028, F-034, F-043, F-072], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-25, de: N-08, vers: N-07, donnees: [E-09, E-08, E-01, E-04, E-05], features: [F-022, F-028, F-034, F-043, F-048, F-072, F-019], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # Minuteur et temps
  - {id: DF-26, de: N-06, vers: N-08, donnees: [E-14, E-15], features: [F-024, F-060, F-061, F-073], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-27, de: N-08, vers: N-06, donnees: [E-14, E-15], features: [F-015, F-024, F-059, F-065, F-073], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-28, de: N-07, vers: N-08, donnees: [E-14, E-15], features: [F-024, F-060, F-061, F-073], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-29, de: N-08, vers: N-07, donnees: [E-14, E-15], features: [F-015, F-024, F-059, F-065, F-073], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # Stories
  - {id: DF-30, de: N-06, vers: N-08, donnees: [E-12], features: [F-036], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-31, de: N-08, vers: N-06, donnees: [E-12, E-09, E-01, E-04], features: [F-036], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-32, de: N-07, vers: N-08, donnees: [E-12], features: [F-036], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-33, de: N-08, vers: N-07, donnees: [E-12, E-09, E-01, E-04], features: [F-036], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # Messages
  - {id: DF-34, de: N-06, vers: N-08, donnees: [E-11, E-10, E-04], features: [F-019, F-037, F-038, F-040, F-041, F-042], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-35, de: N-08, vers: N-06, donnees: [E-10, E-11, E-04, E-01, E-03], features: [F-033, F-037, F-038, F-039, F-042, F-075], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-36, de: N-07, vers: N-08, donnees: [E-11, E-10, E-04], features: [F-019, F-037, F-038, F-040, F-041, F-042], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-37, de: N-08, vers: N-07, donnees: [E-10, E-11, E-04, E-01, E-03], features: [F-033, F-037, F-038, F-039, F-042, F-075], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # Recherche
  - {id: DF-38, de: N-06, vers: N-08, donnees: [E-13], features: [F-052, F-053], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: false}
  - {id: DF-39, de: N-08, vers: N-06, donnees: [E-03, E-04, E-01, E-06], features: [F-052, F-053, F-054, F-020], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-40, de: N-07, vers: N-08, donnees: [E-13], features: [F-052, F-053], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: false}
  - {id: DF-41, de: N-08, vers: N-07, donnees: [E-03, E-04, E-01, E-06], features: [F-052, F-053, F-054, F-020], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # Soutien
  - {id: DF-42, de: N-06, vers: N-08, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-43, de: N-08, vers: N-06, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-44, de: N-07, vers: N-08, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-45, de: N-08, vers: N-07, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # Profil et compte
  - {id: DF-46, de: N-06, vers: N-08, donnees: [E-01, E-04], features: [F-056, F-058, F-063], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-47, de: N-08, vers: N-06, donnees: [E-01, E-03, E-04, E-06, E-09], features: [F-056, F-057, F-058, F-062], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-48, de: N-07, vers: N-08, donnees: [E-01, E-04], features: [F-056, F-058, F-063], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  - {id: DF-49, de: N-08, vers: N-07, donnees: [E-01, E-03, E-04, E-06, E-09], features: [F-056, F-057, F-058, F-062], flows: [], protocole: "HTTPS, API JSON (D-137)", sensible: true}
  # direct par WebSocket : « en train d'écrire », message reçu
  - {id: DF-50, de: N-06, vers: N-08, donnees: [E-10], features: [F-041], flows: [], protocole: "WebSocket (D-133)", sensible: true}
  - {id: DF-51, de: N-08, vers: N-06, donnees: [E-11, E-10], features: [F-038, F-041], flows: [], protocole: "WebSocket (D-133)", sensible: true}
  - {id: DF-52, de: N-07, vers: N-08, donnees: [E-10], features: [F-041], flows: [], protocole: "WebSocket (D-133)", sensible: true}
  - {id: DF-53, de: N-08, vers: N-07, donnees: [E-11, E-10], features: [F-038, F-041], flows: [], protocole: "WebSocket (D-133)", sensible: true}
  # services tiers
  - {id: DF-54, de: N-06, vers: N-09, donnees: [E-02], features: [F-001], flows: [], protocole: "HTTPS, SDK du fournisseur", sensible: true}
  - {id: DF-55, de: N-09, vers: N-06, donnees: [E-02], features: [F-001], flows: [], protocole: "HTTPS, SDK du fournisseur", sensible: true}
  - {id: DF-56, de: N-06, vers: N-10, donnees: [E-02], features: [F-001], flows: [], protocole: "HTTPS, SDK du fournisseur", sensible: true}
  - {id: DF-57, de: N-10, vers: N-06, donnees: [E-02], features: [F-001], flows: [], protocole: "HTTPS, SDK du fournisseur", sensible: true}
  - {id: DF-58, de: N-06, vers: N-12, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, achat intégré du store", sensible: true}
  - {id: DF-59, de: N-12, vers: N-06, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, achat intégré du store", sensible: true}
  - {id: DF-60, de: N-07, vers: N-09, donnees: [E-02], features: [F-001], flows: [], protocole: "HTTPS, SDK du fournisseur", sensible: true}
  - {id: DF-61, de: N-09, vers: N-07, donnees: [E-02], features: [F-001], flows: [], protocole: "HTTPS, SDK du fournisseur", sensible: true}
  - {id: DF-62, de: N-07, vers: N-10, donnees: [E-02], features: [F-001], flows: [], protocole: "HTTPS, SDK du fournisseur", sensible: true}
  - {id: DF-63, de: N-10, vers: N-07, donnees: [E-02], features: [F-001], flows: [], protocole: "HTTPS, SDK du fournisseur", sensible: true}
  - {id: DF-64, de: N-07, vers: N-13, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, achat intégré du store", sensible: true}
  - {id: DF-65, de: N-13, vers: N-07, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, achat intégré du store", sensible: true}
  - {id: DF-66, de: N-08, vers: N-11, donnees: [E-02], features: [F-003, F-008], flows: [], protocole: "HTTPS, API du service", sensible: true}
  - {id: DF-67, de: N-08, vers: N-12, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, API de vérification du store", sensible: true}
  - {id: DF-68, de: N-12, vers: N-08, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, API de vérification du store", sensible: true}
  - {id: DF-69, de: N-08, vers: N-13, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, API de vérification du store", sensible: true}
  - {id: DF-70, de: N-13, vers: N-08, donnees: [E-16], features: [F-015], flows: [], protocole: "HTTPS, API de vérification du store", sensible: true}
  # recherche, préférences, minuteur connu
  - {id: DF-71, de: N-06, vers: N-02, donnees: [E-13, E-17, E-14], features: [F-002, F-012, F-024, F-052, F-053, F-066, F-067, F-063, F-071], flows: [], protocole: "expo-sqlite, appel local", sensible: true}
  - {id: DF-72, de: N-02, vers: N-06, donnees: [E-13, E-17, E-14], features: [F-002, F-012, F-024, F-052, F-053, F-066, F-067], flows: [], protocole: "expo-sqlite, appel local", sensible: true}
  # envois en attente
  - {id: DF-73, de: N-06, vers: N-02, donnees: [E-04, E-12, E-14, E-15, E-16, E-01], features: [F-005, F-015, F-024, F-036, F-044, F-046, F-058, F-060, F-061, F-073], flows: [FL-12], protocole: "expo-sqlite, appel local", sensible: true}
  - {id: DF-74, de: N-02, vers: N-06, donnees: [E-04, E-12, E-14, E-15, E-16, E-01], features: [F-005, F-015, F-024, F-036, F-044, F-046, F-058, F-060, F-061, F-073], flows: [FL-12], protocole: "expo-sqlite, appel local", sensible: true}
  # session
  - {id: DF-75, de: N-06, vers: N-03, donnees: [E-02], features: [F-001, F-007, F-070, F-071, F-063], flows: [], protocole: "expo-secure-store, appel local", sensible: true}
  - {id: DF-76, de: N-03, vers: N-06, donnees: [E-02], features: [F-001, F-007, F-070, F-071, F-063], flows: [], protocole: "expo-secure-store, appel local", sensible: true}
  # recherche, préférences, minuteur connu
  - {id: DF-77, de: N-07, vers: N-02, donnees: [E-13, E-17, E-14], features: [F-002, F-012, F-024, F-052, F-053, F-066, F-067, F-063, F-071], flows: [], protocole: "expo-sqlite, appel local", sensible: true}
  - {id: DF-78, de: N-02, vers: N-07, donnees: [E-13, E-17, E-14], features: [F-002, F-012, F-024, F-052, F-053, F-066, F-067], flows: [], protocole: "expo-sqlite, appel local", sensible: true}
  # envois en attente
  - {id: DF-79, de: N-07, vers: N-02, donnees: [E-04, E-12, E-14, E-15, E-16, E-01], features: [F-005, F-015, F-024, F-036, F-044, F-046, F-058, F-060, F-061, F-073], flows: [FL-12], protocole: "expo-sqlite, appel local", sensible: true}
  - {id: DF-80, de: N-02, vers: N-07, donnees: [E-04, E-12, E-14, E-15, E-16, E-01], features: [F-005, F-015, F-024, F-036, F-044, F-046, F-058, F-060, F-061, F-073], flows: [FL-12], protocole: "expo-sqlite, appel local", sensible: true}
  # session
  - {id: DF-81, de: N-07, vers: N-03, donnees: [E-02], features: [F-001, F-007, F-070, F-071, F-063], flows: [], protocole: "expo-secure-store, appel local", sensible: true}
  - {id: DF-82, de: N-03, vers: N-07, donnees: [E-02], features: [F-001, F-007, F-070, F-071, F-063], flows: [], protocole: "expo-secure-store, appel local", sensible: true}
  # écritures, tâches de fond
  - {id: DF-83, de: N-08, vers: N-01, donnees: [E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-14, E-15, E-16], features: [F-001, F-003, F-005, F-007, F-008, F-009, F-010, F-011, F-012, F-015, F-016, F-017, F-018, F-019, F-020, F-022, F-024, F-028, F-030, F-031, F-033, F-034, F-036, F-037, F-038, F-039, F-040, F-041, F-042, F-043, F-044, F-046, F-048, F-051, F-052, F-053, F-054, F-056, F-057, F-058, F-059, F-060, F-061, F-062, F-063, F-065, F-070, F-071, F-072, F-073], flows: [FL-13, FL-14, FL-15, FL-16, FL-17], protocole: "PostgreSQL, TLS", sensible: true}
  # lectures, LISTEN/NOTIFY pour le direct
  - {id: DF-84, de: N-01, vers: N-08, donnees: [E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-14, E-15, E-16], features: [F-001, F-003, F-005, F-007, F-008, F-009, F-010, F-011, F-012, F-015, F-016, F-017, F-018, F-019, F-020, F-022, F-024, F-028, F-030, F-031, F-033, F-034, F-036, F-037, F-038, F-039, F-040, F-041, F-042, F-043, F-044, F-046, F-048, F-051, F-052, F-053, F-054, F-056, F-057, F-058, F-059, F-060, F-061, F-062, F-063, F-065, F-070, F-071, F-072, F-073, F-075], flows: [FL-13, FL-14, FL-15, FL-16, FL-17], protocole: "PostgreSQL, TLS", sensible: true}
```

### Features et stockages sans flux

Aucune feature qui lit ou écrit des données ne manque, et chaque stockage est atteint. F-074 ne porte aucune donnée : il ouvre l'App Store ou Google Play sans rien leur envoyer. Le service de rapports de plantage (N-14, D-129, NFR-X-5) n'est atteint par aucun flux DF : il ne reçoit aucune donnée d'entité, seulement des données techniques.

### Flux sensibles

78 flux portent des données liées à un compte, des identifiants ou un paiement (D-151) : un lieu, une personne identifiée, un like ou une vue de story lient un compte à un endroit ou à un autre compte. Seuls DF-18 à DF-21 (graines des médias), DF-38 et DF-40 (graine d'une recherche) n'y comptent pas. Le chemin vers les rapports de plantage (N-14) est à examiner aussi, pour NFR-X-5. À reprendre dans le threat model.

| Ce qu'ils portent | Entre | Flux |
| --- | --- | --- |
| Identifiants de connexion (E-02) | Personne non connectée et appli ; appli et serveur ; appli et Google ou Apple ; serveur et service d'e-mails, puis la personne ; appli et stockage sécurisé | DF-01 à DF-05, DF-10 à DF-13, DF-54 à DF-57, DF-60 à DF-63, DF-66, DF-75, DF-76, DF-81, DF-82 |
| Paiement du soutien (E-16) | Appli et serveur ; appli et store ; serveur et store | DF-42 à DF-45, DF-58, DF-59, DF-64, DF-65, DF-67 à DF-70 |
| Messages et conversations (E-10, E-11) | Appli et serveur, par l'API et en direct | DF-34 à DF-37, DF-50 à DF-53 |
| Amitiés et comptes (E-01, E-09) | Appli et serveur | DF-22 à DF-25, DF-46 à DF-49 |
| Posts, commentaires, likes, collections et stories : lieu, personnes identifiées, qui a liké, qui a vu (E-03, E-05 à E-07, E-12) | Appli et serveur | DF-14 à DF-17, DF-30 à DF-33, DF-39, DF-41 |
| Temps passé dans l'appli (E-14, E-15) | Appli et serveur | DF-26 à DF-29 |
| Envois en attente et minuteur connu (E-01, E-14 à E-16) | Appli et SQLite | DF-71 à DF-74, DF-77 à DF-80 |
| Tout ce que voit et fait l'utilisateur | Personne connectée et appli | DF-06 à DF-09 |
| Tout ce que garde le serveur | Serveur et PostgreSQL | DF-83, DF-84 |

## Contrats de pages

Un contrat par page, P-01 à P-30, dans le dépôt : `docs/pages/P-01.yaml` à `docs/pages/P-30.yaml`. Chacun liste les composants de sa page (C-xx) avec leur nom accessible (NFR-X-14), les colonnes qu'ils lisent et écrivent, les flux qui les portent, et les conditions pour apparaître ou être actifs. Un état de page (P-01.a…) est un état d'un composant de sa page. C'est la réponse au prompt 13 de la méthode, et aucun MANQUANT ne reste : ce qu'il a trouvé est réglé par D-152 à D-161, par les entités ajoutées aux flux DF-15, DF-17, DF-23, DF-25, DF-31, DF-33, DF-35, DF-37, DF-39, DF-41, DF-47 et DF-49, par F-019 ajoutée à DF-23 et DF-25, F-020 à DF-39 et DF-41, et F-063 et F-071 à DF-71 et DF-77.

- Les contrats sont des fichiers YAML vérifiés à chaque pull request (checks L10 et B10) : ils sont écrits dans le dépôt, comme les modèles TLA+, et citent les flux et les décisions qu'ils suivent.
- Le grisage (F-024) et le temps d'utilisation (F-073) ont un composant sur chaque page où ils jouent, même sans rien à toucher.
- Un texte tapé et pas encore envoyé, et le brouillon d'un post ou d'une story (D-135), ne sont dans aucune colonne : `lit` et `ecrit` restent vides.
- Chaque flux est cité pour les deux applis (iOS et Android), avec DF-83 ou DF-84 quand la donnée est dans la base du serveur.
- Les questions ouvertes restent dans les features ; un composant n'en porte que s'il en a une à lui.
