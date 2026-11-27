<!-- Source: https://claude.ai/artifact/A5qaJU9xAkPWfJ6JUNfWHV, tab "Tab 1", rev 480, exported 2026-11-27 -->
# Registre canonique – Fake scrolling

Nov 19, 2026 · @Jp

## YAML

Le registre en vigueur, en blocs YAML lus dans l'ordre comme un seul fichier (importé en claude\_docs/registry.md). Pour le lire en tableau, interroger la base du registre (registry-db) ; la doc ne garde que le YAML et ses notes (D-039).

```yaml
roles:
  - id: R-01
    nom: Personne non connectée
    portee: 'aucun compte : session non authentifiée sur l''appareil ; le backend détecte ensuite s''il faut passer à l''inscription'
  - id: R-02
    nom: Utilisateur connecté
    portee: son propre compte

pages:
  - id: P-01
    nom: Connexion
    plateforme: mobile
    features: [F-001, F-001.a, F-002, F-003, F-004]
  - id: P-01.a
    nom: 'Compte tiers : chargement'
    plateforme: mobile
    features: [F-001]
  - id: P-01.b
    nom: 'Compte tiers : erreur'
    plateforme: mobile
    features: [F-001]
  - id: P-01.c
    nom: Adresse invalide
    plateforme: mobile
    features: [F-003]
  - id: P-01.d
    nom: Envoi du code
    plateforme: mobile
    features: [F-003]
  - id: P-01.e
    nom: 'Envoi du code : erreur'
    plateforme: mobile
    features: [F-003]
  - id: P-02
    nom: Code reçu par e-mail
    plateforme: mobile
    features: [F-005, F-006, F-007, F-008]
  - id: P-02.a
    nom: Code faux
    plateforme: mobile
    features: [F-007]
  - id: P-02.b
    nom: Code expiré
    plateforme: mobile
    features: [F-007, F-008]
  - id: P-03
    nom: Accueil — fil
    plateforme: mobile
    features: [F-009, F-010, F-011, F-012, F-012.a, F-014, F-015.a, F-016, F-016.a, F-017, F-018, F-019, F-020, F-021, F-022, F-024, F-025, F-026, F-073]
  - id: P-03.a
    nom: 'Fil : chargement'
    plateforme: mobile
    features: [F-009]
  - id: P-03.b
    nom: 'Fil : erreur de chargement'
    plateforme: mobile
    features: [F-009]
  - id: P-03.c
    nom: Paiement échoué
    plateforme: mobile
    features: [F-015.a]
  - id: P-03.d
    nom: Post publié
    plateforme: mobile
    features: [F-051]
  - id: P-03.e
    nom: Like non enregistré
    plateforme: mobile
    features: [F-016]
  - id: P-03.f
    nom: 'Enregistrement : échec'
    plateforme: mobile
    features: [F-018]
  - id: P-04
    nom: Accueil — panneau Notifications
    plateforme: mobile
    features: [F-022, F-024, F-027.a, F-028, F-028.a, F-073]
  - id: P-04.a
    nom: Aucune notification
    plateforme: mobile
    features: [F-022]
  - id: P-04.b
    nom: 'Notifications : chargement'
    plateforme: mobile
    features: [F-022]
  - id: P-04.c
    nom: 'Notifications : erreur'
    plateforme: mobile
    features: [F-022]
  - id: P-04.d
    nom: 'Invitation : réponse en cours'
    plateforme: mobile
    features: [F-028]
  - id: P-04.e
    nom: 'Invitation : erreur'
    plateforme: mobile
    features: [F-028]
  - id: P-05
    nom: Panneau Commentaires
    plateforme: mobile
    features: [F-016.b, F-017, F-024, F-027, F-030, F-073]
  - id: P-05.a
    nom: 'Commentaires : chargement'
    plateforme: mobile
    features: [F-017]
  - id: P-05.b
    nom: Aucun commentaire
    plateforme: mobile
    features: [F-017]
  - id: P-05.c
    nom: Commentaire non publié
    plateforme: mobile
    features: [F-030]
  - id: P-05.d
    nom: 'Commentaires : erreur'
    plateforme: mobile
    features: [F-017]
  - id: P-06
    nom: Panneau Enregistrer dans une collection
    plateforme: mobile
    features: [F-018, F-024, F-027, F-031, F-073]
  - id: P-06.a
    nom: 'Nouvelle collection : création'
    plateforme: mobile
    features: [F-031]
  - id: P-06.b
    nom: 'Nouvelle collection : erreur'
    plateforme: mobile
    features: [F-031]
  - id: P-07
    nom: Panneau Partager
    plateforme: mobile
    features: [F-019.a, F-019.b, F-019.c, F-024, F-027, F-073]
  - id: P-07.a
    nom: 'Envoi à un ami : échec'
    plateforme: mobile
    features: [F-019.a]
  - id: P-08
    nom: Messages — liste des discussions
    plateforme: mobile
    features: [F-024, F-025, F-026, F-026.a, F-033, F-034, F-036, F-037, F-073]
  - id: P-08.a
    nom: Aucune discussion
    plateforme: mobile
    features: [F-037, F-034]
  - id: P-08.b
    nom: Story publiée
    plateforme: mobile
    features: [F-051]
  - id: P-08.c
    nom: 'Discussions : chargement'
    plateforme: mobile
    features: [F-037]
  - id: P-08.d
    nom: 'Discussions : erreur'
    plateforme: mobile
    features: [F-037]
  - id: P-09
    nom: Messages — conversation
    plateforme: mobile
    features: [F-005, F-024, F-036, F-038, F-039, F-040, F-041, F-042, F-073]
  - id: P-09.a
    nom: 'Conversation : chargement'
    plateforme: mobile
    features: [F-038]
  - id: P-09.b
    nom: Aucun message
    plateforme: mobile
    features: [F-038]
  - id: P-09.c
    nom: Message non envoyé
    plateforme: mobile
    features: [F-041]
  - id: P-09.d
    nom: 'Conversation : erreur'
    plateforme: mobile
    features: [F-038]
  - id: P-09.e
    nom: Photo non envoyée
    plateforme: mobile
    features: [F-042]
  - id: P-10
    nom: Messages — lecteur de story
    plateforme: mobile
    features: [F-024, F-036, F-073]
  - id: P-10.a
    nom: 'Story : chargement'
    plateforme: mobile
    features: [F-036]
  - id: P-10.b
    nom: 'Story : erreur'
    plateforme: mobile
    features: [F-036]
  - id: P-11
    nom: Messages — Ajouter un ami
    plateforme: mobile
    features: [F-005, F-024, F-034, F-043, F-073]
  - id: P-11.a
    nom: 'Recherche de comptes : chargement'
    plateforme: mobile
    features: [F-043]
  - id: P-11.b
    nom: 'Recherche de comptes : erreur'
    plateforme: mobile
    features: [F-043]
  - id: P-11.c
    nom: 'Demande d’ami : envoi'
    plateforme: mobile
    features: [F-034]
  - id: P-11.d
    nom: 'Demande d’ami : erreur'
    plateforme: mobile
    features: [F-034]
  - id: P-12
    nom: Nouveau post — choix des photos
    plateforme: mobile
    features: [F-005.a, F-024, F-044, F-045, F-046, F-046.a, F-073]
  - id: P-12.a
    nom: Galerie vide
    plateforme: mobile
    features: [F-044, F-046.a]
  - id: P-12.b
    nom: Accès aux photos refusé
    plateforme: mobile
    features: [F-044]
  - id: P-13
    nom: Nouveau post — légende
    plateforme: mobile
    features: [F-005, F-024, F-047, F-048, F-049, F-050, F-051, F-068, F-073]
  - id: P-13.a
    nom: Publication en cours
    plateforme: mobile
    features: [F-051]
  - id: P-13.b
    nom: 'Publication : erreur'
    plateforme: mobile
    features: [F-051]
  - id: P-13.c
    nom: Transformation avant publication
    plateforme: mobile
    features: [F-051]
  - id: P-14
    nom: Recherche — suggestions et tendances
    plateforme: mobile
    features: [F-024, F-025, F-026, F-052, F-053, F-053.a, F-073]
  - id: P-14.a
    nom: 'Suggestions : chargement'
    plateforme: mobile
    features: [F-053]
  - id: P-14.b
    nom: 'Suggestions : erreur'
    plateforme: mobile
    features: [F-053]
  - id: P-15
    nom: Recherche — résultats
    plateforme: mobile
    features: [F-024, F-025, F-026, F-052, F-054, F-073]
  - id: P-15.a
    nom: 'Recherche : chargement'
    plateforme: mobile
    features: [F-052]
  - id: P-15.b
    nom: Aucun résultat
    plateforme: mobile
    features: [F-052]
  - id: P-15.c
    nom: 'Recherche : erreur'
    plateforme: mobile
    features: [F-052]
  - id: P-16
    nom: Recherche — post ouvert
    plateforme: mobile
    features: [F-005, F-009.a, F-010.a, F-016, F-016.a, F-017, F-018, F-019, F-020, F-021, F-024, F-025, F-026, F-073]
  - id: P-17
    nom: Profil
    plateforme: mobile
    features: [F-024, F-025, F-026, F-055, F-056, F-057, F-058, F-059, F-060, F-061, F-062, F-073]
  - id: P-17.a
    nom: Aucun post
    plateforme: mobile
    features: [F-062, F-026]
  - id: P-17.b
    nom: 'Mes posts : chargement'
    plateforme: mobile
    features: [F-062]
  - id: P-17.c
    nom: 'Mes posts : erreur'
    plateforme: mobile
    features: [F-062]
  - id: P-18
    nom: Profil — panneau Photo de profil
    plateforme: mobile
    features: [F-024, F-027, F-058, F-073]
  - id: P-18.a
    nom: 'Photo : erreur de fichier'
    plateforme: mobile
    features: [F-058]
  - id: P-19
    nom: Modifier le profil
    plateforme: mobile
    features: [F-005.b, F-024, F-056, F-073]
  - id: P-19.a
    nom: 'Profil : enregistrement'
    plateforme: mobile
    features: [F-056]
  - id: P-19.b
    nom: 'Profil : erreur'
    plateforme: mobile
    features: [F-056]
  - id: P-20
    nom: Panneau Options
    plateforme: mobile
    features: [F-024, F-027.b, F-055, F-073]
  - id: P-21
    nom: Mon compte
    plateforme: mobile
    features: [F-005, F-024, F-057.a, F-063, F-071, F-073]
  - id: P-21.a
    nom: Suppression échouée
    plateforme: mobile
    features: [F-063]
  - id: P-22
    nom: Premium
    plateforme: mobile
    features: [F-002.a, F-005, F-015, F-024, F-065, F-073]
  - id: P-22.a
    nom: Paiement échoué
    plateforme: mobile
    features: [F-015]
  - id: P-22.b
    nom: Paiement annulé
    plateforme: mobile
    features: [F-015]
  - id: P-23
    nom: Interface de l'appli
    plateforme: mobile
    features: [F-002.b, F-005, F-024, F-066, F-067, F-073]
  - id: P-24
    nom: Nouveau post — panneau Identifier des personnes
    plateforme: mobile
    features: [F-024, F-027, F-048, F-073]
  - id: P-25
    nom: Nouveau post — panneau Ajouter un lieu
    plateforme: mobile
    features: [F-024, F-027, F-049, F-073]
  - id: P-26
    nom: Nouveau post — panneau Audience
    plateforme: mobile
    features: [F-024, F-027, F-050, F-072, F-073]
  - id: P-27
    nom: Inscription
    plateforme: mobile
    features: [F-005, F-070]
  - id: P-27.a
    nom: Création du compte
    plateforme: mobile
    features: [F-070]
  - id: P-27.b
    nom: 'Création : erreur'
    plateforme: mobile
    features: [F-070]
  - id: P-28
    nom: Nouveau post — panneau Amis proches
    plateforme: mobile
    features: [F-024, F-027, F-072, F-073]
  - id: P-29
    nom: Mise à jour requise
    plateforme: mobile
    features: [F-002, F-074]
```

```yaml
features:

  - id: F-001
    nom: Se connecter avec un compte tiers
    description: Bouton qui connecte via un fournisseur externe puis ouvre l'Accueil.
    pages: [P-01, P-01.a, P-01.b]
    plateformes: [mobile]
    acces: [R-01]
    variantes:
      - id: F-001.a
        pages: [P-01]
        plateforme: mobile
        difference: 'Apple au lieu de Google : bouton noir, compte Apple'
    entites: [E-02, E-01]
    operations: [lecture, écriture]
    etats_ui:
      - normal
      - 'chargement : « Connexion avec Google… » dans le bouton'
      - 'erreur : « La connexion avec Google n’a pas abouti. Réessaie, ou utilise ton adresse e-mail. » au-dessus des boutons'
      - mêmes états pour Apple (F-001.a), par analogie (D-036)
    questions_ouvertes:
      - Écran d'autorisation du fournisseur non dessiné
      - Logos officiels Google et Apple à intégrer

  - id: F-002
    nom: Afficher l'icône de l'appli
    description: Carré arrondi avec un F blanc dont la couleur suit le thème choisi sur ce téléphone (D-103).
    pages: [P-01, P-22, P-23, P-29]
    plateformes: [mobile]
    acces: [R-01, R-02]
    variantes:
      - id: F-002.a
        pages: [P-22]
        plateforme: mobile
        difference: Petite icône en tête de la page Premium, sans le nom de l'appli
        acces: [R-02]
      - id: F-002.b
        pages: [P-23]
        plateforme: mobile
        difference: Grand aperçu « nouvelle icône » avec le nom de l'appli dessous
        acces: [R-02]
    entites: [E-17]
    operations: [lecture]
    etats_ui:
      - thème Noir
      - thème Orange (dégradé)
      - thème Rouge
    questions_ouvertes: []

  - id: F-003
    nom: Demander un code par e-mail
    description: Saisie de l'adresse e-mail puis envoi d'un code à 6 chiffres.
    pages: [P-01, P-01.c, P-01.d, P-01.e]
    plateformes: [mobile]
    acces: [R-01]
    variantes: []
    entites: [E-02]
    operations: [écriture]
    etats_ui:
      - champ vide
      - champ rempli
      - bouton désactivé tant que l'adresse est invalide
      - bouton actif
      - 'adresse invalide : « Cette adresse e-mail n’est pas valide. » sous le champ, bouton désactivé'
      - 'envoi : anneau et « Envoi du code… » dans le bouton'
      - 'erreur : « Le code n’a pas pu être envoyé. Vérifie ta connexion et réessaie. » avec « Réessayer »'
    questions_ouvertes:
      - Envoi réel du mail à confirmer
      - 'Moment où le message d''adresse invalide apparaît : en tapant, ou en quittant le champ ?'

  - id: F-004
    nom: Lire la mention sans mot de passe
    description: Phrase qui explique qu'un code remplace le mot de passe.
    pages: [P-01]
    plateformes: [mobile]
    acces: [R-01]
    variantes: []
    entites: []
    operations: [lecture]
    etats_ui:
      - toujours affichée
    questions_ouvertes: []

  - id: F-005
    nom: Revenir à l'écran précédent
    description: Flèche retour en haut à gauche.
    pages: [P-02, P-09, P-11, P-12, P-13, P-16, P-19, P-21, P-22, P-23, P-27]
    plateformes: [mobile]
    acces: [R-01, R-02]
    variantes:
      - id: F-005.a
        pages: [P-12]
        plateforme: mobile
        difference: Croix « Fermer » qui abandonne la création du post et revient à la page d'où elle a été ouverte (D-062) ; ouverte depuis la Recherche (P-14 à P-16), sur P-14 (D-090) ; le serveur efface aussitôt les graines déjà envoyées du brouillon (D-121)
        acces: [R-02]
      - id: F-005.b
        pages: [P-19]
        plateforme: mobile
        difference: Lien « Annuler » qui abandonne les saisies du profil
        acces: [R-02]
    entites: [E-04]
    operations: [lecture, suppression]
    etats_ui: []
    questions_ouvertes: []

  - id: F-006
    nom: Lire la consigne du code
    description: Titre « Entre le code » et rappel du code à 6 chiffres envoyé par e-mail.
    pages: [P-02]
    plateformes: [mobile]
    acces: [R-01]
    variantes: []
    entites: [E-02]
    operations: [lecture]
    etats_ui:
      - toujours affichée
    questions_ouvertes:
      - L'adresse e-mail n'est pas rappelée

  - id: F-007
    nom: Se connecter avec le code
    description: Saisie du code en 6 cases puis bouton « Se connecter ».
    pages: [P-02, P-02.a, P-02.b]
    plateformes: [mobile]
    acces: [R-01]
    variantes: []
    entites: [E-02, E-01]
    operations: [lecture, écriture]
    etats_ui:
      - vide
      - case en cours encadrée
      - partiel
      - complet
      - bouton désactivé sous 6 chiffres
      - bouton actif
      - 'code faux : « Ce code n’est pas le bon. Vérifie-le et réessaie. », bouton « Se connecter » désactivé'
      - 'code expiré : « Ce code a expiré. Demande-en un nouveau. », « Se connecter » remplacé par « Renvoyer un code » (F-008)'
    questions_ouvertes:
      - Remplissage automatique depuis l'e-mail selon le téléphone

  - id: F-008
    nom: Renvoyer le code
    description: Compte à rebours de 30 s puis lien pour renvoyer un code.
    pages: [P-02, P-02.b]
    plateformes: [mobile]
    acces: [R-01]
    variantes: []
    entites: [E-02]
    operations: [lecture, écriture]
    etats_ui:
      - décompte 30 → 0
      - lien visible à 0 s
      - 'code expiré : bouton « Renvoyer un code » à la place de « Se connecter », sans décompte'
    questions_ouvertes: []

  - id: F-009
    nom: Faire défiler le fil
    description: Un post plein écran à la fois, par glisser, molette ou clavier ; 8 posts chargés près de la fin.
    pages: [P-03, P-03.a, P-03.b, P-16]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-009.a
        pages: [P-16]
        plateforme: mobile
        difference: 'Résultats de recherche : les 18 résultats, à partir de celui qu''on a touché ; ni chargement ni erreur de posts suivants (D-049)'
    entites: [E-03]
    operations: [lecture]
    etats_ui:
      - en cours de glisser
      - retour en place si glisser trop court
      - 'chargement : anneau et « Chargement des posts suivants… » en bas du fil'
      - 'erreur : « Les posts suivants n’ont pas pu être chargés. » avec « Réessayer » (D-032)'
    questions_ouvertes:
      - 'Post du lien partagé supprimé ou hors de son audience après la connexion (D-054)'
      - 'Quels posts montre le fil (ceux des amis seulement, les siens, ceux en « Tout le monde ») et dans quel ordre ? Le serveur le compose (D-136)'

  - id: F-010
    nom: Voir un post en plein écran
    description: Image du post sur tout l'écran.
    pages: [P-03, P-16]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-010.a
        pages: [P-16]
        plateforme: mobile
        difference: 'Résultat de recherche : par-dessus la grille, flèche retour vers P-15 ; se comporte comme un post du fil, avec les mêmes actions (D-046, D-049)'
    entites: [E-03, E-04]
    operations: [lecture]
    etats_ui:
      - en couleur
      - grisé selon les cycles
    questions_ouvertes:
      - Vrais médias à la place des formes générées

  - id: F-011
    nom: Regarder une vidéo
    description: Post vidéo en boucle avec une fine ligne de progression collée au menu.
    pages: [P-03]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03, E-04]
    operations: [lecture]
    etats_ui:
      - lecture en boucle
      - progression qui se remplit puis repart
    questions_ouvertes:
      - Pause et déplacement dans la vidéo non prévus

  - id: F-012
    nom: Faire défiler un carrousel
    description: Glisser entre 3 à 5 photos, points de position au-dessus du pseudo.
    pages: [P-03]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-012.a
        pages: [P-03]
        plateforme: mobile
        difference: 'Carrousel de pause de @fakescrolling tous les 5 à 8 posts : 4 phrases courtes, une par image, fond pastel par phrase ; masqué si l''interrupteur de P-23 est désactivé'
    entites: [E-03, E-04, E-17]
    operations: [lecture]
    etats_ui:
      - point plein = photo affichée
      - autres points semi-transparents
    questions_ouvertes: []

  - id: F-014
    nom: Suivre un post Inspire / Expire
    description: Cercle qui grandit puis rétrécit avec « Inspire » et « Expire », environ 1 post sur 8, toujours présent.
    pages: [P-03]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03]
    operations: [lecture]
    etats_ui:
      - animation continue
      - figée si l'appareil réduit les animations
    questions_ouvertes: []

  - id: F-015
    nom: Soutenir le projet
    description: Offre à 1,99 € en un seul achat dans l'App Store ou Google Play (D-092), proposée à partir de 1 h d'utilisation du compte (E-15, D-093).
    pages: [P-03, P-22, P-22.a, P-22.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-015.a
        pages: [P-03, P-03.c]
        plateforme: mobile
        difference: 'Post du fil, 1 sur 20 après 1 h ; une fois le soutien donné, il montre « Merci pour ton soutien. » jusqu''au prochain chargement du fil, puis n''est plus proposé (D-094)'
    entites: [E-16, E-15]
    operations: [lecture, écriture]
    etats_ui:
      - offre et bouton visibles à partir de 1 h
      - 'soutenu : « Merci pour ton soutien. » à la place du bouton dès que le store confirme l''achat (D-095) ; sur P-22, l''anneau et l''offre restent (D-094)'
      - 'paiement échoué : « Le paiement n’a pas abouti. Tu n’as pas été débité. » avec « Réessayer » (P-03 et P-22)'
      - 'paiement annulé : « Paiement annulé. Tu n’as pas été débité. » et de nouveau « Soutenir le projet » (P-22 ; même état sur F-015.a par analogie, D-036)'
    questions_ouvertes:
      - 'Remboursement par le store : le compte redevient-il « non soutenu » ?'
      - 'Achat en attente (à approuver par un parent, paiement différé) : quel état montrer ?'
      - 'Second achat fait sur un autre téléphone du compte avant que le serveur ait enregistré le premier (D-115) : remboursé par le store, et comment ?'
```

