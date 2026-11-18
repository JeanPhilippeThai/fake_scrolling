<!-- Source: https://claude.ai/artifact/JrVRgnJKXnwGC28FuPVUwz, tab "Tab 1", rev 54, exported 2026-11-18 -->
# Fake scrolling — inventaire des écrans

Nov 15, 2026 · @Jp

Le design compte 26 écrans, de P-01 à P-26. Ils suivent l'ordre du parcours : connexion, Accueil, Messages, Nouveau post, Recherche, Profil. Les panneaux de la création d'un post, ajoutés ensuite, sont à la fin (P-24 à P-26).

- **Écran** : toute vue distincte, y compris un panneau qui se superpose à une autre page (notifications, commentaires, options…).
- **Pas de regroupement** : un même élément présent sur plusieurs pages (menu du bas, grisage) est relisté sur chacune.
- **Colonnes** : élément (verbe + objet), description en une ligne, données affichées ou modifiées, états visibles. Un état qui n'existe pas dans le design est noté « aucun dessiné ».
- **« à confirmer »** : comportement déduit, ou propre à la maquette de démo, et non visible dans le design.

**Vocabulaire** : « légende » désigne le texte d'un post ; « description » est réservé au profil.

## P-01 Connexion

Premier écran : on se connecte avec Google, Apple ou un code envoyé par e-mail.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Voir le logo de l'appli | Carré arrondi avec un F blanc, puis le nom « fake scrolling » | Thème d'icône choisi dans P-23 (Noir par défaut) | Fond noir, dégradé orange ou rouge selon le thème |
| Continuer avec Google | Bouton blanc qui connecte et ouvre P-03 | Compte Google (écran d'autorisation Google : à confirmer) | Normal ; aucun chargement ni erreur dessiné |
| Continuer avec Apple | Bouton noir qui connecte et ouvre P-03 | Compte Apple (écran d'autorisation Apple : à confirmer) | Normal ; aucun chargement ni erreur dessiné |
| Saisir son adresse e-mail | Champ « Adresse e-mail », exemple toi@exemple.fr | Adresse e-mail (modifiée) | Vide ; rempli ; aucun message d'erreur dessiné |
| Recevoir un code | Demande l'envoi d'un code et ouvre P-02 | Adresse e-mail saisie (envoi réel du mail : à confirmer) | Désactivé gris tant que l'adresse n'est pas valide ; actif vert ; aucun état d'envoi ni d'erreur |
| Lire la mention sans mot de passe | Phrase sous le bouton : pas de mot de passe, un code par e-mail | Texte fixe | Toujours affichée |

## P-02 Code reçu par e-mail

On saisit le code à 6 chiffres reçu par e-mail pour se connecter.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Revenir à la connexion | Flèche en haut à gauche vers P-01 | Aucune | — |
| Lire la consigne | Titre « Entre le code » et phrase sur le code à 6 chiffres envoyé par e-mail | Texte fixe ; l'adresse e-mail n'est pas rappelée | Toujours affichée |
| Saisir le code à 6 chiffres | Six cases qui se remplissent au fil de la frappe, clavier numérique | Code (modifié), chiffres seulement ; remplissage auto depuis l'e-mail : à confirmer selon le téléphone | Vide ; case en cours encadrée en noir ; partiel ; complet |
| Se connecter | Valide le code et ouvre P-03 | Code saisi (vérification réelle : à confirmer, la maquette accepte tout code) | Désactivé gris sous 6 chiffres ; actif vert ; aucun état code faux ou expiré dessiné |
| Attendre pour renvoyer le code | Texte « Renvoyer le code dans 30 s » | Secondes restantes | Décompte de 30 à 0 |
| Renvoyer le code | Lien affiché à 0 s, vide les cases et relance le décompte | Nouvel envoi du code (à confirmer) | Visible seulement après le décompte |

## P-03 Accueil — fil

Fil plein écran, un post à la fois, avec actions en colonne à droite et cloche en haut à droite.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Passer au post suivant ou précédent | Glisser vers le haut ou le bas, molette, flèches du clavier ; un post entier à la fois | Position dans le fil ; 8 posts de plus chargés près de la fin | En cours de glisser ; retour en place si glisser trop court ; aucun indicateur de chargement dessiné |
| Voir un post photo | Image plein écran de formes colorées | Image du post (formes générées en démo ; vrais médias : à confirmer) | Couleur ou grisage selon les cycles |
| Voir un post vidéo | Formes animées en boucle, environ 30 % des posts simples | Durée de 8 à 20 s | Lecture en boucle ; aucune pause dessinée |
| Suivre la lecture d'une vidéo | Fine ligne blanche collée au menu, avec un point au bout | Progression de la vidéo | Se remplit puis repart ; on ne peut pas la faire glisser |
| Faire défiler un carrousel | Glisser à gauche ou à droite entre 3 à 5 photos, environ 35 % des posts | Photo affichée | Une photo à la fois |
| Voir la position dans le carrousel | Points centrés juste au-dessus du pseudo, sans fond | Numéro de la photo, nombre total | Point blanc plein = photo affichée ; autres semi-transparents |
| Lire un carrousel de pause | Post de @fakescrolling tous les 5 à 8 posts : 4 phrases courtes, une par photo | Une des 5 séries de phrases | Fond pastel différent par phrase ; masqué si l'interrupteur de P-23 est désactivé |
| Suivre un post Inspire / Expire | Cercle qui grandit et rétrécit avec « Inspire » puis « Expire », environ 1 post sur 8 | Cycle de 8 s | Animation continue ; figée si l'appareil réduit les animations |
| Voir un post Premium | Après 1 h dans l'app, 1 post sur 20 propose de soutenir le projet | Temps passé, icône du thème, prix 1,99 € | Absent avant 1 h ou si déjà soutenu |
| Soutenir le projet | Bouton noir « Soutenir le projet » du post Premium | Achat 1,99 € (paiement par le store : à confirmer) | Bouton ; puis « Merci pour ton soutien. » ; aucun échec dessiné |
| Liker un post par double tap | Double tap sur l'image : grand cœur animé | Like du post (+1) | Animation du cœur ; ne retire jamais le like |
| Liker ou retirer son like | Cœur blanc dans la colonne de droite | Nombre de likes | Vide blanc ; plein rose quand liké |
| Ouvrir les commentaires | Bulle dans la colonne de droite, ouvre P-05 | Nombre de commentaires (+ les miens) | — |
| Enregistrer un post | Signet dans la colonne de droite, ouvre P-06 | Nombre d'enregistrements | Vide ; plein quand enregistré |
| Partager un post | Flèche dans la colonne de droite, ouvre P-07 | Nombre de partages | — |
| Voir la photo du publieur | Rond en haut de la colonne de droite | Photo floue du publieur | Non cliquable |
| Lire le pseudo du publieur | Nom en blanc au-dessus de la légende | Pseudo en charabia | — |
| Lire la légende | Texte blanc en bas, sans fond | Légende en charabia + émojis | Tronquée au-delà d'environ 80 caractères |
| Déplier ou replier la légende | Lien « plus » ou « moins » à la fin du texte | Légende complète | Repliée ; dépliée |
| Ouvrir les notifications | Cloche blanche en haut à droite, ouvre P-04 | Nombre de nouveautés | Pastille rouge avec chiffre ; sans pastille quand tout est vu |
| Lire une confirmation | Message noir en bas après une action | Texte de l'action (enregistré, lien copié, partagé, envoyé à un ami) | Visible 2 s puis disparaît |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés, durée réglée dans P-17 | De couleur à noir et blanc après 10 cycles ; aucun message |
| Ouvrir l'Accueil | Icône maison du menu du bas | Aucune | Active (verte) sur cette page |
| Ouvrir Messages | Icône bulle du menu du bas, ouvre P-08 | Aucune | Inactive (grise) |
| Publier un post | Bouton + noir au centre du menu, ouvre P-12 | Aucune | — |
| Ouvrir la Recherche | Icône loupe du menu du bas, ouvre P-14 | Aucune | Inactive (grise) |
| Ouvrir le Profil | Icône silhouette du menu du bas, ouvre P-17 | Aucune | Inactive (grise) |

## P-04 Accueil — panneau Notifications

Panneau centré sous la cloche, par-dessus le fil : invitations d'amis puis likes reçus.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer les notifications | Tap sur la partie assombrie autour du panneau | Aucune | — |
| Faire défiler les notifications | Liste qui défile, sans barre de défilement | Aucune | — |
| Voir les invitations d'amis | Section « Invitations » : photo floue, pseudo, @ | 3 demandes en démo (vraies demandes : à confirmer) | Section masquée quand toutes sont refusées |
| Accepter une invitation | Bouton vert « Accepter » | Statut de la demande | Devient « Ami » en vert |
| Refuser une invitation | Bouton « Refuser » | Statut de la demande | La ligne disparaît |
| Voir les likes reçus | Section « Likes » : photo floue, « X a aimé ton post · 9 min » | 7 likes en démo, pseudo, ancienneté | Pas d'état vide dessiné |
| Voir le post liké | Miniature carrée à droite de chaque like | Aperçu du post | Non cliquable (ouverture du post : à confirmer) |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-05 Accueil — panneau Commentaires

Panneau qui monte du bas sur un post : on lit, on like et on publie des commentaires.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer les commentaires | Croix en haut à droite ou tap sur le fond assombri | Aucune | — |
| Lire les commentaires | Liste : photo floue, pseudo · ancienneté, texte | 6 commentaires en démo + les miens en tête ; texte en charabia + émojis | Pas d'état vide ni de chargement dessiné |
| Liker un commentaire | Petit cœur à droite de chaque commentaire, compteur dessous | Nombre de likes du commentaire | Vide gris ; plein rouge quand liké (+1) |
| Écrire un commentaire | Champ « Ajouter un commentaire… » en bas, avec sa photo | Texte (150 caractères max) | Vide ; rempli |
| Publier un commentaire | Bouton « Publier » à droite du champ | Nouveau commentaire signé moi.ici · à l'instant ; compteur du post +1 | Gris si champ vide ; texte tapé visible moins d'1 s puis charabia (émojis gardés) |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-06 Accueil — panneau Enregistrer dans une collection

Panneau qui monte du bas : on range le post dans une collection.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer le panneau | Croix ou tap sur le fond assombri | Aucune | — |
| Enregistrer dans une collection | Ligne par collection avec pastille de couleur et nom | 3 collections par défaut : Pour plus tard, Formes calmes, Couleurs à garder | Collection choisie encadrée en vert avec « enregistré » ; le panneau se ferme |
| Retirer d'une collection | Tap sur la collection déjà choisie | Enregistrement du post | Message « Retiré de … » |
| Créer une collection | Ligne en pointillé « Nouvelle collection » | Nouvelle collection nommée automatiquement « Collection 4 »… (saisie du nom : à confirmer) | Le post y est enregistré aussitôt |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-07 Accueil — panneau Partager

Panneau qui monte du bas : trois façons de partager le post.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer le panneau | Croix ou tap sur le fond assombri | Aucune | — |
| Envoyer à un ami | Rangée d'amis en tête du panneau ; un tap envoie le post à cet ami | Post envoyé en message (réception côté ami : à confirmer) ; message « Envoyé à … » sur P-03 | — |
| Copier le lien | Ligne qui copie le lien du post | Lien du post (copie réelle : à confirmer) | Message « Lien copié. Il mène à une version floutée. » |
| Partager ailleurs | Ligne vers d'autres apps | Post (feuille de partage du téléphone : à confirmer) | Message « Partagé, flouté comme toujours. » |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-08 Messages — liste des discussions

Titre, loupe et + en haut, rangée de stories, puis la liste des discussions.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Rechercher une discussion | Petite loupe en haut à droite, ouvre un champ « Rechercher » sous le titre | Texte saisi ; filtre par prénom ou @ | Champ masqué ; affiché ; liste filtrée ; liste vide sans message si rien ne correspond |
| Ajouter un ami | Bouton + en haut à droite, ouvre P-11 | Aucune | — |
| Ajouter à sa story | Premier rond « Ta story » avec un + vert, ouvre P-12 avec Story présélectionnée | Destination de publication : Story | — |
| Voir la story d'un ami depuis la rangée | Rond cerclé avec le prénom dessous, ouvre P-10 | 6 amis avec une story en démo | Cercle vert = non vue ; gris = vue |
| Faire défiler les stories | Glisser la rangée de gauche à droite | Aucune | — |
| Voir la story d'un ami depuis la liste | Tap sur la photo cerclée d'une discussion, ouvre P-10 | Story de l'ami | Cercle vert ou gris ; photo sans cercle si pas de story |
| Ouvrir une discussion | Tap sur le nom ou l'aperçu, ouvre P-09 | Discussion ; passe en lu | — |
| Lire l'aperçu d'une discussion | Pseudo, dernier message (« Toi : », « Photo ») · heure | 8 discussions en démo, texte en charabia | Non lu : gras et point bleu ; lu : normal ; pas d'état vide dessiné |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |
| Ouvrir l'Accueil | Icône maison du menu du bas, ouvre P-03 | Aucune | Inactive (grise) |
| Ouvrir Messages | Icône bulle du menu du bas | Aucune | Active (verte) sur cette page |
| Publier un post | Bouton + noir au centre du menu, ouvre P-12 | Aucune | — |
| Ouvrir la Recherche | Icône loupe du menu du bas, ouvre P-14 | Aucune | Inactive (grise) |
| Ouvrir le Profil | Icône silhouette du menu du bas, ouvre P-17 | Aucune | Inactive (grise) |

## P-09 Messages — conversation

Fil de discussion avec un ami ; le menu du bas est masqué.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Revenir aux discussions | Flèche en haut à gauche, ouvre P-08 | Aucune | — |
| Voir la story du contact | Tap sur sa photo cerclée en haut, ouvre P-10 | Story du contact | Cercle vert ou gris ; sans cercle si pas de story |
| Lire le nom du contact | Pseudo et @ en haut | Pseudo en charabia, @ en clair | — |
| Appeler le contact | Icône téléphone en haut à droite | Aucune | Sans effet dans la maquette (appel : à confirmer) |
| Lire les messages | Bulles vertes (moi) à droite, grises (contact) à gauche, repère « Aujourd'hui » | Messages en charabia + émojis | Pas d'état vide ni de chargement dessiné |
| Voir une photo envoyée ou reçue | Image dans le fil de messages | Photo floutée | — |
| Répondre à un message | Glisser un message vers la droite | Message cité | Flèche de réponse qui apparaît ; sélectionné au-delà d'un seuil |
| Voir le message cité | Bandeau « Réponse à … » au-dessus du champ, puis petite bulle au-dessus du message envoyé | Extrait du message cité | — |
| Annuler la réponse | Croix dans le bandeau « Réponse à … » | Message cité | Bandeau disparaît |
| Écrire un message | Champ « Message… » en bas | Texte saisi | Vide ; rempli |
| Envoyer un message | « Envoyer » apparaît dans la bulle dès qu'on tape | Nouveau message | Texte tapé visible moins d'1 s puis charabia (émojis gardés) ; pas d'échec d'envoi dessiné |
| Envoyer une photo | Icône image tout à droite dans la bulle, visible quand le champ est vide | Photo floutée (choix de la photo : à confirmer, la maquette envoie une image de démo) | Masquée quand on tape |
| Voir que le contact écrit | Bulle grise à trois points | Saisie du contact | Réponse automatique de démo (vraies réponses : à confirmer) |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-10 Messages — lecteur de story

Story d'un ami en plein écran, image par image.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Regarder une story | Image plein écran, parfois avec un court texte | Image floutée ; texte en charabia + émoji | — |
| Suivre la progression | Barres fines en haut, une par image | 2 ou 3 images, 5 s chacune | Barre en cours qui se remplit ; passées pleines ; à venir vides |
| Passer à l'image suivante | Tap sur les deux tiers droits de l'écran | Image affichée | Ferme la story après la dernière |
| Revenir à l'image précédente | Tap sur le tiers gauche de l'écran | Image affichée | Reste sur la première |
| Voir l'auteur de la story | Photo, prénom et ancienneté en haut | Prénom en charabia, « 2 h »… | — |
| Fermer la story | Croix en haut à droite, ou fin automatique | Story marquée vue | Cercle gris ensuite dans P-08 et P-09 |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-11 Messages — Ajouter un ami

On cherche un compte par son @ et on lui envoie une demande d'ami.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Revenir à la liste | Flèche en haut à gauche, ouvre P-08 | Aucune | — |
| Saisir un identifiant | Champ précédé d'un @, prêt à taper | Identifiant (minuscules, sans espace) | Vide ; rempli |
| Voir les comptes trouvés | Lignes : photo floue, @, pseudo | Jusqu'à 8 comptes dont le @ commence par la saisie (annuaire de 20 comptes en démo ; vrai annuaire : à confirmer) | Rien tant que le champ est vide ; liste de résultats |
| Envoyer une demande d'ami | Bouton vert « Ajouter » | Demande d'ami | Devient « Demandé », gris et désactivé |
| Voir qu'un compte est déjà ami | Bouton « Ami » gris et désactivé | Lien d'amitié existant | — |
| Lire l'absence de résultat | Texte « Aucun compte trouvé. » | Aucune | Affiché si rien ne correspond |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-12 Nouveau post — choix des photos

Première étape de publication : aperçu carré en haut, galerie en dessous ; le menu du bas est masqué.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer la création | Croix en haut à gauche, ouvre P-03 | Brouillon abandonné (sauvegarde : à confirmer) | — |
| Voir l'aperçu de la photo | Grand carré sous le titre | Photo affichée | — |
| Voir sa position dans la sélection | Pastille « 2/4 » sur l'aperçu | Rang de la photo, nombre choisi | Visible seulement en sélection multiple |
| Choisir un album | Bouton « Récents » avec chevron | Album (liste des albums : à confirmer) | Sans effet dans la maquette |
| Activer la sélection multiple | Rond à deux carrés à droite de « Récents » | Mode simple ou multiple | Fond noir quand actif ; repasse à une seule photo quand on désactive |
| Ouvrir l'appareil photo | Rond avec appareil photo | Aucune (prise de photo : à confirmer) | Sans effet dans la maquette |
| Choisir une photo | Tap dans la grille de 4 colonnes | 24 photos de démo (vraie galerie et autorisation : à confirmer) | Photo affichée voilée de blanc ; en multiple : numéro de 1 à 10, second tap retire |
| Passer à la légende | Lien « Suivant » en haut à droite, ouvre P-13 | Photos choisies | Toujours actif (au moins une photo choisie) |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-13 Nouveau post — légende

Deuxième étape : légende, destination (fil ou story), options, puis publication.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Revenir aux photos | Flèche en haut à gauche, ouvre P-12 | Photos choisies conservées | — |
| Voir la miniature du post | Petit carré à gauche du champ | Première photo choisie | Pastille avec le nombre de photos si carrousel |
| Écrire une légende | Champ « Écris une légende… » | Légende (pas de limite de longueur affichée) | Vide ; rempli |
| Choisir où publier | Choix « Publier dans » : Fil d'actualité ou Story | Destination du post | Fil d'actualité par défaut ; Story présélectionnée si l'on vient de « Ta story » (P-08) |
| Identifier des personnes | Ligne avec chevron, ouvre P-24 | Personnes identifiées | Vide ; @ de la personne ; « N personnes » |
| Ajouter un lieu | Ligne avec chevron, ouvre P-25 | Lieu | Vide ; nom du lieu choisi |
| Choisir l'audience | Ligne « Audience » avec la valeur à droite, ouvre P-26 | Tout le monde, Amis ou Amis proches | Valeur choisie affichée |
| Partager le post | Bouton vert « Partager dans le fil » (ouvre P-03) ou « Partager en story » (ouvre P-08) | Post publié (envoi, flou et charabia côté amis : à confirmer) | Libellé selon la destination ; aucun envoi en cours, succès ni erreur dessiné |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-14 Recherche — suggestions et tendances

Champ de recherche vide : suggestions puis tendances.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Saisir une recherche | Champ « Rechercher » en haut, ouvre P-15 dès qu'on tape | Texte saisi | Vide (cet écran) |
| Lancer une suggestion | 8 lignes empilées : loupe, texte, flèche en diagonale | Recherches en charabia (« vralo mizé »…) ; origine des suggestions : à confirmer | Remplit le champ et ouvre P-15 |
| Lancer une tendance | 6 lignes classées : rang, texte, nombre de posts, 3 bandes de couleur | Recherche en charabia, « 24,1 k posts » (chiffres de démo), palette d'arrivée | Remplit le champ et ouvre P-15 |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |
| Ouvrir l'Accueil | Icône maison du menu du bas, ouvre P-03 | Aucune | Inactive (grise) |
| Ouvrir Messages | Icône bulle du menu du bas, ouvre P-08 | Aucune | Inactive (grise) |
| Publier un post | Bouton + noir au centre du menu, ouvre P-12 | Aucune | — |
| Ouvrir la Recherche | Icône loupe du menu du bas | Aucune | Active (verte) sur cette page |
| Ouvrir le Profil | Icône silhouette du menu du bas, ouvre P-17 | Aucune | Inactive (grise) |

## P-15 Recherche — résultats

Toute recherche non vide donne une grille de posts dans l'une des 5 palettes.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Modifier la recherche | Champ « Rechercher » en haut | Texte saisi ; palette = somme des codes des caractères modulo 5 | Les résultats changent à chaque frappe |
| Revenir aux suggestions | Vider le champ, retour à P-14 | Aucune | — |
| Parcourir les résultats | Grille de 3 colonnes, tuiles verticales | 18 posts de la palette (soleil, océan, forêt, lavande ou terre), nombre de likes | Toujours 18 ; aucun chargement ni « aucun résultat » dessiné |
| Ouvrir un résultat | Tap sur une tuile, ouvre P-16 | Post choisi | — |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |
| Ouvrir l'Accueil | Icône maison du menu du bas, ouvre P-03 | Aucune | Inactive (grise) |
| Ouvrir Messages | Icône bulle du menu du bas, ouvre P-08 | Aucune | Inactive (grise) |
| Publier un post | Bouton + noir au centre du menu, ouvre P-12 | Aucune | — |
| Ouvrir la Recherche | Icône loupe du menu du bas | Aucune | Active (verte) sur cette page |
| Ouvrir le Profil | Icône silhouette du menu du bas, ouvre P-17 | Aucune | Inactive (grise) |

## P-16 Recherche — post ouvert

Un résultat en plein écran, par-dessus la grille ; le menu du bas reste visible.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Revenir aux résultats | Flèche blanche en haut à gauche, ouvre P-15 | Aucune | — |
| Voir le post | Image plein écran aux couleurs de la palette | Formes du post | — |
| Lire le pseudo du publieur | Nom en blanc en bas | Pseudo en charabia | — |
| Lire la légende | Texte blanc sous le pseudo | Légende en charabia + émoji | Jamais tronquée |
| Liker, commenter, enregistrer, partager | Absents de cet écran | Aucune | Non dessinés (à confirmer : mêmes actions que P-03 ?) |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |
| Ouvrir l'Accueil | Icône maison du menu du bas, ouvre P-03 | Aucune | Inactive (grise) |
| Ouvrir Messages | Icône bulle du menu du bas, ouvre P-08 | Aucune | Inactive (grise) |
| Publier un post | Bouton + noir au centre du menu, ouvre P-12 | Aucune | — |
| Ouvrir la Recherche | Icône loupe du menu du bas, ouvre P-14 | Aucune | Active (verte) sur cette page |
| Ouvrir le Profil | Icône silhouette du menu du bas, ouvre P-17 | Aucune | Inactive (grise) |

## P-17 Profil

Son propre profil : identité, minuteur de couleur, puis ses posts.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Ouvrir les options | Engrenage en haut à gauche, ouvre P-20 | Aucune | — |
| Modifier le profil | Lien « Modifier » en haut à droite, ouvre P-19 | Aucune | — |
| Lire son pseudo | Grand titre sur une ligne, à gauche de la photo | Pseudo en charabia, 16 caractères max | Texte tapé visible moins d'1 s après modification, puis charabia |
| Lire son @ | Identifiant sous le pseudo | @moi.ici, en clair | — |
| Voir ses compteurs | Ligne « 12 posts · 48 amis · 1 204 likes », chiffres en gras | Nombres fixes en démo (calcul réel : à confirmer) | — |
| Lire sa description | Paragraphe sous la photo | Description en charabia + émojis, 80 caractères max | Même bascule que le pseudo après modification |
| Changer sa photo de profil | Photo ronde à droite avec badge appareil photo, ouvre P-18 | Photo floutée | Nette environ 1 s après un changement, puis floutée |
| Suivre le minuteur | Titre « Minuteur » et ligne d'état | Cycle en cours sur 10, % de gris, temps restant (mm:ss) | Après 10 cycles : « Noir et blanc. Réinitialise pour retrouver les couleurs. » |
| Voir l'avancement des cycles | 10 segments sous la ligne d'état | Cycles écoulés | Gris foncé = passé ou en cours ; gris clair = à venir |
| Allonger le cycle | Petite flèche haut dans la case « 2 min », à droite | Durée : 1, 2, 3, 5, 10, 15, 20 ou 30 min (2 par défaut) | Flèche grisée à 30 min |
| Raccourcir le cycle | Petite flèche bas dans la même case | Durée du cycle | Flèche grisée à 1 min |
| Réinitialiser les cycles | Bouton « Réinitialiser » sous la case, à droite | Repart du cycle 1, couleurs revenues partout | — |
| Voir ses posts | Titre « Tes posts, tels que les voient tes amis » et grille de 3 colonnes | 9 posts floutés, jours restants (« 7 j ») | Non cliquables ; pas d'état vide dessiné |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |
| Ouvrir l'Accueil | Icône maison du menu du bas, ouvre P-03 | Aucune | Inactive (grise) |
| Ouvrir Messages | Icône bulle du menu du bas, ouvre P-08 | Aucune | Inactive (grise) |
| Publier un post | Bouton + noir au centre du menu, ouvre P-12 | Aucune | — |
| Ouvrir la Recherche | Icône loupe du menu du bas, ouvre P-14 | Aucune | Inactive (grise) |
| Ouvrir le Profil | Icône silhouette du menu du bas | Aucune | Active (verte) sur cette page |

## P-18 Profil — panneau Photo de profil

Panneau qui monte du bas pour changer de photo de profil.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer le panneau | Croix ou tap sur le fond assombri | Aucune | — |
| Choisir dans sa galerie | Bouton noir « Choisir dans ta galerie » | Vraie image de l'appareil (autorisation d'accès : à confirmer) | Aucune erreur dessinée (fichier refusé, accès refusé) |
| Choisir une image de démo | 4 ronds sous « Ou une image de démo » | Image choisie | Image actuelle cerclée de noir ; le panneau se ferme et P-17 montre la photo nette puis floutée ; propre à la maquette, hors registre (décision D-020) |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-19 Modifier le profil

Page plein écran pour changer son pseudo et sa description (pas le @).

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Annuler la modification | Lien « Annuler » en haut à gauche, revient à P-17 | Saisies abandonnées | — |
| Saisir son pseudo | Champ « Pseudo », compteur « 0/16 » dessous | Pseudo (16 caractères max) | Prérempli avec le pseudo actuel ; frappe bloquée à 16 |
| Saisir sa description | Champ « Description » sur 3 lignes, compteur « 0/80 » dessous | Description (80 caractères max) | Préremplie ; frappe bloquée à 80 |
| Enregistrer le profil | Lien vert « Enregistrer » en haut à droite, revient à P-17 | Pseudo et description | Pseudo vide : l'ancien est gardé ; aucun état d'envoi ni d'erreur dessiné |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-20 Panneau Options

Panneau qui glisse depuis la gauche et couvre la moitié de l'écran du Profil.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Voir les options | Titre « Options » et trois lignes icône + texte | Aucune | Entrée en glissant depuis la gauche ; le reste de l'écran s'assombrit |
| Gérer son compte | Ligne « Gérer mon compte », ouvre P-21 | Aucune | — |
| Ouvrir Premium | Ligne « Premium », ouvre P-22 | Aucune | — |
| Régler l'interface | Ligne « Interface de l'appli », ouvre P-23 | Aucune | — |
| Fermer les options | Tap sur la partie assombrie | Aucune | Sortie en glissant vers la gauche |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-21 Mon compte

Pour l'instant, la page ne permet que de supprimer son compte.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Revenir aux options | Flèche en haut à gauche, rouvre le panneau Options (P-20) | Aucune | — |
| Voir son identifiant | « Compte » puis @moi.ici | @ en clair | — |
| Supprimer son compte | Bouton rouge encadré « Supprimer mon compte » | Aucune | Ouvre une confirmation |
| Confirmer la suppression | Fenêtre « Supprimer ton compte ? » : posts, messages et amis effacés, définitif ; bouton rouge « Supprimer définitivement » | Compte, posts, messages, amis (effacement réel et déconnexion : à confirmer) | Puis état « Compte supprimé » + « Merci d'être passé·e. » ; aucun échec dessiné |
| Annuler la suppression | Bouton « Annuler » dans la fenêtre | Aucune | La fenêtre se ferme |
| Recommencer la démo | Lien souligné après la suppression | Compte rétabli | Propre à la maquette, hors registre (décision D-020) |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-22 Premium

Temps passé dans l'app et, après une heure, offre de soutien à 1,99 €.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Revenir aux options | Flèche en haut à gauche, rouvre le panneau Options (P-20) | Aucune | — |
| Voir l'en-tête Premium | Icône F, « PREMIUM », titre « Soutenir fake scrolling » | Thème d'icône choisi | Couleur selon le thème |
| Voir son temps passé | Grand anneau avec « 23 min » et « passées ici » | Temps passé sur tous les écrans | Anneau qui se remplit jusqu'à 1 h |
| Lire le temps restant | Deux lignes « Après une heure dans l'appli, / tu pourras soutenir le projet. » + « encore 37 min » | Minutes restantes avant 1 h | Avant 1 h seulement |
| Voir l'offre | Deux lignes « Une heure passée ici. / Soutiens un projet indépendant. », « 1,99 € », « un seul paiement » | Prix | À partir de 1 h |
| Soutenir le projet | Bouton noir arrondi « Soutenir le projet » | Achat 1,99 €, partagé avec le post Premium de P-03 (paiement par le store : à confirmer) | Puis « Merci pour ton soutien. » ; aucun échec ni annulation dessiné |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-23 Interface de l'appli

Choix du thème de l'icône, puis un interrupteur pour le fil.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Revenir aux options | Flèche en haut à gauche, rouvre le panneau Options (P-20) | Aucune | — |
| Voir la nouvelle icône | Grand carré arrondi avec un F blanc, « fake scrolling » dessous | Thème choisi | Noir ; dégradé orange ; rouge |
| Choisir un thème | Trois cases Noir, Orange, Rouge avec mini-icône | Thème, mémorisé et repris par P-01 et P-22 (changement réel de l'icône du téléphone : à confirmer) | Case choisie cerclée de noir |
| Activer les carrousels de pause | Interrupteur « Carrousels de pause », « Toutes les 5 à 8 publications. » | Réglage oui/non | Vert = actif ; gris = inactif : les carrousels de pause disparaissent du fil |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-24 Nouveau post — panneau Identifier des personnes

Panneau qui monte du bas sur P-13 pour identifier des amis dans le post.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer le panneau | Lien « OK » en haut à droite ou tap sur le fond assombri | Aucune | — |
| Rechercher un ami | Champ « Rechercher », filtre par pseudo ou @ | Texte saisi | Vide ; liste filtrée |
| Identifier un ami | Ligne avec photo floue, pseudo, @ et case ronde à cocher | Personnes identifiées (8 amis en démo ; vraie liste d'amis : à confirmer) | Case vide ; cochée en vert ; second tap décoche |
| Lire l'absence de résultat | Texte « Aucun ami trouvé. » | Aucune | Affiché si rien ne correspond |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-25 Nouveau post — panneau Ajouter un lieu

Panneau qui monte du bas sur P-13 pour rattacher un lieu au post.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer le panneau | Lien « OK » en haut à droite ou tap sur le fond assombri | Aucune | — |
| Rechercher un lieu | Champ « Rechercher », filtre par nom ou ville | Texte saisi | Vide ; liste filtrée |
| Choisir un lieu | Ligne avec icône, nom du lieu, quartier ou ville | Lieu du post (8 lieux de démo ; vraie recherche de lieux : à confirmer) | Lieu choisi coché ; le panneau se ferme |
| Retirer le lieu | Lien rouge « Retirer le lieu » en tête de liste | Lieu du post | Visible seulement si un lieu est choisi |
| Lire l'absence de résultat | Texte « Aucun lieu trouvé. » | Aucune | Affiché si rien ne correspond |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |

## P-26 Nouveau post — panneau Audience

Panneau qui monte du bas sur P-13 : qui peut voir le post.

| Élément | Description | Données | États visibles |
| --- | --- | --- | --- |
| Fermer le panneau | Lien « OK » en haut à droite ou tap sur le fond assombri | Aucune | — |
| Choisir l'audience | Titre « Qui peut voir ce post ? » et trois lignes : Tout le monde, Amis, Amis proches, chacune avec une phrase | Audience du post | Choix coché en vert ; le panneau se ferme |
| Voir l'app se griser | Toute la page perd 10 % de couleur par cycle | Cycles écoulés | De couleur à noir et blanc |