```yaml
  - id: F-016
    nom: Liker un contenu
    description: Cœur qui ajoute ou retire un like et met à jour le compteur.
    pages: [P-03, P-03.e, P-05, P-16]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-016.a
        pages: [P-03, P-16]
        plateforme: mobile
        difference: 'Double tap sur l''image : grand cœur animé, ne retire jamais le like'
      - id: F-016.b
        pages: [P-05]
        plateforme: mobile
        difference: 'Like d''un commentaire : petit cœur rouge et compteur sous le cœur'
    entites: [E-06, E-03, E-05, E-08]
    operations: [lecture, écriture, suppression]
    etats_ui:
      - vide
      - plein (liké)
      - 'échec : le cœur redevient vide, « Le like n’a pas été enregistré. » en bas du fil pendant 2 s'
      - 'échec du like d''un commentaire (F-016.b) : le petit cœur redevient gris, « Le like n’a pas été enregistré. » en bas du panneau pendant 2 s (D-043)'
    questions_ouvertes: []

  - id: F-017
    nom: Consulter les commentaires
    description: Bulle du post puis panneau listant les commentaires.
    pages: [P-03, P-05, P-05.a, P-05.b, P-05.d, P-16]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-05, E-03]
    operations: [lecture]
    etats_ui:
      - liste
      - 'chargement : anneau centré'
      - 'vide : « Aucun commentaire » · « Écris le premier. »'
      - 'erreur : « Les commentaires n’ont pas pu être chargés. » avec « Réessayer »'
    questions_ouvertes: []

  - id: F-018
    nom: Enregistrer un post dans une collection
    description: 'Signet du post puis choix d''une collection, une seule par post ; signet plein : P-06 se rouvre sur la collection choisie, un tap la retire, un tap sur une autre y déplace le post (D-057).'
    pages: [P-03, P-03.f, P-06, P-16]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-07, E-03]
    operations: [lecture, écriture, suppression]
    etats_ui:
      - signet vide
      - signet plein
      - collection choisie encadrée « enregistré »
      - message « Enregistré dans … » ou « Retiré de … » en bas du fil pendant 2 s
      - 'échec : le signet redevient vide, « Le post n’a pas été enregistré. » en bas du fil pendant 2 s'
    questions_ouvertes: []

  - id: F-019
    nom: Partager un post
    description: Flèche du post puis panneau de partage.
    pages: [P-03, P-07, P-07.a, P-16]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-019.a
        pages: [P-07, P-07.a]
        plateforme: mobile
        difference: 'Envoyer à un ami : rangée d''amis en tête du panneau, un tap envoie le post à cet ami'
      - id: F-019.b
        pages: [P-07]
        plateforme: mobile
        difference: Copier le lien du post
      - id: F-019.c
        pages: [P-07]
        plateforme: mobile
        difference: Ouvrir les autres apps de partage du téléphone
    entites: [E-03, E-11, E-10]
    operations: [lecture, écriture]
    etats_ui:
      - message « Envoyé à … », « Lien copié. » ou « Partagé. » en bas du fil ou du résultat pendant 2 s, sans mention du flou (D-051)
      - 'envoi à un ami échoué : l’ami cerclé de rouge, « Non envoyé à … » avec « Réessayer », le panneau reste ouvert'
      - 'rangée d''amis (F-019.a) en chargement : anneau centré ; en échec : message sur place avec « Réessayer » (D-043)'
    questions_ouvertes:
      - 'Peut-on partager un post « Amis proches » ? Agir sur un post suit son audience (D-138)'
      - 'Envoyer à un ami (F-019.a) : amis seulement (ami ou non, E-09)'
      - Un lien de post ouvert sans connexion mène à la connexion (P-01)
      - 'Aspect du post reçu dans la conversation de l''ami (F-019.a, D-044) : non dessiné sur P-09'
      - 'Un post envoyé à un ami (F-019.a) passe-t-il la conversation en non lu chez lui, comme un message (F-041, D-085, SM-E-10) ?'
      - 'Post partagé à un ami qui n''existe plus (compte de son auteur supprimé, D-101) ou qui sort de l''audience de l''ami : que montre son message dans la conversation (E-11) ?'

  - id: F-020
    nom: Lire l'auteur et la légende d'un post
    description: Photo, pseudo et légende en blanc en bas du post.
    pages: [P-03, P-16]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03]
    operations: [lecture]
    etats_ui:
      - pseudo et légende en charabia
    questions_ouvertes: []

  - id: F-021
    nom: Déplier la légende
    description: Lien « plus » ou « moins » au-delà d'environ 80 caractères.
    pages: [P-03, P-16]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03]
    operations: [lecture]
    etats_ui: [repliée, dépliée]
    questions_ouvertes: []

  - id: F-022
    nom: Consulter ses notifications
    description: Cloche avec pastille puis panneau des invitations, des likes, des commentaires et des identifications reçus (D-056, D-061).
    pages: [P-03, P-04, P-04.a, P-04.b, P-04.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-08, E-09, E-06, E-05]
    operations: [lecture, écriture]
    etats_ui:
      - 'pastille avec le nombre de notifications non vues ; ouvrir P-04 les marque toutes vues et la pastille disparaît (D-106)'
      - sans pastille
      - section Invitations masquée si vide
      - 'vide : « Aucune notification » · « Les invitations, les likes, les commentaires et les identifications reçus s’affichent ici. » (D-066)'
      - 'chargement : anneau centré'
      - 'erreur : « Les notifications n’ont pas pu être chargées. » avec « Réessayer »'
    questions_ouvertes:
      - Ouvrir le post liké depuis sa miniature
      - 'Accès supposé : seulement les invitations reçues et en attente (statut de la demande, E-09)'

  - id: F-024
    nom: Voir l'app se griser
    description: Toute l'interface perd 10 % de couleur par cycle, noir et blanc après 10 cycles, sans message. Seul le temps passé dans l'appli ouverte compte (D-075) ; deux téléphones ouverts en même temps ne comptent qu'une fois (D-105), sauf une période arrivée plus de 7 jours après sa fin (D-147).
    pages: [P-03, P-04, P-05, P-06, P-07, P-08, P-09, P-10, P-11, P-12, P-13, P-14, P-15, P-16, P-17, P-18, P-19, P-20, P-21, P-22, P-23, P-24, P-25, P-26, P-28]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-14]
    operations: [lecture, écriture]
    etats_ui:
      - de 0 à 100 % de gris
    questions_ouvertes: []

  - id: F-025
    nom: Naviguer entre les sections
    description: 'Menu du bas : Accueil, Messages, Recherche, Profil.'
    pages: [P-03, P-08, P-14, P-15, P-16, P-17]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: []
    operations: [lecture]
    etats_ui:
      - section active en vert
      - autres en gris
    questions_ouvertes: []

  - id: F-026
    nom: Ouvrir la création d'un post
    description: Bouton + noir au centre du menu du bas. Aussi depuis « Créer un post » de l'état vide de P-17 (D-035).
    pages: [P-03, P-08, P-14, P-15, P-16, P-17, P-17.a]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-026.a
        pages: [P-08]
        plateforme: mobile
        difference: 'Depuis le rond « Ta story » : la création s''ouvre avec Story présélectionnée'
    entites: []
    operations: [lecture]
    etats_ui: []
    questions_ouvertes: []

  - id: F-027
    nom: Fermer un panneau
    description: Croix, « OK » ou tap sur le fond assombri autour du panneau.
    pages: [P-04, P-05, P-06, P-07, P-18, P-20, P-24, P-25, P-26, P-28]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-027.a
        pages: [P-04]
        plateforme: mobile
        difference: Tap autour seulement, pas de croix
      - id: F-027.b
        pages: [P-20]
        plateforme: mobile
        difference: Tap autour seulement, sortie en glissant vers la gauche
    entites: []
    operations: [lecture]
    etats_ui: []
    questions_ouvertes: []

  - id: F-028
    nom: Répondre à une invitation d'ami
    description: 'Boutons « Accepter » et « Refuser » sur une invitation du panneau Notifications. Accepter crée une conversation vide entre les deux amis (D-071), sans notifier l''expéditeur (D-072) ; répondre supprime la notification « invitation » (D-070).'
    pages: [P-04, P-04.d, P-04.e]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-028.a
        pages: [P-04]
        plateforme: mobile
        difference: 'Refuser : la demande est supprimée et la ligne disparaît'
    entites: [E-09, E-08, E-10]
    operations: [écriture, suppression]
    etats_ui:
      - 'Accepter : devient « Ami » en vert'
      - 'réponse en cours : anneau dans « Accepter », les deux boutons désactivés'
      - 'erreur : « Ta réponse n’a pas été envoyée. » avec « Réessayer » sous l’invitation'
    questions_ouvertes:
      - 'Accès supposé : seulement les invitations reçues et en attente (statut de la demande, E-09)'

  - id: F-030
    nom: Publier un commentaire
    description: Champ « Ajouter un commentaire… » et bouton « Publier ». Le téléphone change le texte en charabia avant l'envoi (D-118).
    pages: [P-05, P-05.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-05, E-03, E-08]
    operations: [écriture]
    etats_ui:
      - bouton gris si vide
      - texte tapé visible moins d'1 s puis charabia
      - 'échec : le commentaire reste affiché, marqué « Non publié. » avec « Réessayer » (D-030)'
    questions_ouvertes: []

  - id: F-031
    nom: Créer une collection
    description: Ligne « Nouvelle collection » qui crée et enregistre aussitôt.
    pages: [P-06, P-06.a, P-06.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-07]
    operations: [écriture]
    etats_ui:
      - nom automatique « Collection N »
      - message « Enregistré dans Collection N » en bas du fil pendant 2 s
      - 'création en cours : anneau dans la ligne « Nouvelle collection », désactivée'
      - 'erreur : « La collection n’a pas été créée. » avec « Réessayer »'
    questions_ouvertes:
      - Saisie du nom de la collection

  - id: F-033
    nom: Rechercher une discussion
    description: Loupe qui ouvre un champ et filtre les discussions par prénom ou @.
    pages: [P-08]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-10]
    operations: [lecture]
    etats_ui:
      - champ masqué
      - champ affiché
      - liste filtrée
      - liste vide sans message
    questions_ouvertes: []

  - id: F-034
    nom: Ajouter un ami
    description: 'Bouton + des Messages puis « Ajouter » sur un compte trouvé : la demande part et notifie le destinataire (D-070). Aussi depuis « Ajouter un ami » de l''état vide de P-08 (D-035). Sur un compte qui a déjà envoyé une invitation, « Ajouter » l''accepte (D-073).'
    pages: [P-08, P-11, P-08.a, P-11.c, P-11.d]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-09, E-08, E-10]
    operations: [lecture, écriture, suppression]
    etats_ui:
      - Ajouter
      - devient Demandé (désactivé)
      - 'envoi : anneau dans « Ajouter », désactivé'
      - 'erreur : « La demande n’a pas été envoyée. » avec « Réessayer » ; le bouton redevient « Ajouter »'
      - 'invitation déjà reçue de ce compte : « Ajouter » l''accepte et devient « Ami » (D-073)'
    questions_ouvertes:
      - 'Annuler une demande envoyée : « Demandé » reste désactivé'
      - 'Retirer un ami ou bloquer un compte : aucune feature'

  - id: F-036
    nom: Voir une story
    description: Story plein écran, 2 ou 3 images de 5 s, tap à droite ou à gauche, croix pour fermer. Les stories en cours d'un ami s'enchaînent, de la plus ancienne à la plus récente (D-081) ; seuls ses amis la voient (D-080).
    pages: [P-08, P-09, P-10, P-10.a, P-10.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-12, E-09]
    operations: [lecture, écriture]
    etats_ui:
      - 'cercle vert : une story en cours pas encore vue (D-078, D-081)'
      - 'cercle gris : toutes vues'
      - 'sans cercle ni rond dans la rangée : aucune story en cours (D-079)'
      - '« vue » enregistrée à la fermeture, renvoyée sans message tant que le serveur ne l''a pas (D-078)'
      - 'fin : 24 h après la publication, une tâche de fond la passe à Finie et l''efface du serveur, images et « vue par » (D-079, D-110, FL-13)'
      - barres de progression
      - 'chargement : anneau blanc centré'
      - 'erreur : « La story n’a pas pu être chargée. » avec « Réessayer »'
    questions_ouvertes:
      - 'Voir sa propre story, et qui l''a vue : « Ta story » ouvre toujours la création (F-026.a)'
      - Ordre des ronds de la rangée de P-08 (non vues d'abord ?)
      - 'Une story en cours de lecture sur P-10 quand sa fin arrive (FL-13) : la lecture va-t-elle jusqu''au bout ?'
```

```yaml
  - id: F-037
    nom: Consulter ses discussions
    description: Liste des discussions avec dernier message et heure, mis à jour en direct (D-084, D-085) ; tap pour ouvrir et passer en lu. Seulement entre amis (D-082).
    pages: [P-08, P-08.a, P-08.c, P-08.d]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-10]
    operations: [lecture, écriture]
    etats_ui:
      - 'non lu : gras et point bleu'
      - lu
      - 'vide : « Aucune discussion » · « Ajoute un ami pour commencer à discuter. » avec « Ajouter un ami » (F-034, D-035)'
      - 'chargement : anneau centré'
      - 'erreur : « Les discussions n’ont pas pu être chargées. » avec « Réessayer »'
    questions_ouvertes: []

  - id: F-038
    nom: Lire une conversation
    description: Bulles vertes à droite, grises à gauche, photos et saisie du contact, en direct (D-084). Texte en charabia (D-083), photos en art généré (D-086).
    pages: [P-09, P-09.a, P-09.b, P-09.d]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-11, E-10]
    operations: [lecture, écriture]
    etats_ui:
      - contact en train d'écrire (D-084)
      - 'message reçu pendant que P-09 est ouverte : la conversation reste lue (D-085)'
      - 'chargement : anneau centré'
      - 'vide : « Aucun message » · « Écris le premier message à Léa. »'
      - 'erreur : « Les messages n’ont pas pu être chargés. » avec « Réessayer »'
    questions_ouvertes:
      - 'Historique : jusqu''où remonte une conversation, et chargement des messages plus anciens'

  - id: F-039
    nom: Appeler un contact
    description: Icône téléphone en haut à droite.
    pages: [P-09]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-10]
    operations: [lecture]
    etats_ui: [sans effet]
    questions_ouvertes:
      - Appel à concevoir ou à retirer

  - id: F-040
    nom: Répondre à un message
    description: Glisser un message vers la droite pour le citer.
    pages: [P-09]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-11]
    operations: [écriture]
    etats_ui:
      - flèche qui apparaît
      - bandeau « Réponse à … »
      - bandeau annulé
    questions_ouvertes: []

  - id: F-041
    nom: Envoyer un message
    description: Champ « Message… » et « Envoyer » dans la bulle. Le téléphone change le texte en charabia avant l'envoi (D-083) ; l'envoi met à jour la conversation (D-085).
    pages: [P-09, P-09.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-11, E-10]
    operations: [écriture]
    etats_ui:
      - texte tapé visible moins d'1 s puis charabia ; seul le charabia part (D-083)
      - 'échec : le message reste affiché, marqué « Non envoyé. » avec « Réessayer » (D-030)'
    questions_ouvertes: []

  - id: F-042
    nom: Envoyer une photo dans une conversation
    description: Icône image à droite dans la bulle de saisie. Seule la graine de la photo part, l'image montrée est un art généré (D-086) ; l'envoi met à jour la conversation (D-085).
    pages: [P-09, P-09.e]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-11, E-04, E-10]
    operations: [écriture]
    etats_ui:
      - visible quand le champ est vide
      - 'échec : la photo cerclée de rouge, « Non envoyée. » avec « Réessayer »'
    questions_ouvertes:
      - Choix de la photo (la maquette envoie une image de démo)
      - 'Art généré (D-086, D-119) : quelles briques au départ, et comment pour une vidéo ?'

  - id: F-043
    nom: Rechercher un compte par identifiant
    description: Champ précédé d'un @, jusqu'à 8 comptes dont le @ commence par la saisie.
    pages: [P-11, P-11.a, P-11.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-09, E-01]
    operations: [lecture]
    etats_ui:
      - rien tant que vide
      - résultats avec le statut de chaque compte (Ajouter, Demandé, Ami) ; une invitation reçue s'affiche « Ajouter » (D-073)
      - « Aucun compte trouvé. »
      - 'chargement : anneau centré'
      - 'erreur : « La recherche n’a pas abouti. » avec « Réessayer »'
    questions_ouvertes:
      - Vrai annuaire (20 comptes de démo)
      - 'Accès supposé : tous les comptes sont trouvables ; existe-t-il des comptes privés ou bloqués ?'
      - Son propre compte apparaît-il dans les résultats ?

  - id: F-044
    nom: Choisir les photos d'un post
    description: Aperçu carré, grille de photos, sélection multiple jusqu'à 10, « Suivant », pour un post ou une story (D-068). Dès qu'une photo est choisie, sa graine part au serveur et l'art se prépare en arrière-plan (D-120).
    pages: [P-12, P-12.a, P-12.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-04, E-03, E-12]
    operations: [lecture, écriture, suppression]
    etats_ui:
      - photo affichée voilée
      - numéros 1 à 10 en multiple
      - position « 2/4 »
      - 'galerie vide : « Aucune photo » · « Ta galerie est vide. Prends une photo pour créer un post. » avec « Ouvrir l’appareil photo » (F-046.a, D-033, D-047)'
      - 'accès refusé : « Accès aux photos refusé » avec « Ouvrir les réglages » du téléphone (D-034)'
    questions_ouvertes:
      - Vraie galerie et autorisation d'accès

  - id: F-045
    nom: Choisir un album
    description: Bouton « Récents » avec chevron.
    pages: [P-12]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-04]
    operations: [lecture]
    etats_ui: [sans effet]
    questions_ouvertes:
      - Liste des albums

  - id: F-046
    nom: Prendre une photo
    description: 'Bouton appareil photo au-dessus de la grille : la photo prise devient la photo du post ou de la story (D-068). Sa graine part aussitôt au serveur (D-120).'
    pages: [P-12]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-046.a
        pages: [P-12, P-12.a]
        plateforme: mobile
        difference: '« Ouvrir l''appareil photo » depuis la galerie vide (D-047)'
    entites: [E-04, E-03, E-12]
    operations: [écriture]
    etats_ui:
      - sans effet
      - 'galerie vide : bouton « Ouvrir l''appareil photo » (F-046.a)'
    questions_ouvertes:
      - 'Écran de prise de vue non dessiné : appareil photo du téléphone ou caméra dans l''appli ?'
      - Autorisation d'accès à l'appareil photo, et état si elle est refusée

  - id: F-047
    nom: Rédiger la légende
    description: Champ « Écris une légende… » à côté de la miniature, pour un post ou une story (D-068). Part en charabia à la publication (D-118).
    pages: [P-13]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03, E-12]
    operations: [écriture]
    etats_ui:
      - vide
      - rempli
      - pastille du nombre de photos si carrousel
    questions_ouvertes:
      - Limite de longueur

  - id: F-048
    nom: Identifier des personnes
    description: 'Ligne de la légende qui ouvre un panneau : recherche et amis à cocher, pour un post ou une story (D-059) ; chaque personne identifiée est notifiée à la publication (D-061).'
    pages: [P-13, P-24]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03, E-12, E-09]
    operations: [lecture, écriture]
    etats_ui:
      - aucune personne
      - '@ de la personne'
      - « N personnes »
      - « Aucun ami trouvé. »
      - 'chargement : anneau centré dans la liste (D-043)'
      - 'échec du chargement : message sur place avec « Réessayer » (D-043)'
    questions_ouvertes:
      - Liste limitée à 8 amis de démo
      - 'Accès supposé : seuls des amis peuvent être identifiés (ami ou non, E-09)'

  - id: F-049
    nom: Ajouter un lieu
    description: 'Ligne de la légende qui ouvre un panneau : recherche et choix d''un seul lieu, pour un post ou une story (D-059).'
    pages: [P-13, P-25]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03, E-12]
    operations: [lecture, écriture, suppression]
    etats_ui:
      - aucun lieu
      - lieu affiché sur la ligne
      - « Retirer le lieu »
      - « Aucun lieu trouvé. »
      - 'chargement : anneau centré dans la liste (D-043)'
      - 'échec de la recherche : message sur place avec « Réessayer » (D-043)'
    questions_ouvertes:
      - Vraie recherche de lieux (8 lieux de démo)

  - id: F-050
    nom: Choisir l'audience
    description: 'Ligne « Audience » qui ouvre un panneau : Tout le monde, Amis ou Amis proches, avec une phrase par choix, pour un post ou une story (D-059). Sous « Amis proches », « Modifier la liste » ouvre P-28 (F-072, D-060).'
    pages: [P-13, P-26]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03, E-12]
    operations: [écriture]
    etats_ui:
      - choix coché
      - valeur affichée sur la ligne
    questions_ouvertes: []

  - id: F-051
    nom: Publier le post
    description: Bouton vert « Partager dans le fil » (ouvre l'Accueil) ou « Partager en story » (ouvre Messages). Une fois le post enregistré, la vraie photo et la vraie légende se changent en fondu en art généré et en charabia (D-120).
    pages: [P-13, P-03.d, P-08.b, P-13.a, P-13.b, P-13.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03, E-04, E-12, E-08]
    operations: [lecture, écriture]
    etats_ui:
      - libellé selon la destination choisie
      - 'envoi : anneau et « Publication… » dans le bouton, jusqu''à ce que le post soit enregistré et l''art prêt (D-120)'
      - 'transformation : la vraie photo et la vraie légende s''effacent en fondu pour l''art généré et le charabia (P-13.c, D-120)'
      - 'erreur : « Le post n’a pas été publié. Tes photos et ta légende sont gardées. » avec « Réessayer »'
      - 'succès fil : l''Accueil affiche le toast « Post publié. » (D-031)'
      - 'succès story : Messages affiche le toast « Story publiée. » (D-031)'
    questions_ouvertes: []

  - id: F-052
    nom: Rechercher des posts
    description: Le téléphone change la saisie en une graine et n'envoie que la graine ; jusqu'à 18 posts visibles, les plus proches de cette graine, s'affichent (D-088, D-139).
    pages: [P-14, P-15, P-15.a, P-15.b, P-15.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-13, E-03, E-04, E-09]
    operations: [lecture]
    etats_ui:
      - 'champ vide : suggestions'
      - 'champ rempli : résultats'
      - 'chargement : anneau centré (P-15)'
      - 'aucun résultat : « Aucun résultat » · « Aucun post ne correspond à « … ». Essaie un autre mot. »'
      - 'erreur : « La recherche n’a pas abouti. » avec « Réessayer » (P-15)'
    questions_ouvertes:
      - 'Règle de la recherche par graine (D-139) : comment un texte devient une graine, ce que « proche » veut dire, et un post trop loin est-il écarté (P-15.b) ?'
```

```yaml
  - id: F-053
    nom: Lancer une recherche proposée
    description: Tap sur une suggestion qui remplit le champ et affiche les résultats.
    pages: [P-14, P-14.a, P-14.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-053.a
        pages: [P-14]
        plateforme: mobile
        difference: 'Tendance : rang, nombre de posts et 3 bandes de la palette d''arrivée'
    entites: [E-13, E-03]
    operations: [lecture]
    etats_ui:
      - 'chargement : anneau centré'
      - 'erreur : « Les suggestions n’ont pas pu être chargées. » avec « Réessayer » ; le champ reste utilisable'
    questions_ouvertes:
      - 'Tendances : choix des 6 mots et rythme de leur renouvellement ; depuis la recherche par graine (D-139), que compte le nombre de posts d''une tendance, et que montrent ses 3 bandes de couleur ?'

  - id: F-054
    nom: Ouvrir un résultat de recherche
    description: Tap sur une tuile de la grille.
    pages: [P-15]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03]
    operations: [lecture]
    etats_ui: []
    questions_ouvertes: []

  - id: F-055
    nom: Ouvrir les options
    description: Engrenage du Profil puis panneau sur la moitié gauche de l'écran.
    pages: [P-17, P-20]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: []
    operations: [lecture]
    etats_ui:
      - entrée et sortie en glissant
      - fond assombri
    questions_ouvertes: []

  - id: F-056
    nom: Modifier son profil
    description: Lien « Modifier » puis page avec pseudo (16 max) et description (80 max), envoyés en charabia (D-098).
    pages: [P-17, P-19, P-19.a, P-19.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-01]
    operations: [lecture, écriture]
    etats_ui:
      - prérempli avec le charabia actuel (D-098)
      - compteurs 0/16 et 0/80
      - texte tapé visible moins d'1 s, sur ce téléphone seulement, puis charabia (D-098)
      - 'pseudo vide : l''ancien est gardé, sans message ; description vidable (D-099)'
      - 'enregistrement : anneau, champs gardés'
      - 'erreur : « Tes modifications n’ont pas été enregistrées. Vérifie ta connexion et réessaie. » avec « Réessayer »'
    questions_ouvertes: []

  - id: F-057
    nom: Voir son profil
    description: Pseudo, @, compteurs posts, amis, likes et description.
    pages: [P-17, P-21]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-057.a
        pages: [P-21]
        plateforme: mobile
        difference: Identifiant @ seul, sous le libellé « Compte »
    entites: [E-01]
    operations: [lecture]
    etats_ui:
      - pseudo sur une ligne, sans troncature
    questions_ouvertes:
      - Compteurs fixes dans la maquette

  - id: F-058
    nom: Changer sa photo de profil
    description: Photo ronde avec badge puis panneau de choix ; la photo se floute.
    pages: [P-17, P-18, P-18.a]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-01, E-04]
    operations: [écriture]
    etats_ui:
      - nette environ 1 s, sur son seul téléphone, puis art généré (D-091)
      - floutée
      - 'erreur de fichier : « Cette image n’a pas pu être utilisée. Choisis-en une autre. » (P-18)'
      - 'enregistrement : appliqué tout de suite, renvoyé sans message tant que le serveur ne l''a pas (D-100)'
    questions_ouvertes:
      - Autorisation d'accès à la galerie ; si elle est refusée, même état que F-044 (D-034) ?

  - id: F-059
    nom: Suivre le minuteur de couleur
    description: Cycle en cours sur 10, % de gris, temps restant et 10 segments.
    pages: [P-17]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-14]
    operations: [lecture]
    etats_ui:
      - segments gris foncé passés ou en cours
      - gris clair à venir
      - message noir et blanc après 10 cycles
    questions_ouvertes: []

  - id: F-060
    nom: Régler la durée du cycle
    description: 'Petites flèches haut et bas : 1, 2, 3, 5, 10, 15, 20 ou 30 min. Les cycles déjà écoulés restent ; la nouvelle durée vaut à partir du cycle en cours (D-076).'
    pages: [P-17]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-14]
    operations: [écriture]
    etats_ui:
      - flèche grisée aux bornes
      - 'enregistrement : appliqué tout de suite, renvoyé sans message tant que le serveur ne l''a pas (D-077)'
      - 'deux téléphones hors connexion : le serveur garde le changement fait le plus tard (D-111)'
    questions_ouvertes: []

  - id: F-061
    nom: Réinitialiser les cycles
    description: Bouton « Réinitialiser » qui rend les couleurs partout. Entre deux téléphones hors connexion, le changement fait le plus tard gagne (D-111).
    pages: [P-17]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-14]
    operations: [écriture]
    etats_ui:
      - 'enregistrement : appliqué tout de suite, renvoyé sans message tant que le serveur ne l''a pas (D-077)'
    questions_ouvertes: []

  - id: F-062
    nom: Voir ses posts
    description: Grille de 9 posts floutés.
    pages: [P-17, P-17.a, P-17.b, P-17.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03]
    operations: [lecture]
    etats_ui:
      - non cliquables
      - 'vide : « Aucun post pour l’instant » · « Tes posts s’affichent ici. » avec « Créer un post » (F-026, D-035, D-097)'
      - 'chargement : anneau centré'
      - 'erreur : « Tes posts n’ont pas pu être chargés. » avec « Réessayer »'
    questions_ouvertes:
      - Ouvrir un de ses posts
      - 'Combien de posts montre la grille, maintenant qu’ils n’expirent plus (D-097) : tous, avec défilement et chargement par lots ?'

  - id: F-063
    nom: Supprimer son compte
    description: Bouton rouge puis confirmation « Supprimer définitivement » ou « Annuler » ; efface tout le compte, tout de suite et pour de bon (D-101), et libère son @ (D-102).
    pages: [P-21, P-21.a]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-14, E-15, E-16]
    operations: [suppression]
    etats_ui:
      - confirmation
      - 'compte supprimé : « Compte supprimé » et « Merci d’être passé·e. » 2 s, puis P-01 s''ouvre (D-069)'
      - 'échec : « Ton compte n’a pas pu être supprimé. Rien n’a été effacé. » avec « Réessayer »'
    questions_ouvertes: []

  - id: F-065
    nom: Voir son temps passé
    description: Anneau avec le temps passé et les minutes restantes avant 1 h.
    pages: [P-22]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-15]
    operations: [lecture]
    etats_ui:
      - anneau qui se remplit jusqu'à 1 h
      - « encore X min » avant 1 h
    questions_ouvertes: []

  - id: F-066
    nom: Choisir le thème de l'icône
    description: Trois cases Noir, Orange, Rouge.
    pages: [P-23]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-17]
    operations: [écriture]
    etats_ui:
      - case choisie cerclée
    questions_ouvertes:
      - Changement réel de l'icône du téléphone

  - id: F-067
    nom: Activer ou désactiver les carrousels de pause
    description: 'Interrupteur « Carrousels de pause » : désactivé, les carrousels de pause (F-012.a) disparaissent du fil.'
    pages: [P-23]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-17]
    operations: [écriture]
    etats_ui: [vert actif, gris inactif]
    questions_ouvertes: []

  - id: F-068
    nom: Choisir où publier
    description: 'Choix « Publier dans » : Fil d''actualité ou Story, sous la légende.'
    pages: [P-13]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03, E-12]
    operations: [écriture]
    etats_ui:
      - Fil d'actualité par défaut
      - Story présélectionnée depuis « Ta story »
    questions_ouvertes: []

  - id: F-070
    nom: Créer son compte
    description: 'À la première connexion, choix du pseudo et de l''identifiant (@), puis ouverture de l''Accueil (D-052). Seulement ces deux champs : photo et description plus tard sur P-19 (D-063). Crée aussi le minuteur, le temps d''utilisation et le soutien du compte (D-114).'
    pages: [P-27, P-27.a, P-27.b]
    plateformes: [mobile]
    acces: [R-01]
    variantes: []
    entites: [E-02, E-01, E-14, E-15, E-16]
    operations: [lecture, écriture]
    etats_ui:
      - « Créer mon compte » gris tant qu'un champ est vide
      - 'envoi : champs grisés, anneau et « Création du compte… » dans le bouton (D-064)'
      - 'erreur : « Ton compte n’a pas été créé. Vérifie ta connexion et réessaie. » avec « Réessayer », saisies gardées (D-064)'
    questions_ouvertes:
      - 'Règles de l''identifiant : longueur, caractères permis, message s''il est déjà pris (minuscules seulement, unique, D-145)'
      - 'Inscription finie plus d''1 h après son début, quand le serveur l''a oubliée (D-149, FL-16) : quel message, et retour à P-01 ?'

  - id: F-071
    nom: Se déconnecter
    description: Bouton « Se déconnecter » sur Mon compte, qui ferme la session de l'appareil et ramène à la Connexion (D-053). Ce qui attend d'être renvoyé au serveur part à la prochaine connexion du compte sur ce téléphone (D-104).
    pages: [P-21]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-02]
    operations: [suppression]
    etats_ui:
      - 'sans confirmation : un tap ouvre P-01 (D-065)'
    questions_ouvertes: []

  - id: F-072
    nom: Choisir ses amis proches
    description: 'Lien « Modifier la liste » sous « Amis proches » du panneau Audience : panneau de ses amis avec recherche et cases rondes à cocher, comme P-24 (D-060).'
    pages: [P-26, P-28]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-09]
    operations: [lecture, écriture]
    etats_ui:
      - case vide
      - cochée en vert
      - « Aucun ami trouvé. »
      - 'chargement : anneau centré dans la liste (D-067)'
      - 'échec du chargement : message sur place avec « Réessayer » (D-067)'
      - 'sur P-26 : nombre d''amis proches à droite de « Modifier la liste » (« Aucun ami proche », « 1 ami proche », « N amis proches »)'
    questions_ouvertes:
      - 'Liste vide quand on choisit « Amis proches » : P-28 s''ouvre-t-il, ou le choix est-il refusé ?'

  - id: F-073
    nom: Compter le temps d'utilisation
    description: 'Tâche de fond sans élément visible : chaque seconde passée appli ouverte et au premier plan s''ajoute au temps d''utilisation du compte, même après les 10 cycles de F-024 (D-093, D-096) ; deux téléphones ouverts en même temps ne comptent qu''une fois (D-105).'
    pages: [P-03, P-04, P-05, P-06, P-07, P-08, P-09, P-10, P-11, P-12, P-13, P-14, P-15, P-16, P-17, P-18, P-19, P-20, P-21, P-22, P-23, P-24, P-25, P-26, P-28]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-15]
    operations: [lecture, écriture]
    etats_ui: []
    questions_ouvertes: []

  - id: F-074
    nom: Mettre à jour l'appli
    description: 'Quand la version de l''appli est trop vieille pour le serveur, un message le dit et un bouton ouvre l''appli dans l''App Store ou Google Play ; rien d''autre n''est utilisable (D-141).'
    pages: [P-29]
    plateformes: [mobile]
    acces: [R-01, R-02]
    variantes: []
    entites: []
    operations: []
    etats_ui:
      - page affichée à la place de toute autre tant que la version est trop vieille
      - 'bouton « Mettre à jour » toujours actif (D-142)'
    questions_ouvertes: []
```

```yaml
entites:

  - id: E-01
    nom: Compte utilisateur
    champs:
      - pseudo, en charabia (D-098)
      - identifiant (@), en minuscules, unique (D-145)
      - description, en charabia (D-098)
      - photo de profil
      - nombre de posts
      - nombre d'amis
      - nombre de likes reçus
    utilisee_par: [F-001, F-007, F-043, F-056, F-057, F-058, F-063, F-070]

  - id: E-02
    nom: Connexion
    champs:
      - fournisseur (Google, Apple, e-mail)
      - adresse e-mail
      - code à 6 chiffres
      - délai avant renvoi (30 s)
      - heure d'envoi du code, valide 10 min (D-127) ; seul le dernier code envoyé marche (D-131)
      - essais faux, 5 au plus (D-127), remis à 0 par un nouveau code (D-131)
      - session ouverte sur l'appareil (D-053)
    utilisee_par: [F-001, F-003, F-006, F-007, F-008, F-063, F-070, F-071]

  - id: E-03
    nom: Post
    champs:
      - auteur (pseudo, photo)
      - type (photo, vidéo, carrousel, pause, inspire-expire, premium)
      - légende, en charabia (D-118)
      - nombre de likes
      - nombre de commentaires
      - nombre d'enregistrements
      - nombre de partages
      - audience
      - lien
      - personnes identifiées
      - lieu
    utilisee_par: [F-009, F-010, F-011, F-012, F-014, F-016, F-017, F-018, F-019, F-020, F-021, F-030, F-044, F-046, F-047, F-048, F-049, F-050, F-051, F-052, F-053, F-054, F-062, F-063, F-068]

  - id: E-04
    nom: Média
    champs:
      - graine (empreinte de la photo ou de la vidéo, seule à quitter le téléphone, D-086)
      - algorithme qui dessine l'art généré, choisi par le serveur et décrit en données (D-086, D-119)
      - durée de la vidéo
      - rang dans le carrousel
      - heure d'arrivée de la graine sur le serveur, pour l'effacer après 24 h si rien ne la prend (D-123)
    utilisee_par: [F-005, F-010, F-011, F-012, F-042, F-044, F-045, F-046, F-051, F-052, F-058, F-063]

  - id: E-05
    nom: Commentaire
    champs:
      - auteur
      - texte, en charabia (D-118)
      - ancienneté
      - nombre de likes
    utilisee_par: [F-016, F-017, F-022, F-030, F-063]

  - id: E-06
    nom: Like
    champs:
      - cible (post ou commentaire)
      - auteur
      - date
    utilisee_par: [F-016, F-022, F-063]

  - id: E-07
    nom: Collection
    champs:
      - nom
      - posts enregistrés
    utilisee_par: [F-018, F-031, F-063]

  - id: E-08
    nom: Notification
    champs:
      - type (like, commentaire, invitation, identification)
      - auteur
      - ancienneté
      - post concerné (miniature)
      - vue / non vue (ouvrir P-04 les marque toutes vues, D-106)
    utilisee_par: [F-016, F-022, F-028, F-030, F-034, F-051, F-063]

  - id: E-09
    nom: Relation d'amitié
    champs:
      - compte (pseudo, identifiant, photo)
      - statut (en attente, demandé, ami)
      - ami proche (oui/non, D-060)
    utilisee_par: [F-022, F-028, F-034, F-036, F-043, F-048, F-052, F-063, F-072]

  - id: E-10
    nom: Conversation
    champs:
      - contact (pseudo, identifiant, photo)
      - dernier message
      - heure
      - lu / non lu, pour chacun des deux amis (D-085)
    utilisee_par: [F-019, F-028, F-033, F-034, F-037, F-038, F-039, F-041, F-042, F-063]

  - id: E-11
    nom: Message
    champs: [expéditeur, texte en charabia (D-083), photo en graine (D-086), message cité, post partagé, date]
    utilisee_par: [F-019, F-038, F-040, F-041, F-042, F-063]

  - id: E-12
    nom: Story
    champs:
      - auteur
      - images
      - texte, en charabia (D-118)
      - ancienneté
      - vue par (comptes qui l'ont vue, D-078)
      - fin, 24 h après la publication (D-079)
      - audience (D-059)
      - personnes identifiées
      - lieu
    utilisee_par: [F-036, F-044, F-046, F-047, F-048, F-049, F-050, F-051, F-063, F-068]

  - id: E-13
    nom: Recherche
    champs:
      - texte saisi (sur le téléphone seulement, D-087)
      - graine obtenue (seule envoyée, D-139)
      - suggestions (tirées au hasard, sans historique, D-089)
      - tendances (rang et nombre de posts ; ce que compte ce nombre est ouvert dans F-053, D-139)
    utilisee_par: [F-052, F-053]

  - id: E-14
    nom: Minuteur de couleur
    champs:
      - compte (D-074) ; deux téléphones ouverts ensemble ne comptent qu'une fois (D-105), sauf une période arrivée plus de 7 jours après sa fin (D-147)
      - durée du cycle
      - temps passé appli ouverte dans le cycle en cours (D-075), y compris sans réseau (D-117)
      - cycles écoulés
      - pourcentage de gris
      - temps restant
    utilisee_par: [F-024, F-059, F-060, F-061, F-063, F-070]

  - id: E-15
    nom: Temps d'utilisation
    champs:
      - compte (D-093)
      - durée cumulée, appli ouverte et au premier plan sur au moins un téléphone, comptée une fois (D-093, D-105 ; sauf D-147), y compris sans réseau, renvoyée par FL-12 (D-117)
    utilisee_par: [F-015, F-063, F-065, F-070, F-073]

  - id: E-16
    nom: Soutien
    champs:
      - prix (1,99 €)
      - compte (D-092)
      - statut (non soutenu, soutenu)
      - achat du store, renvoyé à chaque ouverture tant que le serveur ne l'a pas enregistré (D-095), abandonné si le compte est supprimé (D-116) ; un seul enregistré par compte (D-115)
    utilisee_par: [F-015, F-063, F-070]

  - id: E-17
    nom: Préférences d'interface
    champs:
      - téléphone, pas le compte (D-103)
      - thème d'icône (Noir, Orange, Rouge)
      - carrousels de pause (oui/non)
    utilisee_par: [F-002, F-012, F-066, F-067]
```

```yaml
decisions:
  - id: D-001
    sujet: Doublon F-026 / F-035
    choix: F-035 « Ajouter à sa story » fusionnée dans F-026.a ; « Ta story » présélectionne Story. L'ID F-035 est retiré et ne sera pas réutilisé.
    raison: 'Le même écran de création était ouvert par deux entrées : doublon de comportement.'
    impacte: [F-026, F-068]
  - id: D-002
    sujet: Doublon F-012 / F-013
    choix: F-013 « Lire un carrousel de pause » fusionnée dans F-012.a (même geste de carrousel). L'ID F-013 est retiré et ne sera pas réutilisé.
    raison: Le carrousel de pause se fait défiler avec le même geste que les autres carrousels.
    impacte: [F-012, F-067]
  - id: D-003
    sujet: Doublon F-019.a / F-025
    choix: « Envoyer à un ami » envoie le post depuis le panneau (rangée d'amis) au lieu d'ouvrir Messages.
    raison: L'option faisait la même chose que l'icône Messages du menu.
    impacte: [F-019]
  - id: D-004
    sujet: Doublon F-002.b / F-066
    choix: Le changement en direct de l'icône appartient à F-066 ; F-002.b ne décrit que l'aperçu.
    raison: Le même changement en direct était décrit dans deux features.
    impacte: [F-002, F-066]
  - id: D-005
    sujet: Doublon F-015 / F-065
    choix: Le temps restant avant 1 h appartient à F-065 ; F-015 ne couvre que l'offre et l'achat.
    raison: Le même affichage avant 1 h était décrit dans deux features.
    impacte: [F-015, F-065]
  - id: D-006
    sujet: Doublon F-034 / F-043
    choix: F-043 affiche les comptes et leur statut ; F-034 ne couvre que l'envoi de la demande.
    raison: La liste des comptes appartient à la recherche ; l'ajout ne couvre que l'envoi.
    impacte: [F-034, F-043]
  - id: D-007
    sujet: Doublon F-019.b, F-019.c / F-023
    choix: Les messages de confirmation appartiennent à F-023 ; les variantes de partage ne les décrivent plus. Remplacée par D-017.
    raison: Les confirmations étaient décrites deux fois.
    impacte: [F-019]
  - id: D-008
    sujet: Page de F-023
    choix: F-023 est rattachée à P-03 seulement, où le message s'affiche. Remplacée par D-017.
    raison: Le message s'affiche sur P-03, pas sur P-06.
    impacte: []
  - id: D-009
    sujet: Pages de F-024
    choix: Le grisage couvre toutes les pages sauf la connexion (P-01, P-02).
    raison: Le design grise tous les écrans après la connexion.
    impacte: [F-024]
  - id: D-010
    sujet: Menu sur P-16
    choix: F-025 et F-026 incluent P-16, où le menu est visible.
    raison: Le menu du bas est visible sur P-16.
    impacte: [F-025, F-026]
  - id: D-011
    sujet: Vocabulaire
    choix: « Légende » désigne le texte d'un post ; « description » est réservé au profil.
    raison: Deux mots désignaient le texte d'un post.
    impacte: [F-020, F-021, F-047, F-056, F-057]
  - id: D-012
    sujet: Création d'un post
    choix: Ajout des écrans P-24, P-25, P-26 (panneaux) et de la feature F-068 « Choisir où publier ».
    raison: Demandes faites en commentaire sur l'écran de création.
    impacte: [F-048, F-049, F-050, F-051, F-068]
  - id: D-013
    sujet: 'Cas 1 : liker un commentaire'
    choix: Le like de commentaire reste une variante (F-016.b) de « Liker un contenu ».
    raison: Même intention ; seule la donnée change (commentaire au lieu de post).
    impacte: [F-016]
  - id: D-014
    sujet: 'Cas 2 : les trois recherches'
    choix: Les recherches de posts, de discussions et de comptes restent trois features séparées.
    raison: Données, écrans et résultats différents.
    impacte: [F-033, F-043, F-052]
  - id: D-015
    sujet: 'Cas 3 : répondre à une invitation'
    choix: F-029 « Refuser une invitation » fusionnée dans F-028.a ; F-028 devient « Répondre à une invitation d'ami ». L'ID F-029 est retiré et ne sera pas réutilisé.
    raison: Même invitation, même panneau, deux réponses possibles.
    impacte: [F-028]
  - id: D-016
    sujet: 'Cas 4 : navigation et fermeture'
    choix: Revenir en arrière, le menu du bas et la fermeture des panneaux restent des features.
    raison: Ce sont des actions faites par l'utilisateur, visibles page par page.
    impacte: [F-005, F-025, F-027]
  - id: D-017
    sujet: 'Cas 5 : messages de confirmation'
    choix: 'F-023 retirée : les messages deviennent des états de F-018, F-019 et F-031. L''ID F-023 ne sera pas réutilisé.'
    raison: Le message n'existe que comme retour d'une autre action.
    impacte: [F-018, F-019, F-031]
  - id: D-018
    sujet: 'Cas 6 : explications sur le flou'
    choix: Les deux textes sont supprimés du design (panneaux Partager et Photo de profil). F-032 retirée, ID non réutilisé.
    raison: L'app n'explique nulle part ailleurs le flou ni le charabia.
    impacte: [F-019, F-058]
  - id: D-019
    sujet: 'Cas 7 : grisage de la connexion'
    choix: Les écrans de connexion (P-01, P-02) ne sont pas grisés.
    raison: Avant la connexion, aucun minuteur n'est lié à un compte.
    impacte: [F-024]
  - id: D-020
    sujet: 'Cas 8 : éléments de maquette'
    choix: « Recommencer la démo » (F-064) et les images de démo de la photo de profil (F-058.a) sont exclus du registre ; ils restent dans le design pour les tests. IDs non réutilisés.
    raison: Ces éléments n'existent que pour la démo.
    impacte: [F-058, F-063]
  - id: D-021
    sujet: 'Cas 9 : interrupteurs d''interface'
    choix: 'Les posts Inspire / Expire sont toujours présents : leur interrupteur (F-067.a) est supprimé. L''interrupteur des carrousels de pause masque F-012.a quand il est désactivé.'
    raison: Les posts Inspire / Expire font partie du principe de l'app ; les pauses restent un choix.
    impacte: [F-067, F-012, F-014]
  - id: D-022
    sujet: 'Cas 10 : posts spéciaux'
    choix: Les posts Inspire / Expire (F-014) et Premium (F-015.a) restent à part.
    raison: Contenu et comportement propres (animation, achat).
    impacte: [F-014, F-015]
  - id: D-023
    sujet: 'Cas 11 : retour depuis les options'
    choix: Depuis Mon compte, Premium et Interface de l'appli, la flèche retour rouvre le panneau Options.
    raison: On revient là d'où l'on vient.
    impacte: [F-005, F-055]
  - id: D-024
    sujet: Rôles et accès
    choix: 'Deux rôles : R-01 Personne non connectée (P-01, P-02) et R-02 Utilisateur connecté (P-03 à P-26). Le compte @fakescrolling est un contenu système, pas un rôle. Un lien de post ouvert sans connexion mène à P-01. Un seul rôle avant connexion : le backend détecte s''il faut passer à l''inscription. F-002 et F-005 sont à [R-01, R-02], leurs variantes à [R-02]. Les conditions plus fines (ami, audience, 1 h, soutien, compte ou appareil) restent des questions ouvertes.'
    raison: 'Le design ne montre que deux états d''accès, avant et après connexion : aucun badge, écran réservé ni profil d''un autre utilisateur.'
    impacte: [F-001, F-002, F-005, F-007, F-019]
  - id: D-025
    sujet: États vide, chargement et erreur non dessinés
    choix: 'Tous les états non dessinés des 18 features concernées sont dessinés dans le design mobile avant d''écrire les flows : chargement, erreur, vide, échec d''envoi ou de paiement, code faux ou expiré, galerie vide ou accès refusé. Ces features portent design_a_mettre_a_jour: true jusqu''à ce que le prompt 9 constate que le design correspond.'
    raison: L'étape 1 de la méthode demande les états vide, chargement et erreur ; les dessiner tous maintenant évite de les découvrir pendant les flows ou les specs.
    impacte: [F-001, F-003, F-007, F-009, F-015, F-017, F-022, F-030, F-037, F-038, F-041, F-044, F-051, F-052, F-056, F-058, F-062, F-063]
  - id: D-026
    sujet: Emplacement des états dans le design
    choix: 'Chaque état est un artboard statique à part, sous les écrans du design mobile (titre « États vides, chargement et erreur »), nommé par page et feature (ex. « P-02 · F-007 · Code faux »). Les 7 écrans interactifs ne changent pas.'
    raison: Voir tous les états côte à côte sans toucher aux écrans existants.
    impacte: [F-001, F-003, F-007, F-009, F-015, F-017, F-022, F-030, F-037, F-038, F-041, F-044, F-051, F-052, F-056, F-058, F-062, F-063]
  - id: D-027
    sujet: Affichage des erreurs
    choix: 'Erreur sur place avec « Réessayer » : message rouge sous le champ pour les formulaires (e-mail, code, profil) ; le contenu envoyé reste affiché, marqué « Non publié » ou « Non envoyé », avec « Réessayer » (commentaire, message, post) ; message sur place avec « Réessayer » pour le paiement et la suppression du compte. Rien de ce qui a été saisi n''est perdu.'
    raison: Un toast disparaît en 2 s et n'offre pas de reprise ; une feuille plein écran est trop lourde pour un commentaire.
    impacte: [F-001, F-003, F-007, F-009, F-015, F-030, F-041, F-051, F-056, F-058, F-063]
  - id: D-028
    sujet: Affichage du chargement
    choix: 'Un anneau qui tourne : centré dans une liste qui charge, en bas du fil, et dans le bouton pressé (désactivé pendant ce temps).'
    raison: Lisible tout de suite et dans le style sobre de l'app, sans nouveau motif par liste.
    impacte: [F-001, F-003, F-009, F-017, F-038, F-051, F-052, F-056]
  - id: D-029
    sujet: États vides
    choix: 'Un titre court, une phrase grise et un bouton quand une action existe (ex. « Aucun post pour l''instant » + « Créer un post » ; « Aucun résultat » sans bouton). Pas d''illustration.'
    raison: Indiquer la suite sans ajouter d'icônes au design.
    impacte: [F-017, F-022, F-037, F-038, F-044, F-052, F-062]
  - id: D-030
    sujet: Commentaire ou message non envoyé
    choix: Un commentaire ou un message qui échoue propose seulement « Réessayer » ; pas d'action « Supprimer ».
    raison: Même comportement pour les deux, sans nouvelle action à spécifier.
    impacte: [F-030, F-041]
  - id: D-031
    sujet: Confirmation de publication
    choix: 'Après « Partager dans le fil », l''Accueil affiche le toast « Post publié. » ; après « Partager en story », Messages affiche le toast « Story publiée. ».'
    raison: Les deux destinations confirment de la même façon.
    impacte: [F-051]
  - id: D-032
    sujet: Échec de chargement du fil
    choix: 'Si les posts suivants ne se chargent pas, le bas du fil affiche « Les posts suivants n''ont pas pu être chargés. » avec « Réessayer ».'
    raison: Les flows du fil en ont besoin ; même motif que les autres erreurs.
    impacte: [F-009]
  - id: D-033
    sujet: Appareil photo depuis la galerie vide
    choix: '« Ouvrir l''appareil photo », dans l''état galerie vide de P-12, devient la feature F-069 « Prendre une photo pour un post ». Le design reste tel quel. Remplacée en partie par D-047 : F-069 devient la variante F-046.a.'
    raison: Le bouton donne une issue à une galerie vide.
    impacte: [F-044, F-069]
  - id: D-034
    sujet: Accès aux photos refusé
    choix: '« Ouvrir les réglages » est un état de F-044 qui ouvre les réglages du téléphone, sans nouvel ID.'
    raison: C'est la réponse au refus d'autorisation du système, pas une action propre à l'appli.
    impacte: [F-044]
  - id: D-035
    sujet: Boutons des états vides
    choix: '« Créer un post » (état vide de P-17) et « Ajouter un ami » (état vide de P-08) sont une seconde entrée vers F-026 et F-034, notée dans leur description ; pas de variante ni de nouvel ID.'
    raison: Même action, même comportement ; seul l'endroit change.
    impacte: [F-026, F-034, F-037, F-062]
  - id: D-036
    sujet: États dessinés pour un seul cas
    choix: 'Le chargement et l''erreur de F-001, dessinés pour Google, valent aussi pour Apple (F-001.a). Le paiement annulé, dessiné sur P-22, vaut aussi pour le post Premium de P-03 (F-015.a). Pas de nouvel artboard.'
    raison: Seul le fournisseur ou l'emplacement change ; le motif est le même (D-027).
    impacte: [F-001, F-015]
  - id: D-037
    sujet: Conventions de workflow_claude 1374eff
    choix: 'Le registre importé s''appelle claude_docs/registry.yaml, nom fixé par la méthode quel que soit le titre de la page. Chaque ID retiré figure dans ids_retires avec la décision qui l''a retiré. Un ID garde son nombre de chiffres : il n''est jamais complété ni renuméroté. Remplacée en partie par D-038 : le registre importé s''appelle claude_docs/registry.md.'
    raison: 'La méthode fixe le nom du registre (L0-05), et G-02 bloque désormais le build quand un ID cité n''est ni défini ni listé dans ids_retires.'
    impacte: []
  - id: D-038
    sujet: Registre dans une Claude Doc
    choix: 'Le registre en vigueur est la Claude Doc « Registre canonique – Fake scrolling » (https://claude.ai/artifact/A5qaJU9xAkPWfJ6JUNfWHV), importée en claude_docs/registry.md. L''ancienne page HTML (https://claude.ai/artifact/W2ibtgK7oF536LDXh5AAAV) est archivée et exclue de l''import.'
    raison: 'La méthode veut le registre dans une Claude Doc, jamais une page (L0-05) : une Claude Doc se modifie sur place, alors que les tableaux d''une page sont à régénérer à la main à chaque changement.'
    impacte: []
  - id: D-039
    sujet: Registre en YAML seulement
    choix: 'La Claude Doc du registre ne garde que ses blocs YAML et ses notes (regroupements effectués, cas ambigus). Les tableaux des rôles, pages, features, entités, décisions et IDs retirés sont supprimés ; pour lire le registre en tableau, interroger la base du registre (registry-db).'
    raison: 'Un tableau qui répète le YAML diverge dès le premier changement ; la méthode (workflow_claude 4a29adc) n''en veut aucun dans la doc du registre.'
    impacte: []
  - id: D-040
    sujet: États de page dessinés à part
    choix: 'Chacun des 33 artboards d''état du design (D-025, D-026) est un état de page, P-xx.a, P-xx.b…, lettré dans l''ordre du canvas, juste après sa page dans pages. Un état liste seulement la feature dont il montre l''état, plus celle que lance un bouton propre à l''état (P-08.a : F-034 ; P-12.a : F-046.a, ex-F-069 (D-047) ; P-17.a : F-026) ; le menu du bas et le reste de l''écran restent sur la page. Les toasts de succès appartiennent à la page qui les affiche (D-031) : P-03.d et P-08.b. Le design n''est pas modifié : l''inventaire des écrans donne l''artboard de chaque état.'
    raison: 'La méthode (synchro du 2026-11-19) donne un ID à chaque écran dessiné à part (L2-01). Lister le menu sur chaque état le répéterait sur 15 états à tenir à jour ; l''inventaire relie déjà chaque écran à son ID.'
    impacte: [P-01, P-02, P-03, P-04, P-05, P-08, P-09, P-12, P-13, P-15, P-17, P-18, P-19, P-21, P-22]
  - id: D-041
    sujet: États encore non dessinés
    choix: 'Les états manquants de 16 features sont dessinés comme pour D-025 et D-026 : chargement et erreur des listes (F-017, F-022, F-036, F-037, F-038, F-043, F-052, F-053, F-062), échec des actions (F-016, F-018, F-019.a, F-028, F-031, F-034, F-042). Leurs 25 artboards sont des états de page (D-040), de P-03.e à P-17.c. Dessinés et rapprochés du registre dans la même passe (prompt 9), ces features ne portent pas design_a_mettre_a_jour.'
    raison: 'Même motif que D-025 : l''étape 1 de la méthode demande les états chargement et erreur de chaque écran, et aucune décision ne disait que ces features n''en ont pas (L1-02).'
    impacte: [F-016, F-017, F-018, F-019, F-022, F-028, F-031, F-034, F-036, F-037, F-038, F-042, F-043, F-052, F-053, F-062]
  - id: D-042
    sujet: Échec d'une action en un tap
    choix: 'Le like (F-016) et l''enregistrement (F-018) changent aussitôt ; si le serveur échoue, ils reviennent en arrière et un message le dit en bas du fil pendant 2 s (en bas du panneau des commentaires pour le like d''un commentaire, D-043). Accepter ou refuser une invitation (F-028), ajouter un ami (F-034) et créer une collection (F-031) montrent l''anneau dans le bouton (D-028), puis l''erreur sur place avec « Réessayer » (D-027). Envoyer un post à un ami (F-019.a) ou une photo (F-042) suit D-027 : « Non envoyé » avec « Réessayer ».'
    raison: 'Un like ou un signet doit rester instantané et se refait d''un tap ; une invitation, une demande d''ami ou une collection crée ou change une donnée, on attend la réponse du serveur.'
    impacte: [F-016, F-018, F-019, F-028, F-031, F-034, F-042]
  - id: D-043
    sujet: États de chargement et d'erreur par analogie
    choix: 'La liste d''amis de P-24 (F-048), la recherche de lieux de P-25 (F-049) et la rangée d''amis de P-07 (F-019.a) suivent D-028 et D-027 : un anneau centré dans la liste pendant le chargement, puis un message sur place avec « Réessayer » si elle échoue. L''échec du like d''un commentaire (F-016.b) suit D-042 : le petit cœur redevient gris et « Le like n’a pas été enregistré. » s''affiche pendant 2 s en bas du panneau des commentaires (P-05), au-dessus du champ « Ajouter un commentaire… ». Pas de nouvel artboard.'
    raison: 'Même motif que les états dessinés pour D-041 ; seul l''emplacement change, comme pour D-036. P-05 n''a pas de fil : le bas du panneau en tient lieu.'
    impacte: [F-016, F-019, F-048, F-049]
  - id: D-044
    sujet: Ce que la maquette simule
    choix: 'Hors démo, l''app fait pour de vrai ce que la maquette simule : P-04 montre les vraies invitations reçues et en attente (E-09) ; un post envoyé à un ami (F-019.a) arrive en message (E-11, champ post partagé) dans sa conversation avec l''expéditeur (E-10, P-09) ; « Copier le lien » (F-019.b) copie le lien du post dans le presse-papiers du téléphone ; « Partager ailleurs » (F-019.c) ouvre la feuille de partage du téléphone.'
    raison: 'Ces « à confirmer » de l''inventaire ne portaient que sur la démo ; le design dit déjà ce que fait l''app (L2-03).'
    impacte: [F-019, F-022, F-028]
  - id: D-045
    sujet: Brouillon abandonné
    choix: 'La croix « Fermer » de P-12 (F-005.a) abandonne le post en cours sans confirmation ni sauvegarde : rien n''est repris à la prochaine ouverture.'
    raison: 'C''est ce que montre le design ; garder un brouillon ajouterait une feature et une donnée stockée.'
    impacte: [F-005]
  - id: D-046
    sujet: Actions sur un résultat de recherche
    choix: 'Un post ouvert depuis la recherche (P-16) a les mêmes actions que dans le fil (P-03) : liker (F-016), commenter (F-017), enregistrer (F-018), partager (F-019). P-16 est à redessiner : F-010, F-016, F-017, F-018 et F-019 portent design_a_mettre_a_jour: true jusqu''à ce que le prompt 9 constate que le design correspond.'
    raison: 'Choix du propriétaire : un post trouvé se traite comme un post du fil (L2-03, « mêmes actions que P-03 ? »).'
    impacte: [F-010, F-016, F-017, F-018, F-019]
  - id: D-047
    sujet: Une seule feature pour prendre une photo
    choix: 'F-069 « Prendre une photo pour un post » devient la variante F-046.a de F-046 « Prendre une photo » et est retiré (ids_retires). Le bouton appareil photo au-dessus de la grille (P-12) et « Ouvrir l''appareil photo » de la galerie vide (P-12.a) prennent la même photo pour le post. Le design reste tel quel.'
    raison: 'Choix du propriétaire : deux boutons, une seule intention et les mêmes données (E-04, E-03), regroupés comme pour D-001 et D-015. La raison de D-033 (« aucune feature existante ne prend de photo ») oubliait F-046 (L3-07).'
    impacte: [F-044, F-046]
  - id: D-048
    sujet: Invitation refusée
    choix: 'Refuser une invitation (F-028.a) supprime la demande : la relation d''amitié (E-09) n''a pas de statut « refusé », et l''expéditeur peut envoyer une nouvelle demande.'
    raison: 'Choix du propriétaire : le design ne montre jamais de statut « refusé », et F-028.a dit déjà que la demande est supprimée (B3-02).'
    impacte: [F-028]
  - id: D-049
    sujet: Un résultat de recherche se comporte comme un post du fil
    choix: 'Un post ouvert depuis la recherche (P-16) se comporte en tout comme un post du fil (P-03) : photo du publieur, légende tronquée au-delà d''environ 80 caractères avec « plus » / « moins » (F-020, F-021), like par double tap (F-016.a), défilement vertical des 18 résultats à partir de celui qu''on a touché (F-009.a), en plus des actions de D-046. F-020.a « Sans photo du publieur, légende jamais tronquée » est retiré (ids_retires). Le design de P-16 correspond au registre : F-010, F-016, F-017 et F-018 ne portent plus design_a_mettre_a_jour.'
    raison: 'Choix du propriétaire : le redessin de P-16 du 2026-11-21 va plus loin que D-046 et suit sa raison, « un post trouvé se traite comme un post du fil » (G-04).'
    impacte: [F-009, F-010, F-016, F-020, F-021]
  - id: D-050
    sujet: Panneaux ouverts depuis un résultat de recherche
    choix: 'Les panneaux Commentaires, Enregistrer dans une collection et Partager ouverts depuis P-16 sont les pages P-05, P-06 et P-07, avec les mêmes features et les mêmes états qu''ouverts depuis P-03. Leur nom perd « Accueil — ».'
    raison: 'Choix du propriétaire : mêmes panneaux, mêmes données, mêmes états ; de nouveaux IDs les dupliqueraient (L2-01).'
    impacte: [F-017, F-018, F-019]
  - id: D-051
    sujet: Plus aucune mention du flou
    choix: 'Le flou n''est expliqué nulle part. Sur P-03 comme sur P-16, les messages du partage sont « Lien copié. » et « Partagé. » ; le titre des posts du Profil (P-17, P-17.a à P-17.c) devient « Tes posts » ; le texte de l''état vide P-17.a devient « Tes posts s’affichent ici, avec leurs jours restants. ». F-019 et F-062 portent design_a_mettre_a_jour: true jusqu''à ce que le prompt 9 constate que le design correspond.'
    raison: 'Choix du propriétaire : la raison de D-018, « L''app n''explique nulle part ailleurs le flou ni le charabia », doit rester vraie (T-04, G-04).'
    impacte: [F-019, F-062]
  - id: D-052
    sujet: 'FL-01 : aucun compte à la connexion'
    choix: 'Quand le backend ne trouve aucun compte pour la connexion (F-001, F-001.a ou F-007), l''appli ouvre P-27 Inscription : F-070 fait choisir le pseudo (16 caractères au plus, comme F-056) et l''identifiant (@), puis ouvre P-03. P-27 relève de R-01 comme P-01 et P-02 (D-024), n''est pas grisé (D-009, D-019) et permet de revenir à P-01 (F-005). F-070 porte design_a_mettre_a_jour: true jusqu''à ce que P-27 soit dessinée.'
    raison: 'Choix du propriétaire : E-01 a besoin d''un pseudo et d''un identifiant, et aucun écran ne les faisait choisir (questions ouvertes de F-001 et F-007).'
    impacte: [F-001, F-005, F-007, F-070, P-27, E-01]
  - id: D-053
    sujet: 'FL-01 : session gardée et déconnexion'
    choix: 'La session reste ouverte sur l''appareil (E-02) : l''appli s''ouvre sur P-03 tant qu''on ne se déconnecte pas. F-071 « Se déconnecter », sur P-21 Mon compte, ferme la session et ramène à P-01 ; la suppression du compte (F-063) y ramène aussi. F-071 porte design_a_mettre_a_jour: true.'
    raison: 'Choix du propriétaire : seule la suppression du compte permettait de sortir.'
    impacte: [F-063, F-071, P-21, E-02]
  - id: D-054
    sujet: 'FL-01 : lien de post ouvert sans connexion'
    choix: 'Après la connexion qu''un lien de post a demandée (D-024), P-03 s''ouvre sur le post partagé, puis le fil continue comme d''habitude (F-009).'
    raison: 'Choix du propriétaire : le lien ne se perd pas à la connexion.'
    impacte: [F-009, F-019]
  - id: D-055
    sujet: 'FL-02 : notification d''un like'
    choix: 'Liker un post (F-016, F-016.a) crée une notification (E-08) pour son auteur ; retirer le like la supprime. Liker un commentaire (F-016.b) ne notifie personne. F-016 écrit E-08.'
    raison: 'Choix du propriétaire : P-04 montre les likes reçus (F-022), mais aucune feature n''écrivait E-08.'
    impacte: [F-016, F-022, E-08]
  - id: D-056
    sujet: 'FL-02 : notification d''un commentaire'
    choix: 'Publier un commentaire (F-030) crée une notification de type « commentaire » (E-08) pour l''auteur du post. P-04 montre aussi les commentaires reçus ; son état vide devient « Les invitations, les likes et les commentaires reçus s’affichent ici. ». F-022 porte design_a_mettre_a_jour: true jusqu''à ce que P-04 soit redessiné.'
    raison: 'Choix du propriétaire : l''auteur d''un post apprend qu''on l''a commenté.'
    impacte: [F-022, F-030, E-05, E-08]
  - id: D-057
    sujet: 'FL-02 : enregistrer un post'
    choix: 'Un post est dans une collection au plus (E-07). Un signet plein rouvre P-06, la collection choisie encadrée : un tap dessus retire le post (« Retiré de … »), un tap sur une autre, ou sur « Nouvelle collection » (F-031), l''y déplace (« Enregistré dans … »).'
    raison: 'Choix du propriétaire, conforme au design de P-06 : une seule collection encadrée, le panneau se ferme au choix.'
    impacte: [F-018, F-031, E-07]
  - id: D-058
    sujet: 'FL-02 : compteur de partages'
    choix: 'Chaque partage compte une fois dans le nombre de partages du post (E-03) : envoi à un ami (F-019.a), copie du lien (F-019.b) et feuille de partage du téléphone (F-019.c).'
    raison: 'Choix du propriétaire : les trois façons de partager se valent.'
    impacte: [F-019, E-03]
  - id: D-059
    sujet: 'FL-03 : options d''une story'
    choix: 'Identifier des personnes (F-048), le lieu (F-049) et l''audience (F-050) valent aussi pour une story : E-12 prend les champs audience, personnes identifiées et lieu. Le design ne change pas.'
    raison: 'Choix du propriétaire : P-13 offre les mêmes lignes quelle que soit la destination (F-068).'
    impacte: [F-048, F-049, F-050, F-051, E-12]
  - id: D-060
    sujet: 'FL-03 : liste d''amis proches'
    choix: 'L''audience « Amis proches » s''appuie sur une liste que l''utilisateur tient : E-09 prend le champ « ami proche (oui/non) ». Un lien « Modifier la liste » sous « Amis proches » dans P-26 ouvre le nouveau panneau P-28 : ses amis, une recherche et des cases rondes à cocher, comme P-24 (nouvelle feature F-072). F-050 et F-072 portent design_a_mettre_a_jour: true jusqu''à ce que P-26 et P-28 soient dessinés.'
    raison: 'Choix du propriétaire : la liste se règle là où elle sert.'
    impacte: [F-050, F-072, P-26, P-28, E-09]
  - id: D-061
    sujet: 'FL-03 : notification d''une identification'
    choix: 'Publier un post ou une story (F-051) où des personnes sont identifiées (F-048) crée pour chacune une notification de type « identification » (E-08). P-04 la montre ; F-022 garde design_a_mettre_a_jour: true jusqu''à ce que P-04 soit redessiné.'
    raison: 'Choix du propriétaire : comme pour un like (D-055) ou un commentaire (D-056), la personne apprend qu''on l''a identifiée.'
    impacte: [F-022, F-048, F-051, E-08]
  - id: D-062
    sujet: 'FL-03 : fermer la création d''un post'
    choix: 'La croix « Fermer » de P-12 (F-005.a) revient à la page d''où la création a été ouverte (P-03, P-08, P-14 à P-17), et non plus toujours à l''Accueil. Le brouillon reste abandonné (D-045). F-005 porte design_a_mettre_a_jour: true jusqu''à ce que le design le fasse.'
    raison: 'Choix du propriétaire : depuis « Ta story » ou le Profil, revenir à l''Accueil fait perdre sa place.'
    impacte: [F-005, F-026]
  - id: D-063
    sujet: 'Inscription : champs demandés'
    choix: 'P-27 demande seulement le pseudo et l''identifiant (@). La photo de profil et la description se règlent plus tard sur P-19 (F-056).'
    raison: 'Choix du propriétaire : le chemin le plus court jusqu''au fil.'
    impacte: [F-070, P-27]
  - id: D-064
    sujet: 'Inscription : états de chargement et d''erreur'
    choix: 'P-27 a deux états dessinés, selon D-027 et D-028 : P-27.a « Création du compte » (anneau dans le bouton, champs grisés) et P-27.b « Création : erreur » (message rouge avec « Réessayer », saisies gardées). Le cas « identifiant déjà pris » attend les règles de l''identifiant (question ouverte de F-070).'
    raison: 'Choix du propriétaire : mêmes états que le reste de l''appli.'
    impacte: [F-070, P-27]
  - id: D-065
    sujet: 'Déconnexion sans confirmation'
    choix: '« Se déconnecter » (F-071) sur P-21 ferme la session dès le premier tap et ouvre P-01, sans fenêtre de confirmation.'
    raison: 'Choix du propriétaire : se reconnecter est facile et rien n''est perdu.'
    impacte: [F-071]
  - id: D-066
    sujet: 'Texte du panneau Notifications vide'
    choix: 'P-04.a dit « Les invitations, les likes, les commentaires et les identifications reçus s’affichent ici. », avec les identifications de D-061.'
    raison: 'Choix du propriétaire : le texte nomme tout ce que le panneau peut montrer.'
    impacte: [F-022]
  - id: D-067
    sujet: 'États de chargement et d''erreur du panneau Amis proches'
    choix: 'La liste d''amis de P-28 (F-072) suit D-043, comme celle de P-24 : un anneau centré dans la liste pendant le chargement, puis un message sur place avec « Réessayer » si elle échoue. Pas de nouvel artboard.'
    raison: 'Choix du propriétaire : P-28 copie P-24 (D-060), seul l''emplacement change, comme pour D-036 (L1-02).'
    impacte: [F-072, P-28]
  - id: D-068
    sujet: 'FL-03 : photos et légende d''une story'
    choix: 'Une story garde les photos choisies (F-044, F-046) et la légende (F-047) : ces features écrivent aussi E-12 (« images », « texte »), comme D-059 pour les autres options. Le design ne change pas.'
    raison: 'Choix du propriétaire : P-12 et P-13 sont les mêmes pour les deux destinations (F-068) (L5-02).'
    impacte: [F-044, F-046, F-047, E-12]
  - id: D-069
    sujet: 'FL-01 : du compte supprimé à la Connexion'
    choix: 'Après « Supprimer définitivement » (F-063), « Compte supprimé » et « Merci d’être passé·e. » restent 2 s, puis P-01 s''ouvre ; la session de l''appareil est fermée (D-053). F-063 porte design_a_mettre_a_jour: true.'
    raison: 'Choix du propriétaire : l''au revoir reste visible et il n''y a plus rien à faire sur la page (T-04).'
    impacte: [F-063, P-21, P-01, E-02]
  - id: D-070
    sujet: 'FL-04 : notification d''une demande d''ami'
    choix: 'Envoyer une demande d''ami (F-034) crée une notification de type « invitation » (E-08) pour le destinataire ; elle compte dans la pastille de la cloche (F-022). Accepter ou refuser l''invitation (F-028, F-028.a) la supprime. Le design ne change pas.'
    raison: 'Choix du propriétaire : E-08 avait un type « invitation » qu''aucune feature n''écrivait, comme avant D-055 et D-061 (question ouverte de F-034).'
    impacte: [F-022, F-028, F-034, E-08]
  - id: D-071
    sujet: 'FL-04 : première conversation entre amis'
    choix: 'Accepter une invitation (F-028) crée une conversation vide (E-10) entre les deux amis : elle apparaît dans P-08 (F-037) chez l''un et l''autre et s''ouvre sur P-09.b « Aucun message ». Le design ne change pas.'
    raison: 'Choix du propriétaire : P-08.a dit « Ajoute un ami pour commencer à discuter. », mais aucune feature n''ouvrait de conversation avec un nouvel ami.'
    impacte: [F-028, F-034, F-037, F-038, E-10]
  - id: D-072
    sujet: 'FL-04 : invitation acceptée'
    choix: 'L''expéditeur n''est pas notifié quand sa demande est acceptée : il voit le nouvel ami dans P-08 (D-071) et « Ami » dans P-11 (F-043). E-08 ne prend pas de nouveau type.'
    raison: 'Choix du propriétaire : la nouvelle conversation suffit, sans redessiner P-04.'
    impacte: [F-028, F-043, E-08]
  - id: D-073
    sujet: 'FL-04 : demandes croisées'
    choix: 'Sur P-11, un compte qui a déjà envoyé une invitation à l''utilisateur (E-09 « en attente ») s''affiche avec « Ajouter » ; le toucher (F-034) accepte cette invitation comme F-028 : le bouton devient « Ami », la conversation est créée (D-071) et la notification supprimée (D-070). Le design ne change pas.'
    raison: 'Choix du propriétaire : les deux veulent être amis ; un quatrième statut demanderait de redessiner P-11.'
    impacte: [F-034, F-043, E-09]
  - id: D-074
    sujet: 'FL-05 : minuteur lié au compte'
    choix: 'Le minuteur de couleur (E-14) appartient au compte (E-01) et est gardé sur le serveur : même gris et même durée sur chaque téléphone. Ni la déconnexion (F-071) ni une réinstallation ne le remettent à zéro ; seul « Réinitialiser » (F-061) le fait.'
    raison: 'Choix du propriétaire : D-019 lie déjà le minuteur au compte (questions ouvertes de F-059, F-060 et F-061).'
    impacte: [F-024, F-059, F-060, F-061, E-14]
  - id: D-075
    sujet: 'FL-05 : temps qui fait griser'
    choix: 'Les cycles n''avancent que pendant que l''appli est ouverte et au premier plan, comme le temps d''utilisation (E-15) ; appli fermée ou en arrière-plan, le minuteur s''arrête. E-14 garde le temps passé dans le cycle en cours au lieu du début du cycle, et F-024 l''écrit. La maquette, qui compte le temps réel, ne change pas.'
    raison: 'Choix du propriétaire : on grise le temps passé à faire défiler, pas le temps loin de l''appli.'
    impacte: [F-024, F-059, E-14]
  - id: D-076
    sujet: 'FL-05 : changer la durée du cycle'
    choix: 'Changer la durée (F-060) garde les cycles déjà écoulés : la nouvelle durée vaut à partir du cycle en cours, et le gris ne saute jamais.'
    raison: 'Choix du propriétaire : la maquette recalculait tout avec la nouvelle durée, ce qui pouvait passer l''appli en noir et blanc d''un coup.'
    impacte: [F-060, E-14]
  - id: D-077
    sujet: 'FL-05 : enregistrement du minuteur'
    choix: 'Un changement de durée (F-060) ou une réinitialisation (F-061) s''applique tout de suite sur le téléphone, puis est renvoyé au serveur sans message jusqu''à ce qu''il soit enregistré. Pas d''état d''erreur, pas de nouvel artboard.'
    raison: 'Choix du propriétaire : le réglage ne regarde que son propriétaire ; un message d''erreur gênerait pour rien.'
    impacte: [F-060, F-061, E-14]
  - id: D-078
    sujet: 'FL-06 : story vue par compte'
    choix: 'Une story est vue ou non pour chaque compte qui la regarde : E-12 remplace « vue / non vue » par « vue par » (les comptes qui l''ont vue). Elle compte comme vue quand le lecteur P-10 se ferme (croix ou fin automatique), quelle que soit l''image atteinte ; une story dont aucune image ne s''est affichée (P-10.b) reste non vue. F-036 écrit « vue par » ; si le serveur ne l''a pas, le cercle passe quand même au gris et c''est renvoyé sans message, comme D-077. Le design ne change pas.'
    raison: 'Choix du propriétaire : c''est ce que montre la maquette, et chaque ami a ses propres cercles (question ouverte de F-036).'
    impacte: [F-036, E-12]
  - id: D-079
    sujet: 'FL-06 : durée d''une story'
    choix: 'Une story dure 24 h après sa publication (F-051) : ensuite elle disparaît de la rangée et des cercles de P-08 et P-09, et ne se rouvre plus. E-12 prend le champ « fin ». Ouverte juste après sa fin, elle montre P-10.b ; son cercle disparaît au chargement suivant. Le design ne change pas.'
    raison: 'Choix du propriétaire : E-12 avait une ancienneté mais aucune fin, et aucune feature ne retirait une story.'
    impacte: [F-036, F-051, E-12]
  - id: D-080
    sujet: 'FL-06 : qui voit une story'
    choix: 'Une story ne se montre qu''aux amis de son auteur (E-09 « ami »). Les audiences « Tout le monde » et « Amis » (F-050) la montrent à tous ses amis ; « Amis proches », seulement aux amis cochés dans sa liste (D-060). P-08 et P-09 ne montrent que les stories qu''on peut voir. F-036 lit E-09.'
    raison: 'Choix du propriétaire : seul Messages montre des stories, et seulement celles des amis (question ouverte de F-036).'
    impacte: [F-036, F-050, E-09, E-12]
  - id: D-081
    sujet: 'FL-06 : plusieurs stories d''un ami'
    choix: 'Un ami a un seul cercle, même avec plusieurs stories en cours : P-10 les enchaîne de la plus ancienne à la plus récente, les barres de progression repartant à chaque story, et se ferme après la dernière image de la dernière. Le cercle reste vert tant qu''une de ses stories n''est pas vue. À la fermeture, chaque story dont une image a été montrée compte comme vue (D-078). Le design ne change pas.'
    raison: 'Choix du propriétaire : la rangée de P-08 montre un rond par ami, pas par story.'
    impacte: [F-036, E-12]
  - id: D-082
    sujet: 'FL-07 : discuter seulement entre amis'
    choix: 'Une conversation (E-10) n''existe qu''entre deux amis (E-09 « ami ») : elle naît quand une invitation est acceptée (D-071), et rien ne permet d''écrire à un autre compte. F-037 à F-042 ne portent que sur ces conversations. Le design ne change pas.'
    raison: 'Choix du propriétaire : P-08.a dit déjà « Ajoute un ami pour commencer à discuter. » (questions ouvertes de F-037 à F-042).'
    impacte: [F-037, F-038, F-039, F-040, F-041, F-042, E-09, E-10]
  - id: D-083
    sujet: 'FL-07 : un message part en charabia'
    choix: 'Le téléphone change le texte d''un message en charabia, émojis gardés, avant de l''envoyer (F-041) : le vrai texte ne quitte jamais le téléphone, et personne, l''expéditeur compris, ne peut le relire. Un message cité (F-040) l''est en charabia. E-11 ne garde que le charabia. Le design ne change pas.'
    raison: 'Choix du propriétaire : le texte tapé n''est visible que moins d''1 s ; le garder ailleurs ne servirait à rien.'
    impacte: [F-040, F-041, E-11]
  - id: D-084
    sujet: 'FL-07 : recevoir un message'
    choix: 'Hors démo, les messages d''un ami arrivent en direct (D-044) : ils s''ajoutent à P-09 si elle est ouverte, et la conversation passe en gras avec le point bleu dans P-08 (F-037). « En train d''écrire » (F-038) montre la vraie saisie de l''ami ; les réponses automatiques de démo disparaissent. Aucune notification (E-08), aucune pastille sur l''icône Messages. Le design ne change pas.'
    raison: 'Choix du propriétaire : ce que simule la maquette, sans nouvel écran ni nouveau type de notification (question ouverte de F-038).'
    impacte: [F-037, F-038, E-08, E-10, E-11]
  - id: D-085
    sujet: 'FL-07 : la conversation suit les messages'
    choix: 'Envoyer un message (F-041) ou une photo (F-042) met à jour la conversation (E-10) : dernier message (« Toi : … » ou « Photo »), heure, et « non lu » chez l''ami. « Lu / non lu » est gardé pour chacun des deux amis : ouvrir la conversation (F-037) la passe en lu, et un message reçu pendant que P-09 est ouverte (F-038) la laisse lue. F-038, F-041 et F-042 écrivent E-10. Le design ne change pas.'
    raison: 'Choix du propriétaire : sans cela, P-08 ne montrerait jamais le dernier message ni le non-lu (L5-02).'
    impacte: [F-037, F-038, F-041, F-042, E-10]
  - id: D-086
    sujet: 'Photos et vidéos en art généré'
    choix: 'Dans toute l''app, une photo ou une vidéo n''est jamais montrée telle quelle : le téléphone en tire une graine (son empreinte), et des algorithmes simples dessinent à partir d''elle une image ou une vidéo générée, propre à chaque photo. Seuls la graine et le choix de l''algorithme quittent le téléphone, jamais la vraie photo. E-04 garde la graine et l''algorithme au lieu de l''image et de sa version floutée. Le flou du design tient lieu de cet art jusqu''au développement : le design ne change pas et aucune feature ne porte design_a_mettre_a_jour. Remplacée en partie par D-119 : seule la graine quitte le téléphone ; le serveur choisit l''algorithme et le téléphone dessine.'
    raison: 'Choix du propriétaire : un art qui naît de la photo remplace le flou, et, comme le charabia (D-083), rien de la vraie photo n''est envoyé.'
    impacte: [F-010, F-011, F-012, F-042, F-044, F-045, F-046, F-051, F-058, E-04, E-11]
  - id: D-087
    sujet: 'FL-08 : ce que trouve une recherche'
    choix: 'Le téléphone change le texte saisi en l''une des 5 palettes (soleil, océan, forêt, lavande, terre), par la somme des codes des caractères modulo 5 ; seule la palette est envoyée, jamais le texte. Les résultats (F-052) sont jusqu''à 18 posts de cette palette qu''on peut voir (D-088), les plus récents d''abord ; P-15.b « Aucun résultat » ne s''affiche que si aucun ne reste. E-13 reste sur le téléphone. Le design ne change pas. Remplacée en partie par D-139 : le texte devient une graine, plus une palette.'
    raison: 'Choix du propriétaire : comme le charabia (D-083), le texte tapé ne quitte pas le téléphone ; la grille par palette est déjà dessinée (question ouverte de F-052).'
    impacte: [F-052, P-15, E-03, E-13]
  - id: D-088
    sujet: 'FL-08 : qui voit un post'
    choix: 'L''audience d''un post (F-050) décide qui peut le voir : « Tout le monde », tout utilisateur connecté (R-02) ; « Amis », les amis de l''auteur (E-09 « ami ») ; « Amis proches », les amis cochés dans sa liste (D-060). L''auteur voit toujours les siens. Les résultats de recherche (F-052) et le post ouvert depuis eux (F-054, P-16) ne montrent que les posts qu''on peut voir. F-052 lit E-09.'
    raison: 'Choix du propriétaire : la recherche est le seul écran qui peut montrer des posts de non-amis, et « Tout le monde » n''aurait sinon aucun sens (questions ouvertes de F-010, F-050, F-052 et F-054).'
    impacte: [F-010, F-050, F-052, F-054, E-03, E-09]
  - id: D-089
    sujet: 'FL-08 : suggestions et tendances'
    choix: 'Suggestions et tendances (F-053, F-053.a) sont des mots de charabia que l''app tire elle-même. À chaque ouverture de P-14, 8 suggestions sont tirées au hasard ; aucun historique des recherches n''est gardé. Les 6 tendances sont classées par le nombre de posts qu''on peut voir dans leur palette d''arrivée (D-087, D-088), et ce nombre est celui affiché. Rien des recherches n''est envoyé ni gardé : E-13 reste sur le téléphone. F-053 lit E-03. Le design ne change pas. Remplacée en partie par D-139 : il n''y a plus de palette.'
    raison: 'Choix du propriétaire : sans texte envoyé (D-087), le serveur ne peut ni garder d''historique ni compter les recherches (question ouverte de F-053).'
    impacte: [F-053, E-03, E-13]
  - id: D-090
    sujet: 'FL-08 : fermer une création ouverte depuis la Recherche'
    choix: 'Ouverte depuis P-14, P-15 ou P-16, la création d''un post se ferme (F-005.a) sur P-14 : la recherche repart de zéro, comme le fait la maquette. D-062 vaut pour les autres pages. Le design ne change pas.'
    raison: 'Choix du propriétaire : la maquette le fait déjà, et une recherche se relance en une saisie.'
    impacte: [F-005, F-026, P-14]
  - id: D-091
    sujet: 'Photo de profil nette environ 1 s'
    choix: 'Après un changement de photo de profil (F-058), la photo choisie se montre telle quelle environ 1 s, sur le téléphone de son propriétaire seulement, puis laisse place à son art généré (D-086), comme le texte tapé avant le charabia (D-083). Seuls la graine et l''algorithme quittent le téléphone. Le design ne change pas. Remplacée en partie par D-119 : seule la graine quitte le téléphone.'
    raison: 'Choix du propriétaire : c''est ce que dessine la maquette, et la vraie photo ne quitte jamais le téléphone (T-04).'
    impacte: [F-058, E-04]

  - id: D-092
    sujet: 'FL-09 : paiement du soutien'
    choix: 'Le soutien (F-015, F-015.a) est un achat unique dans l''App Store ou Google Play, à 1,99 €, une seule fois par compte : le serveur garde le statut dans E-16, rendu sur un autre téléphone ou après une réinstallation.'
    raison: 'Choix du propriétaire : les stores imposent leur paiement pour un achat numérique dans une appli.'
    impacte: [F-015, E-16]

  - id: D-093
    sujet: 'FL-09 : temps d''utilisation lié au compte'
    choix: 'Le temps d''utilisation (E-15) appartient au compte (E-01) et est gardé sur le serveur, comme le minuteur de couleur (D-074) : même temps sur chaque téléphone, gardé après une déconnexion ou une réinstallation. Il ne compte que pendant que l''appli est ouverte et au premier plan, connecté (D-075).'
    raison: 'Choix du propriétaire : l''heure qui ouvre l''offre est celle passée sur le compte, pas sur un téléphone.'
    impacte: [E-15, F-065, F-015, F-073]

  - id: D-094
    sujet: 'FL-09 : après le soutien'
    choix: 'Comme la maquette : sur P-22, l''anneau et l''offre restent, et « Merci pour ton soutien. » remplace le bouton pour de bon. Le post Premium (F-015.a) montre le même merci jusqu''au prochain chargement du fil, puis n''est plus jamais proposé.'
    raison: 'Choix du propriétaire : c''est ce que dessine la maquette ; le design ne change pas.'
    impacte: [F-015, E-16]

  - id: D-095
    sujet: 'FL-09 : soutien payé mais pas enregistré'
    choix: '« Merci pour ton soutien. » s''affiche dès que le store confirme l''achat. Si le serveur ne l''enregistre pas dans E-16, l''appli le renvoie sans message à chaque ouverture jusqu''à ce qu''il le soit, comme D-077. P-22.a et P-03.c ne s''affichent que si le store n''a pas débité.'
    raison: 'Choix du propriétaire : on n''affiche jamais une erreur à quelqu''un qui a payé.'
    impacte: [F-015, E-16]

  - id: D-096
    sujet: 'FL-09 : qui compte le temps d''utilisation'
    choix: 'Nouvelle feature F-073 « Compter le temps d''utilisation », tâche de fond sans élément visible, sur les mêmes pages que F-024 : chaque seconde passée appli ouverte et au premier plan s''ajoute à E-15 (D-093). Elle continue après les 10 cycles de F-024. F-065 ne fait que lire E-15.'
    raison: 'Choix du propriétaire : aucune feature n''écrivait E-15, et F-024 grise et s''arrête après 10 cycles.'
    impacte: [F-073, E-15, F-065]

  - id: D-097
    sujet: Durée de vie d'un post du fil
    choix: 'Un post du fil (E-03) n''expire jamais : il reste dans le fil, la recherche et le profil tant que le compte de son auteur existe (F-063). Aucun flow d''expiration. E-03 perd le champ « jours restants avant expiration ». P-17 n''affiche plus de jours restants, et le texte de l''état vide P-17.a devient « Tes posts s’affichent ici. » (au lieu de celui fixé par D-051). F-062 porte design_a_mettre_a_jour: true jusqu''à ce que le prompt 9 constate que le design correspond. Les stories gardent leurs 24 h (D-079).'
    raison: Choix du propriétaire.
    impacte: [E-03, F-062, F-051, F-009]

  - id: D-098
    sujet: 'FL-11 : pseudo et description en charabia'
    choix: 'Le téléphone change le pseudo et la description en charabia, émojis gardés, avant de les envoyer (F-056), comme un message (D-083) : le vrai texte ne quitte jamais le téléphone, et personne, le titulaire compris, ne peut le relire. E-01 ne garde que le charabia, et P-19 est prérempli avec ce charabia. Le texte tapé reste visible moins d''1 s sur P-17, sur ce téléphone seulement. L''identifiant (@) reste en clair (F-043, F-057). La maquette, qui préremplit P-19 avec le texte tapé plus tôt dans la même session, ne change pas.'
    raison: 'Choix du propriétaire : le profil suit la règle des messages (D-083) et de la recherche (D-087).'
    impacte: [F-056, F-057, E-01, P-19]

  - id: D-099
    sujet: 'FL-11 : pseudo ou description vides'
    choix: 'Sur P-19, « Enregistrer » avec un pseudo vide garde l''ancien pseudo, sans message ; la description peut être vidée. Le design ne change pas.'
    raison: 'Choix du propriétaire : c''est ce que fait la maquette, et un compte garde toujours un pseudo (question ouverte de F-056).'
    impacte: [F-056, E-01]

  - id: D-100
    sujet: 'FL-11 : enregistrement de la photo de profil'
    choix: 'Une nouvelle photo de profil (F-058) s''applique tout de suite sur le téléphone, puis sa graine et son algorithme (D-086) sont renvoyés au serveur sans message jusqu''à ce qu''ils soient enregistrés, comme D-077. Pas d''état d''erreur réseau : P-18.a ne sert qu''à un fichier inutilisable. Pas de nouvel artboard. Remplacée en partie par D-119 : seule la graine est renvoyée, le serveur choisit l''algorithme.'
    raison: 'Choix du propriétaire : comme le minuteur, la photo se renvoie d''elle-même ; un message gênerait pour rien.'
    impacte: [F-058, E-01, E-04]

  - id: D-101
    sujet: 'FL-11 : ce qu''efface la suppression du compte'
    choix: '« Supprimer définitivement » (F-063) efface tout de suite et pour de bon, sans délai de grâce, tout ce qui vient du compte : E-01 ; ses sessions sur tous les téléphones (E-02), un autre téléphone ouvrant P-01 à son prochain échange avec le serveur ; ses posts (E-03) et leurs médias (E-04) ; ses stories (E-12) ; ses commentaires (E-05) et ses likes (E-06) ; ses collections (E-07) ; les notifications qu''il a reçues ou causées (E-08) ; ses relations d''amitié et invitations (E-09) ; ses conversations et leurs messages (E-10, E-11), qui disparaissent aussi du P-08 de ses amis ; son minuteur (E-14), son temps d''utilisation (E-15) et son soutien (E-16), si bien qu''un nouveau compte de la même personne repart non soutenu. Les compteurs des autres comptes baissent d''autant. Ce qui attendait d''être renvoyé pour ce compte (D-077, D-078, D-095, D-100 ; D-109) est abandonné. L''effacement est tout ou rien : s''il échoue, P-21.a dit que rien n''a été effacé. Précisée par D-128 : les sauvegardes du serveur, gardées 7 jours au plus, et le seul numéro interne du compte, gardé 7 jours (FL-15). Le design ne change pas.'
    raison: 'Choix du propriétaire : la fenêtre de confirmation dit déjà que posts, messages et amis sont effacés, et que c''est définitif (question ouverte de F-063).'
    impacte: [F-063, E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-14, E-15, E-16]

  - id: D-102
    sujet: 'FL-11 : identifiant d''un compte supprimé'
    choix: 'L''identifiant (@) d''un compte supprimé (F-063) est libéré tout de suite : n''importe qui peut le prendre à l''inscription (F-070). Rien du compte n''est gardé, pas même son @, sauf son seul numéro interne, 7 jours (précisée par D-128). Les autres règles de l''identifiant restent une question ouverte de F-070.'
    raison: 'Choix du propriétaire : ses amitiés étant effacées (D-101), personne ne peut prendre le nouveau titulaire pour l''ancien.'
    impacte: [F-063, F-070, E-01]

  - id: D-103
    sujet: 'FL-11 : préférences d''interface sur le téléphone'
    choix: 'Les préférences d''interface (E-17 : thème de l''icône, carrousels de pause) appartiennent au téléphone, pas au compte : gardées sur le téléphone, jamais envoyées. P-01 montre donc le thème choisi sur ce téléphone avant toute connexion (F-002). Un nouveau téléphone, ou une réinstallation, part du thème Noir avec les carrousels de pause activés ; ni la déconnexion (F-071) ni la suppression du compte (F-063) ne les changent. P-23 fait partie de FL-11. Le design ne change pas.'
    raison: 'Choix du propriétaire : l''icône de l''appli est un réglage du téléphone, et P-01 en a besoin avant la connexion (questions ouvertes de F-002, F-066 et F-067).'
    impacte: [F-002, F-012, F-066, F-067, E-17]

  - id: D-104
    sujet: 'FL-11 : envois en attente à la déconnexion'
    choix: 'À la déconnexion (F-071), ce qui attend encore d''être renvoyé au serveur (minuteur, D-077 ; « vue » d''une story, D-078, D-109 ; soutien, D-095 ; photo de profil, D-100) reste sur le téléphone, rattaché au compte, et part à sa prochaine connexion sur ce téléphone. Rien n''est jamais envoyé pour un autre compte qui se connecte sur le même téléphone. Le design ne change pas.'
    raison: 'Choix du propriétaire : se déconnecter ne fait rien perdre (D-065).'
    impacte: [F-071, F-015, F-058, F-060, F-061, E-02]

  - id: D-105
    sujet: 'Étape 6 : deux téléphones ouverts en même temps'
    choix: 'Le minuteur de couleur (E-14) et le temps d''utilisation (E-15) du compte avancent tant qu''au moins un de ses téléphones a l''appli ouverte et au premier plan ; les secondes où deux téléphones sont ouverts ensemble ne comptent qu''une fois. Les questions ouvertes de F-024 et F-073 sont closes. Le design ne change pas.'
    raison: 'Choix du propriétaire : le gris et l''offre de soutien suivent le vrai temps passé, quel que soit le nombre de téléphones.'
    impacte: [F-024, F-073, E-14, E-15]

  - id: D-106
    sujet: 'Étape 6 : pastille de la cloche'
    choix: 'Une notification (E-08) est vue ou non vue. La pastille de la cloche (F-022) compte les notifications non vues ; ouvrir le panneau P-04 les marque toutes vues et la pastille disparaît. F-022 écrit E-08. Le design ne change pas.'
    raison: 'Choix du propriétaire : rien ne disait ce qui fait disparaître la pastille, et E-08 n''avait pas d''état « vue ».'
    impacte: [F-022, E-08]

  - id: D-107
    sujet: 'Étape 6 : diagrammes d''états et modèles TLA+'
    choix: 'Huit entités ont un diagramme d''états dans la Conception système : SM-E-02 Connexion, SM-E-03 Post, SM-E-08 Notification, SM-E-09 Relation d''amitié, SM-E-10 Conversation, SM-E-12 Story, SM-E-14 Minuteur de couleur, SM-E-16 Soutien. Les autres entités ne font qu''exister puis être effacées. Auront un modèle TLA+ : SM-E-09, SM-E-12, SM-E-14, SM-E-16, et un modèle de synchronisation des envois en attente et des téléphones ouverts ensemble (D-104, D-105). Complété par D-124 : SM-E-04 Média et son modèle.'
    raison: 'Choix du propriétaire : ce sont les entités où deux comptes, deux téléphones, le store ou un renvoi peuvent se croiser.'
    impacte: [E-02, E-03, E-08, E-09, E-10, E-12, E-14, E-16]

  - id: D-108
    sujet: 'Étape 5 : renvoi des envois en attente'
    choix: 'Le renvoi au serveur de ce qui attend d''être enregistré (minuteur, D-077 ; « vue » d''une story, D-078 ; soutien, D-095 ; photo de profil, D-100) est une tâche de fond décrite par un flow à elle, FL-12 : quand elle part, dans quel ordre, et ce qui se passe si le serveur refuse un envoi pour de bon. Les lignes « renvoyé sans message » de FL-05, FL-06, FL-09 et FL-11 y renvoient. Le design ne change pas.'
    raison: 'Choix du propriétaire : le modèle TLA+ de synchronisation (D-107) a besoin de ces règles, éparpillées dans quatre flows.'
    impacte: [F-015, F-036, F-058, F-060, F-061, E-12, E-14, E-16]

  - id: D-109
    sujet: 'Étape 5 : « vue » d''une story en attente'
    choix: 'Une « vue » de story pas encore enregistrée (D-078) suit les mêmes règles que les trois autres envois en attente : gardée à la déconnexion pour le même compte sur ce téléphone (D-104), abandonnée avec le compte (D-101). D-101, D-104 et FL-11 la nomment avec les autres. Le design ne change pas.'
    raison: 'Choix du propriétaire : une seule règle pour tous les envois en attente.'
    impacte: [F-036, F-063, F-071, E-12]

  - id: D-110
    sujet: 'Étape 5 : fin d''une story'
    choix: 'Quand la fin d''une story est atteinte (champ « fin » de E-12, 24 h après la publication, D-079), une tâche de fond du serveur la passe à Finie et l''efface du serveur : ses images et sa liste « vue par ». Le flow FL-13 la décrit. La question ouverte de F-036 sur une story finie est close. Le design ne change pas.'
    raison: 'Choix du propriétaire : rien dans l''appli ne rouvre une story finie, donc rien n''a besoin de la garder.'
    impacte: [F-036, E-12]

  - id: D-111
    sujet: 'Étape 5 : réglages du minuteur venus de deux téléphones'
    choix: 'Quand deux téléphones du même compte ont changé le minuteur hors connexion (durée, F-060 ; réinitialisation, F-061), le serveur garde le changement fait le plus tard selon l''heure des téléphones, quel que soit l''ordre où ils arrivent. La question ouverte de F-060 est close. Le design ne change pas.'
    raison: 'Choix du propriétaire : c''est le dernier choix de la personne qui compte.'
    impacte: [F-060, F-061, E-14]

  - id: D-112
    sujet: 'FL-12 : quand partent les envois en attente'
    choix: 'Les envois en attente (D-108) partent à chaque ouverture de l''appli ou retour au premier plan, et dès que le réseau revient pendant que l''appli est ouverte, toujours pour le compte connecté (D-104). Cela élargit le « à chaque ouverture » de D-095. Le design ne change pas.'
    raison: 'Choix du propriétaire : le serveur, et donc les autres téléphones du compte, rattrapent plus tôt.'
    impacte: [F-015, F-036, F-058, F-060, F-061]

  - id: D-113
    sujet: 'FL-12 : envoi refusé pour de bon'
    choix: 'Quand le serveur refuse pour de bon un envoi en attente (compte supprimé, story déjà effacée par D-110, données invalides), et non parce qu''il est injoignable, l''envoi est abandonné sans message, et au chargement suivant le téléphone montre ce que le serveur a. Un soutien (D-095) n''est jamais abandonné ainsi : il est renvoyé jusqu''à ce qu''il soit enregistré. Le design ne change pas.'
    raison: 'Choix du propriétaire : le serveur fait foi, sauf pour un achat déjà débité.'
    impacte: [F-036, F-058, F-060, F-061, E-01, E-04, E-12, E-14]

  - id: D-114
    sujet: 'Étape 6 : ce que crée la création du compte'
    choix: 'Créer son compte (F-070) crée aussi, à leurs valeurs de départ, le minuteur de couleur (E-14 : arrêté, aucun cycle écoulé), le temps d''utilisation (E-15 : 0 s) et le soutien (E-16 : non soutenu) du compte. F-070 les ajoute à ses entités. Le design ne change pas.'
    raison: 'Choix du propriétaire : SM-E-14 et SM-E-16 partent déjà de F-070 ; un compte a ses compteurs dès sa création.'
    impacte: [F-070, E-14, E-15, E-16]

  - id: D-115
    sujet: 'Étape 6 : un seul soutien par compte'
    choix: 'Le serveur n''enregistre qu''un soutien par compte (D-092) : E-16 ne passe à Soutenu qu''une fois. Un second achat fait sur un autre téléphone du compte avant que le serveur ait enregistré le premier (D-095) n''y change rien ; ce qu''il devient chez le store est une question ouverte de F-015. La règle « un compte ne paie qu''une fois » du modèle SM-E-16 devient « le serveur n''enregistre qu''un soutien par compte ». Le design ne change pas.'
    raison: 'Choix du propriétaire : l''appli ne peut pas empêcher deux achats faits sur deux téléphones dans cette fenêtre, et le cas est rare.'
    impacte: [F-015, E-16]

  - id: D-116
    sujet: 'Étape 6 : soutien en attente d''un compte supprimé'
    choix: 'Précise D-113 : un soutien en attente (D-095) est abandonné quand son compte est supprimé, sur ce téléphone ou sur un autre (D-101), comme les autres envois en attente. Hors suppression du compte, il est toujours renvoyé jusqu''à ce qu''il soit enregistré. Le design ne change pas.'
    raison: 'Choix du propriétaire : le compte n''existe plus et rien ne peut enregistrer le soutien ; sinon il attendrait pour toujours sur le téléphone.'
    impacte: [F-015, F-063, E-16]

  - id: D-117
    sujet: 'Étape 6 : temps passé sans réseau'
    choix: 'Les secondes passées appli ouverte et au premier plan sans réseau comptent pour le minuteur (E-14, F-024) et le temps d''utilisation (E-15, F-073). Le téléphone note chaque période (début et fin, à l''heure du téléphone) et la renvoie comme un envoi en attente de FL-12 (D-108, D-112), avec les mêmes règles (D-101, D-104, D-109). Le serveur la fusionne avec les périodes des autres téléphones du compte : une seconde où deux téléphones sont ouverts ne compte qu''une fois (D-105). Comme pour D-111, l''heure des téléphones ordonne périodes et réglages : seules les secondes après la dernière réinitialisation (F-061) comptent pour le minuteur. Pendant l''attente, le téléphone grise déjà selon son propre compte. Le design ne change pas.'
    raison: 'Choix du propriétaire : sinon le mode avion arrêterait le gris et le compte vers 1 h.'
    impacte: [F-024, F-061, F-073, E-14, E-15]

  - id: D-118
    sujet: 'Tout texte écrit part en charabia'
    choix: 'Dans toute l''app, le téléphone change en charabia, émojis gardés, tout texte qu''un utilisateur écrit, avant de l''envoyer : légende d''un post ou d''une story (F-047, F-051), commentaire (F-030), message (D-083), pseudo et description (D-098). Le vrai texte ne quitte jamais le téléphone, et personne, l''auteur compris, ne peut le relire : E-03, E-05 et E-12 ne gardent que le charabia. Le charabia est fait de faux mots qu''on peut prononcer, comme le dessine le design (« vralo mizé »). Seuls restent lisibles l''identifiant (@) que chacun choisit (F-043, F-057) et les textes de l''app elle-même. La légende reste lisible dans le brouillon, sur ce téléphone seulement (D-068), et part en charabia à la publication. Le design ne change pas.'
    raison: 'Choix du propriétaire : une seule règle pour tout texte écrit, au lieu de la redire feature par feature (D-083, D-098) ; elle clôt la question ouverte de F-051 sur la légende.'
    impacte: [F-030, F-047, F-051, E-03, E-05, E-12]

  - id: D-119
    sujet: 'Art généré : le serveur choisit, le téléphone dessine'
    choix: 'Précise D-086 : seule la graine quitte le téléphone. Le serveur choisit l''algorithme de chaque photo ou vidéo et le garde avec elle (E-04) : le même média montre le même art à tous et le garde quand d''autres algorithmes s''ajoutent, et le serveur peut lui en donner un autre quand il veut. Il envoie au téléphone la graine et l''algorithme, décrit en données (des briques et leurs réglages : palette, formes, bruit, mouvement…), et le téléphone dessine l''art. Un nouvel algorithme fait de briques existantes ne demande pas de mise à jour de l''app ; une nouvelle brique, si. Le design ne change pas.'
    raison: 'Choix du propriétaire : créer de nouveaux algorithmes côté serveur sans mise à jour de l''app. Un art simple se dessine en quelques millisecondes sur un téléphone, et des graines et des données pèsent bien moins que des images ou des vidéos.'
    impacte: [F-010, F-011, F-012, F-042, F-044, F-045, F-046, F-051, F-058, E-04]

  - id: D-120
    sujet: 'Publier : la graine part tôt, le post se transforme en fondu'
    choix: 'Dès qu''une photo ou une vidéo est choisie ou prise (F-044, F-046), le téléphone envoie sa graine au serveur, qui choisit l''algorithme (D-119), et dessine l''art généré en arrière-plan pendant que l''utilisateur écrit la légende. Sans réseau, la graine part dès qu''il revient, au plus tard avec la publication. Jusqu''à la publication, P-12 et P-13 montrent la vraie photo et la vraie légende, sur ce téléphone seulement. Après « Partager dans le fil » ou « Partager en story » (F-051), P-13.a « Publication… » reste affiché jusqu''à ce que le serveur ait enregistré le post et que l''art soit prêt. Puis P-13.c : la vraie photo et la vraie légende s''effacent en fondu et laissent place à l''art généré et au charabia (D-118), et l''Accueil affiche « Post publié. » ou Messages « Story publiée. » (D-031). En cas d''échec (P-13.b), pas de fondu : la vraie photo et la vraie légende restent. Pareil pour un post et une story. P-13.c est dessiné.'
    raison: 'Choix du propriétaire : l''utilisateur voit son post devenir ce que verront les autres, et l''art est prêt sans attente au moment de publier.'
    impacte: [F-044, F-046, F-051, P-13.c, E-04]

  - id: D-121
    sujet: 'Graines d''une photo qui ne sera pas publiée'
    choix: 'Quand une photo choisie est retirée de la sélection (F-044) ou que le brouillon est abandonné par la croix « Fermer » (F-005.a, D-045), le serveur efface aussitôt les graines déjà envoyées (D-120) et leur algorithme (E-04). Une graine pas encore envoyée ne l''est jamais. Le design ne change pas.'
    raison: 'Choix du propriétaire : rien ne doit survivre d''un post qui n''est pas publié.'
    impacte: [F-044, F-046, F-005, E-04]

  - id: D-122
    sujet: 'FL-12 : graines et effacements de graines en attente'
    choix: 'La graine d''une photo choisie ou prise (D-120) et l''effacement des graines d''une photo retirée ou d''un brouillon abandonné (D-121) sont, sans réseau, des envois en attente de FL-12, avec ses règles : quand ils partent (D-112), du plus ancien au plus récent, abandonnés sans message si le serveur les refuse pour de bon (D-113), rattachés au compte à la déconnexion (D-104) et abandonnés avec lui (D-101). Une graine encore en attente quand son brouillon disparaît (croix « Fermer », appli fermée de force, téléphone éteint) n''est jamais envoyée (D-121) ; à la publication (F-051), celles qui attendent encore partent avec elle (D-120). Élargit la liste de D-108. Le design ne change pas.'
    raison: 'Choix du propriétaire : une seule règle pour tout envoi qui attend le réseau.'
    impacte: [F-005, F-044, F-046, F-051, E-04]

  - id: D-123
    sujet: 'Graines orphelines : effacées après 24 h'
    choix: 'Une tâche de fond du serveur efface, 24 h après son arrivée, toute graine rattachée à rien (ni post, ni story, ni message, ni photo de profil), avec son algorithme (E-04). Elle couvre le brouillon perdu sans « Fermer » (appli fermée de force, téléphone éteint) et l''effacement qui n''arrive jamais (D-121, D-122). Le flow FL-14 la décrit. Une publication faite plus tard renvoie les graines que le serveur n''a plus (F-051). La question ouverte de F-044 est close. Le design ne change pas.'
    raison: 'Choix du propriétaire : la même durée qu''une story (D-079) ; rien ne survit longtemps d''un post qui n''est pas publié (D-121).'
    impacte: [F-044, F-051, E-04]

  - id: D-124
    sujet: 'Étape 6 : diagramme d''états et modèle TLA+ du média'
    choix: 'Complète D-107 : E-04 Média a son diagramme d''états, SM-E-04, dans la Conception système : en attente sur le téléphone (FL-12, D-122), graine d''un brouillon sur le serveur (D-120), rattachée à un post, une story, un message ou une photo de profil, puis effacée (D-121, D-123, D-125, F-063). Il a aussi un modèle TLA+, SM_E_04.tla, où se croisent la publication, le retrait d''une photo, le brouillon perdu, l''effacement en attente et le ménage des 24 h (FL-14). Le design ne change pas.'
    raison: 'Choix du propriétaire : depuis D-120 et D-121, ce que devient une graine dépend de son état, et le téléphone, FL-12 et FL-14 peuvent se croiser.'
    impacte: [E-04, F-005, F-044, F-046, F-051, F-058]


```

```yaml
  - id: D-125
    sujet: 'Graine de l''ancienne photo de profil'
    choix: 'Quand le serveur enregistre une nouvelle photo de profil (F-058, D-100), il efface aussitôt la graine de l''ancienne et son algorithme (E-04) : il ne garde qu''une graine de photo de profil par compte. Le design ne change pas.'
    raison: 'Choix du propriétaire : rien ne reste d''une photo qu''on n''affiche plus, comme pour un brouillon abandonné (D-121).'
    impacte: [F-058, E-04]

  - id: D-126
    sujet: 'Étape 7 : rapidité de l''appli'
    choix: 'Sur un téléphone d''environ 5 ans (téléphones de référence : iPhone 12 sous iOS, Samsung Galaxy A52 sous Android), en 4G : le fil montre son premier post au plus 2 s après le toucher de l''icône ; les posts suivants s''affichent au plus 0,5 s après l''arrivée en bas du fil ; le message d''un ami s''affiche au plus 2 s après son envoi, les deux téléphones en ligne ; le défilement reste à 60 images par seconde, art généré compris. Ce sont NFR-X-10 à NFR-X-13 de la Conception système. Le design ne change pas.'
    raison: 'Choix du propriétaire : une appli qui paraît rapide sur un téléphone ancien, sans le coût d''un objectif instantané.'
    impacte: [F-009, F-010, F-011, F-041, F-042]

  - id: D-127
    sujet: 'Étape 7 : validité du code de connexion'
    choix: 'Le code à 6 chiffres reçu par e-mail (F-003) vaut 10 min ; après 5 essais faux (F-007), il ne marche plus, même juste, et P-02 montre l''état « code expiré » (P-02.b) avec « Renvoyer un code » (F-008). C''est NFR-X-8. La question ouverte de F-007 sur la durée et les essais est close. Le design ne change pas.'
    raison: 'Choix du propriétaire : le temps d''aller lire l''e-mail et de revenir, et assez d''essais pour une faute de frappe, pas assez pour deviner un code.'
    impacte: [F-003, F-007, F-008, E-02]

  - id: D-128
    sujet: 'Étape 7 : sauvegardes et compte supprimé'
    choix: 'Précise D-101 : les sauvegardes du serveur sont gardées 7 jours au plus, si bien qu''un compte supprimé (F-063) a disparu partout 7 jours après. Pour qu''une sauvegarde restaurée ne le fasse pas revenir, le serveur garde 7 jours le seul numéro interne du compte supprimé, sans rien d''autre (ni @, ni adresse, ni contenu, D-102), et l''efface à nouveau de toute sauvegarde restaurée. C''est NFR-X-4. Le flow FL-15 la décrit. Le design ne change pas.'
    raison: 'Choix du propriétaire : un filet de sécurité en cas de panne du serveur, sans qu''un compte supprimé survive plus d''une semaine.'
    impacte: [F-063, E-01]

  - id: D-129
    sujet: 'Étape 7 : services extérieurs'
    choix: 'L''appli ne parle qu''à son serveur, sauf pour ce qu''un flow exige (connexion Google ou Apple, F-001 ; paiement du store, D-092 ; envoi du code par e-mail, F-003) et pour les rapports de plantage. Un rapport de plantage ne porte que des données techniques (modèle et système du téléphone, version de l''appli, endroit du plantage), jamais un contenu, un texte tapé, une graine, un identifiant de compte ou une adresse e-mail. Aucune mesure d''audience, aucun traceur publicitaire. C''est NFR-X-5. Le design ne change pas.'
    raison: 'Choix du propriétaire : trouver les plantages sans suivre les gens, dans l''esprit du charabia et de l''art généré (D-083, D-086).'
    impacte: [F-001, F-003, F-015]

  - id: D-130
    sujet: 'Étape 7 : accessibilité'
    choix: 'Sur iOS et Android : le lecteur d''écran (VoiceOver, TalkBack) nomme chaque bouton, champ et lien ; chaque zone à toucher fait au moins 44 × 44 pt (iOS) ou 48 × 48 dp (Android) ; les textes de l''appli elle-même suivent la taille de texte du téléphone jusqu''à 200 % et gardent un contraste d''au moins 4,5:1 (3:1 en grand texte) à chaque niveau de gris ; si le téléphone demande moins d''animations, le fondu de la publication (D-120) devient un changement net et l''art généré des vidéos reste immobile, comme Inspire / Expire (F-014). Le gris (F-024), le charabia (D-118) et l''art généré (D-086) restent tels quels. Ce sont NFR-X-14 à NFR-X-17. Le design ne change pas.'
    raison: 'Choix du propriétaire : l''appli reste utilisable par qui voit mal ou touche mal, sans toucher à ce qui fait son propos.'
    impacte: [F-014, F-024, F-051]

  - id: D-131
    sujet: 'Étape 6 : renvoi du code de connexion'
    choix: 'Un nouveau code (F-008) remplace le précédent : seul le dernier code envoyé marche, avec 10 min et 5 essais neufs (D-127, NFR-X-8). Dans l''appli réelle, le serveur vérifie vraiment le code (F-007) et « Renvoyer un code » envoie vraiment un nouvel e-mail (F-008). Cela clôt la question ouverte de F-007 sur la vérification réelle du code et celle de F-008 sur le nouvel envoi. Le design ne change pas.'
    raison: 'Choix du propriétaire : un seul code valide à la fois est plus simple à comprendre et plus sûr ; la maquette acceptait tout code, l''appli réelle non.'
    impacte: [F-007, F-008, E-02]

  - id: D-132
    sujet: 'Étape 8 : appli mobile'
    choix: 'Une seule appli pour iOS et Android, en React Native avec Expo, écrite en TypeScript. L''art généré (D-086, D-119) est dessiné par Skia (react-native-skia), le même moteur sur les deux téléphones : le même média y montre le même art, à 60 images par seconde (NFR-X-13). Les noms accessibles (NFR-X-14) passent par les propriétés d''accessibilité de React Native, lues par VoiceOver et TalkBack. Le design ne change pas.'
    raison: 'Choix du propriétaire : chaque feature est faite une fois pour les deux téléphones, l''art est identique partout, et la langue est celle du serveur (D-133), si bien que ce qu''ils s''envoient est décrit une seule fois.'
    impacte: [E-04, F-010, F-011, F-042]

  - id: D-133
    sujet: 'Étape 8 : serveur'
    choix: 'Le serveur est écrit en TypeScript sur Node.js, avec Fastify. Il reçoit les requêtes de l''appli en HTTPS (NFR-X-6) et pousse en direct les messages et « en train d''écrire » (D-084) par une connexion WebSocket ouverte tant que l''appli est au premier plan. Les types des échanges et la description des algorithmes d''art en données (D-119) sont écrits une fois, dans un paquet partagé par l''appli (D-132) et le serveur. Le design ne change pas.'
    raison: 'Choix du propriétaire : une seule langue de bout en bout, et Node tient sans peine les premières dizaines de milliers de comptes.'
    impacte: [E-04, E-11, F-038, F-041]

  - id: D-134
    sujet: 'Étape 8 : stockage du serveur'
    choix: 'Le serveur garde tout dans une seule base PostgreSQL, hébergée et gérée par l''hébergeur : comptes, connexions, posts, médias (graines et algorithmes), commentaires, likes, collections, notifications, amitiés, conversations, messages, stories, minuteurs, temps d''utilisation, soutiens, et la liste des comptes supprimés de D-128. Les sauvegardes sont gardées 7 jours au plus (D-128, NFR-X-4). Un message est poussé à l''autre téléphone par LISTEN/NOTIFY de PostgreSQL, sans autre stockage ni file. Le design ne change pas.'
    raison: 'Choix du propriétaire : amitiés, audiences et compteurs restent toujours d''accord entre eux (NFR-X-7), et la suppression d''un compte efface tout en une seule transaction (D-101).'
    impacte: [E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-14, E-15, E-16, F-063]

  - id: D-135
    sujet: 'Étape 8 : stockage du téléphone'
    choix: 'Le téléphone garde dans une base SQLite (expo-sqlite) les envois en attente de FL-12, dans l''ordre, l''état de la recherche (E-13, sans historique, D-089) et les préférences d''interface (E-17). La session est dans le stockage sécurisé (Trousseau sur iOS, Keystore sur Android) par expo-secure-store (NFR-X-9). Le brouillon d''un post ou d''une story reste en mémoire et se perd si l''appli est fermée de force (D-121). Le design ne change pas.'
    raison: 'Choix du propriétaire : les envois en attente survivent à une fermeture forcée ou une batterie vide et partent toujours du plus ancien au plus récent (D-108).'
    impacte: [E-02, E-13, E-17]

  - id: D-136
    sujet: 'Étape 8 : ce que fait le serveur, ce que fait le téléphone'
    choix: 'Le serveur est seul à décider de ce que plusieurs comptes ou plusieurs téléphones partagent : comptes et sessions (E-01, E-02), vérification du code (D-131), droits à chaque requête (NFR-X-7), posts du fil et résultats de recherche selon l''audience (D-088), compteurs (E-01, E-03, E-05), notifications (E-08), amitiés et conversations (E-09, E-10), algorithme d''art de chaque média (D-119), fusion du minuteur et du temps d''utilisation entre téléphones (D-105, D-111), vérification de l''achat auprès du store (D-092), tâches de fond FL-13, FL-14 et FL-15. Le téléphone fait ce qui ne doit pas le quitter ou doit marcher sans réseau : charabia (D-118), graine d''une photo (D-086) et d''une recherche (D-139), dessin de l''art (D-119), brouillon (D-068), recherche et préférences d''interface (E-13, E-17, D-103), gris affiché et secondes comptées (D-117), envois en attente (FL-12). Il place aussi lui-même dans le fil les carrousels de pause (F-012.a) et les posts Inspire / Expire (F-014), qui ne portent aucune donnée de compte : le serveur ne connaît pas l''interrupteur de P-23 (NFR-X-3). Le serveur dit seulement, à chaque chargement du fil, si le post Premium (F-015.a) est à proposer (D-094), et le téléphone le place 1 post sur 20. Là où le design le dessine (like, enregistrement, FL-02), le téléphone montre le changement avant la réponse du serveur et revient en arrière s''il refuse. Le détail est dans la Conception système, section « Serveur, téléphone et API ». Le design ne change pas.'
    raison: 'Découle des décisions déjà prises : rien d''écrit ni de photographié ne quitte le téléphone (NFR-X-1 à NFR-X-3), et le serveur tient ce qui doit rester d''accord entre comptes (D-134, NFR-X-7).'
    impacte: [F-009, F-012, F-014, F-015]

  - id: D-137
    sujet: 'Étape 8 : découpage de l''API'
    choix: 'L''appli parle au serveur par une seule API en HTTPS et JSON (D-133, NFR-X-6), rangée en 10 groupes, un par domaine : connexion (FL-01), fil et posts (FL-02, FL-03), médias (FL-03, FL-14), amis et notifications (FL-04), minuteur et temps d''utilisation (FL-05, FL-09), stories (FL-06, FL-13), messages (FL-07), recherche (FL-08), soutien (FL-09), profil et compte (FL-11, FL-15). Chaque point d''entrée appartient à une seule feature ; ses types sont dans le paquet partagé (D-133). La connexion WebSocket ne sert qu''au direct : message reçu et « en train d''écrire » (D-084) ; envoyer un message passe par l''API. Règles communes : la session est un jeton opaque gardé par le serveur et envoyé à chaque requête (NFR-X-9) ; chaque écriture porte un numéro fait par le téléphone, si bien qu''un « Réessayer » ou un renvoi de FL-12 n''est jamais enregistré deux fois (D-115) ; les listes arrivent par pages (8 posts pour le fil, F-009) ; une erreur dit si l''envoi peut repartir ou s''il est refusé pour de bon (D-113) ; chaque réponse porte l''heure du serveur (D-140) ; chaque requête porte la version de l''API, et le serveur garde une version tant qu''une appli acceptée s''en sert (D-141). Le tableau des groupes est dans la Conception système, section « Serveur, téléphone et API ». Le design ne change pas.'
    raison: 'Un groupe par domaine suit les flows et les dossiers de features du serveur ; les règles communes tiennent les promesses déjà faites (pas de double enregistrement, refus pour de bon, vieilles versions qui marchent encore).'
    impacte: [F-009, F-038, F-041]

  - id: D-138
    sujet: 'Agir sur un post suit son audience'
    choix: 'On ne peut liker (F-016), commenter (F-017, F-030), enregistrer (F-018) ou partager (F-019) qu''un post qu''on a le droit de voir (D-088) ; le serveur le vérifie à chaque action (NFR-X-7). Si ce droit a été perdu pendant que le post était à l''écran (l''auteur vient de retirer la personne de ses amis proches), l''action est refusée : l''appli montre l''état d''échec déjà dessiné (P-03.e, P-03.f, P-05.c, P-05.d, P-07.a) et le post disparaît au chargement suivant. Les questions ouvertes d''accès de F-016, F-017, F-018, F-020, F-030 et F-050 sont closes ; reste, dans F-019, le partage d''un post « Amis proches ». Le design ne change pas.'
    raison: 'Choix du propriétaire : une seule règle pour voir et pour agir.'
    impacte: [F-016, F-017, F-018, F-019, F-020, F-030, F-050]

  - id: D-139
    sujet: 'Recherche par graine'
    choix: 'Remplace en partie D-087 et D-089 : le téléphone change le texte saisi en une graine, et seule la graine est envoyée, jamais le texte. Les résultats (F-052) sont jusqu''à 18 posts qu''on peut voir (D-088), les plus proches de cette graine d''abord, comparée à la graine des médias de chaque post (E-04). Les 5 palettes disparaissent de la recherche : E-03 perd le champ « palette », E-13 garde la graine obtenue au lieu de la palette, et la question ouverte de F-051 sur la palette d''un post est close. La règle exacte (comment un texte devient une graine, ce que « proche » veut dire, si un post trop loin est écarté) reste ouverte dans F-052 ; ce que comptent et montrent les tendances reste ouvert dans F-053. Les tuiles de P-15 et le post de P-16 montrent l''art généré de chaque post (D-086), dont les formes du design tiennent lieu : le design ne change pas.'
    raison: 'Choix du propriétaire : la recherche suit une graine, comme l''art généré, plutôt que 5 couleurs fixes ; l''algorithme reste à inventer.'
    impacte: [F-051, F-052, F-053, E-03, E-04, E-13]

  - id: D-140
    sujet: 'Heure des téléphones corrigée par celle du serveur'
    choix: 'Complète D-111 : chaque réponse du serveur porte son heure (D-137) ; le téléphone en tire son écart et l''applique, sans rien montrer, à l''heure de chaque envoi en attente (FL-12) et de chaque seconde comptée sans réseau (D-117). Un téléphone dont l''horloge est fausse ne fait donc plus gagner un réglage plus ancien. Sans réseau, il garde le dernier écart connu. La question ouverte de F-060 est close. Le design ne change pas.'
    raison: 'Choix du propriétaire : le dernier réglage de la personne gagne vraiment (D-111), même si l''horloge d''un téléphone est fausse.'
    impacte: [F-024, F-060, F-061, F-073, E-14, E-15]

  - id: D-141
    sujet: 'Étape 8 : appli trop vieille'
    choix: 'Quand la version de l''appli est trop vieille pour le serveur (D-137), l''appli ouvre la nouvelle page P-29 « Mise à jour requise » à la place de toute autre : un message, et un bouton qui ouvre l''appli dans l''App Store ou Google Play (nouvelle feature F-074 « Mettre à jour l''appli »). Rien d''autre n''est utilisable ; la session et les envois en attente (FL-12) sont gardés et repartent après la mise à jour. P-29 n''est jamais grisée, comme P-01 (D-009). F-074 porte design_a_mettre_a_jour: true jusqu''à ce que P-29 soit dessinée.'
    raison: 'Choix du propriétaire : dire clairement quoi faire, plutôt que laisser l''appli échouer partout.'
    impacte: [F-074, P-29]

  - id: D-142
    sujet: 'Textes de P-29 « Mise à jour requise »'
    choix: 'P-29 montre le logo de l’appli, le titre « Mise à jour requise », le message « Cette version de l’appli est trop ancienne. Mets-la à jour pour continuer : ton compte et tes envois en attente sont gardés. » et un bouton vert « Mettre à jour », le même texte sur iPhone et Android, jamais désactivé (F-074, D-141). P-29 est dessinée (artboard MiseAJour.dc.html) : F-074 ne porte plus design_a_mettre_a_jour.'
    raison: 'Choix du propriétaire : dire quoi faire et que rien n’est perdu ; un seul texte de bouton pour les deux stores.'
    impacte: [F-002, F-074, P-29]

  - id: D-143
    sujet: 'Étape 8 : vérification à l''exécution'
    choix: 'La commande app de la vérification à l''exécution (méthode, verification.md) s''appuie sur Maestro. Il pilote de l''extérieur l''appli telle qu''Expo la construit (D-132), sans rien y ajouter : il trouve chaque bouton, champ et lien par son nom accessible (NFR-X-14), lit ce que montre l''écran et prend les captures des preuves. L''audit de NFR-X-14 (0 élément sans nom) lit la même vue de l''écran. Les preuves tournent sur un simulateur iPhone et un émulateur Android, à chaque changement ; le test à deux téléphones de NFR-X-12 en lance deux à la fois. Les vrais téléphones ne sont vérifiés qu''à la main, avant une version. Le design ne change pas.'
    raison: 'Choix du propriétaire : Maestro marche avec une appli Expo sans changer sa construction et trouve les éléments comme un lecteur d''écran ; simulateur et émulateur ne coûtent rien et tournent à chaque changement.'
    impacte: []

  - id: D-144
    sujet: 'Étape 8 : modèle de données'
    choix: 'Le modèle de données est dans la Conception système, section « Modèle de données » : 33 tables, TB-01 à TB-33, dans la base PostgreSQL du serveur (N-01, D-134), la base SQLite du téléphone (N-02, D-135) et son stockage sécurisé (N-03). Règles : l''id de ce que crée un geste (post, média, commentaire, partage, message, story, notification…) est un uuid fait par le téléphone, si bien qu''un « Réessayer » ou un renvoi de FL-12 retombe sur la même ligne : c''est le numéro d''écriture de D-137 ; tout ce qui vient d''un compte pointe vers lui et s''efface avec lui, en une seule transaction (D-101) ; les compteurs (posts, amis, likes, commentaires, enregistrements, partages) sont comptés à la demande, jamais stockés ; un état se lit dans les lignes (l''absence d''amitié, une graine sans rattachement) plutôt que dans une colonne à part, sauf le statut d''une amitié, « vue » d''une notification et « lu » d''une conversation ; les types pause, inspire-expire et premium d''un post ne sont jamais stockés (D-136), et photo, vidéo ou carrousel se déduit de ses médias. Le design ne change pas.'
    raison: 'Chaque fait n''est gardé qu''à un endroit : rien à remettre d''accord, aucun compteur faux, et la suppression d''un compte n''oublie rien (NFR-X-4).'
    impacte: [E-01, E-02, E-03, E-04, E-05, E-06, E-07, E-08, E-09, E-10, E-11, E-12, E-13, E-14, E-15, E-16, E-17]

  - id: D-145
    sujet: 'Identifiant unique'
    choix: 'L''identifiant (@) d''un compte ne s''écrit qu''en minuscules, comme le dessine P-27 (« Minuscules, sans espace »), et il est unique : deux comptes ne peuvent pas avoir le même. Restent ouverts dans F-070 : longueur, caractères permis et message s''il est déjà pris. Le design ne change pas.'
    raison: 'Choix du propriétaire : personne ne peut passer pour un autre en changeant une majuscule.'
    impacte: [F-043, F-070, E-01]

  - id: D-146
    sujet: 'Amis proches : la liste du moment'
    choix: 'L''audience « Amis proches » (F-050) suit toujours la liste du moment (F-072), posts et stories déjà publiés compris : un ami retiré de la liste ne les voit plus, un ami ajouté les voit. C''est déjà ce que fait D-138 pour un post à l''écran. La question ouverte de F-072 sur les posts déjà publiés est close. Le design ne change pas.'
    raison: 'Choix du propriétaire : une seule règle pour voir et pour agir (D-138), sans rien garder par post.'
    impacte: [F-050, F-072, E-03, E-09, E-12]

  - id: D-147
    sujet: 'Périodes au premier plan gardées 7 jours'
    choix: 'Précise D-105 et D-117 : pour qu''une seconde ne compte qu''une fois quand deux téléphones sont ouverts ensemble (D-105, D-117), le serveur garde les périodes où l''appli du compte était au premier plan, 7 jours au plus après leur fin ; la tâche FL-17 efface les plus vieilles. Une période arrivée plus de 7 jours après sa fin (téléphone longtemps sans réseau) compte en entier, même si un autre téléphone était ouvert en même temps. Le design ne change pas.'
    raison: 'Choix du propriétaire : le serveur ne garde pas l''historique de l''usage de l''appli, comme pour les sauvegardes (D-128) ; un téléphone sans réseau plus d''une semaine est rare.'
    impacte: [F-024, F-073, E-14, E-15]

  - id: D-148
    sujet: 'Notification d''un post ou d''une story effacé'
    choix: 'Quand un post ou une story est effacé, ses notifications (like, commentaire, identification, D-061) le sont aussi : une story finie (FL-13, D-110), un post ou une story effacé avec le compte de son auteur (D-101). P-04 ne montre jamais une notification qui mène à un contenu qui n''existe plus. Le design ne change pas.'
    raison: 'Choix du propriétaire : une notification mène toujours à quelque chose.'
    impacte: [F-022, E-08, E-12]

  - id: D-149
    sujet: 'Adresse e-mail oubliée après 1 h'
    choix: 'Le serveur oublie une adresse e-mail, ou un compte Google ou Apple, qui n''a pas mené à un compte, au plus 1 h après : le code envoyé (F-003, F-008) et l''inscription commencée (P-27, F-070) sont effacés par la tâche FL-16 1 h après l''envoi du code ou le début de l''inscription. Le code, lui, ne marche que 10 min (D-127). Ce que voit quelqu''un qui finit son inscription plus d''1 h après reste ouvert dans F-070. Le design ne change pas.'
    raison: 'Choix du propriétaire : le serveur ne garde pas l''adresse de quelqu''un qui n''a pas de compte.'
    impacte: [F-003, F-008, F-070, E-02]

  - id: D-150
    sujet: 'Dernier minuteur connu sur le téléphone'
    choix: 'Complète D-135 : le téléphone garde aussi dans SQLite le dernier état du minuteur (E-14) reçu du serveur pour le compte connecté, et le dernier écart d''heure avec le serveur (D-140). Rouverte sans réseau, l''appli montre donc le même gris et continue de compter (D-117) ; le serveur reprend la main au retour du réseau. L''état du minuteur est effacé à la déconnexion (F-071) et à la suppression du compte (F-063). Le design ne change pas.'
    raison: 'Choix du propriétaire : le gris ne disparaît pas parce que l''appli a été fermée sans réseau.'
    impacte: [F-024, F-059, E-14]

  - id: D-151
    sujet: 'Étape 8 : flux de données'
    choix: 'Le graphe des flux de données est dans la Conception système, section « Flux de données » : 14 nœuds (N-01 à N-14) et 84 flux (DF-01 à DF-84). Une appli par téléphone (iOS, Android), même si leur code est commun (D-132), parce que chacune parle à son store. Les deux rôles ne parlent qu''à l''appli. Un flux est sensible dès qu''il porte une donnée liée à un compte : compte, connexion, post, commentaire, like, collection, notification, amitié, conversation, message, story, temps passé dans l''appli ou soutien (E-01 à E-03, E-05 à E-12, E-14 à E-16) ; un lieu, une personne identifiée, un like ou une vue de story lient un compte à un endroit ou à un autre compte, même quand les textes sont en charabia (D-118). Seuls ne le sont pas les flux qui ne portent que des graines et leurs algorithmes (E-04, E-13). Le service de rapports de plantage est un nœud (N-14) : il ne reçoit aucune donnée d''entité (NFR-X-5), si bien qu''aucun flux DF ne le cite, mais le graphe montre ce chemin pour le threat model. Le design ne change pas.'
    raison: 'Suit la méthode (prompt 12). Choix du propriétaire pour les flux sensibles et le service de rapports de plantage : le threat model examine tout ce qui lie un compte à un lieu ou à un autre compte, et vérifie NFR-X-5.'
    impacte: []

ids_retires:
  - {id: F-013, decision: D-002}
  - {id: F-023, decision: D-017}
  - {id: F-029, decision: D-015}
  - {id: F-032, decision: D-018}
  - {id: F-035, decision: D-001}
  - {id: F-058.a, decision: D-020}
  - {id: F-064, decision: D-020}
  - {id: F-067.a, decision: D-021}
  - {id: F-069, decision: D-047}
  - {id: F-020.a, decision: D-049}
```

## Regroupements effectués

| Feature | Justification |
| --- | --- |
| F-002 | Icône de l'appli sur P-01, P-22, P-23, P-29 : même donnée (thème), simple affichage ; taille et contexte en variantes. Le changement en direct relève de F-066. |
| F-005 | Flèches retour sur 8 pages : même geste sans donnée ; « Fermer » (P-12) et « Annuler » (P-19) en variantes car ils abandonnent une saisie. |
| F-010 | Voir un post sur P-03 et P-16 : même image ; P-16 sans actions en variante. |
| F-012 | Carrousel de photos et carrousel de pause : même geste de défilement ; la pause (ex-F-013) en variante F-012.a (décision D-002). |
| F-015 | Post Premium (P-03) et page Premium (P-22) : même achat à 1,99 €, statut partagé ; l'apparition 1 post sur 20 en variante. Le temps restant relève de F-065. |
| F-016 | Bouton cœur, double tap et like de commentaire : même intention ; double tap (ne retire pas) et commentaire (autre donnée) en variantes. |
| F-017 | Bulle de P-03 et liste de P-05 : un seul parcours. |
| F-018 | Signet de P-03 et choix ou retrait sur P-06 : une seule bascule. |
| F-019 | Flèche de P-03 en base ; les 3 options de P-07 en variantes (envoi à un ami depuis le panneau, copie du lien, autres apps). Les messages de confirmation sont des états (décision D-017). |
| F-020 | Photo, pseudo et légende : un seul bloc d'auteur ; P-16 (sans photo, sans troncature) en variante, retirée par D-049. |
| F-022 | Cloche et pastille (P-03) avec le panneau P-04 (défilement, likes, miniature). |
| F-024 | Grisage identique sur toutes les pages sauf la connexion (P-01, P-02). |
| F-025 | Les 4 icônes du menu sur 6 pages ; le bouton + reste à part dans F-026 car il ouvre un parcours de création. |
| F-026 | Bouton + du menu et rond « Ta story » : même écran de création ; « Ta story » (ex-F-035) en variante F-026.a car elle présélectionne Story (décision D-001). |
| F-027 | Croix, OK ou tap sur le fond sur 9 panneaux ; P-04 (pas de croix) et P-20 (animation) en variantes. |
| F-028 | Accepter et Refuser une invitation : même invitation, même panneau ; Refuser (ex-F-029) en variante F-028.a (décision D-015). |
| F-034 | Bouton + de P-08 et « Ajouter » sur P-11 ; l'affichage des statuts relève de F-043. |
| F-036 | 3 entrées (rangée P-08, photo de la liste P-08, photo P-09) et le lecteur P-10. |
| F-046 | Bouton appareil photo au-dessus de la grille (P-12) et « Ouvrir l'appareil photo » de la galerie vide (P-12.a) : même photo pour le post ; la galerie vide (ex-F-069) en variante F-046.a (décision D-047). |
| F-048 à F-050 | Chaque ligne de la légende (P-13) et son panneau (P-24, P-25, P-26) forment une seule feature. |
| F-052 | Saisir sur P-14, puis modifier, parcourir et revenir sur P-15. |
| F-055 | Engrenage de P-17 et panneau P-20 avec ses 3 entrées. |
| F-056 | Lien de P-17 et formulaire de P-19. |
| F-057 | Identité sur P-17 ; l'identifiant affiché sur P-21 en variante. |
| F-058 | Photo de P-17 et galerie de P-18 (les images de démo sont hors registre, décision D-020). |
| Même page | Champ + bouton : F-003, F-007, F-030, F-041, F-047. Attente + renvoi : F-008. Vidéo + progression : F-011. Carrousel + points : F-012. Glisser + citation + annuler : F-040. Saisie + résultats + aucun résultat : F-043. Aperçu + position + multiple + Suivant : F-044. Suggestion + tendance : F-053. État + segments : F-059. Allonger + raccourcir : F-060. Supprimer + confirmer + annuler : F-063. Temps passé + restant : F-065. |

## Cas ambigus

Aucun cas en attente : les 11 cas ont été tranchés le 15 novembre 2026 (décisions D-013 à D-023).
