<!-- Source: https://claude.ai/artifact/A5qaJU9xAkPWfJ6JUNfWHV, tab "Tab 1", rev 245, exported 2026-11-24 -->
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
    features: [F-009, F-010, F-011, F-012, F-012.a, F-014, F-015.a, F-016, F-016.a, F-017, F-018, F-019, F-020, F-021, F-022, F-024, F-025, F-026]
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
    features: [F-022, F-024, F-027.a, F-028, F-028.a]
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
    features: [F-016.b, F-017, F-024, F-027, F-030]
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
    features: [F-018, F-024, F-027, F-031]
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
    features: [F-019.a, F-019.b, F-019.c, F-024, F-027]
  - id: P-07.a
    nom: 'Envoi à un ami : échec'
    plateforme: mobile
    features: [F-019.a]
  - id: P-08
    nom: Messages — liste des discussions
    plateforme: mobile
    features: [F-024, F-025, F-026, F-026.a, F-033, F-034, F-036, F-037]
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
    features: [F-005, F-024, F-036, F-038, F-039, F-040, F-041, F-042]
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
    features: [F-024, F-036]
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
    features: [F-005, F-024, F-034, F-043]
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
    features: [F-005.a, F-024, F-044, F-045, F-046, F-046.a]
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
    features: [F-005, F-024, F-047, F-048, F-049, F-050, F-051, F-068]
  - id: P-13.a
    nom: Publication en cours
    plateforme: mobile
    features: [F-051]
  - id: P-13.b
    nom: 'Publication : erreur'
    plateforme: mobile
    features: [F-051]
  - id: P-14
    nom: Recherche — suggestions et tendances
    plateforme: mobile
    features: [F-024, F-025, F-026, F-052, F-053, F-053.a]
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
    features: [F-024, F-025, F-026, F-052, F-054]
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
    features: [F-005, F-009.a, F-010.a, F-016, F-016.a, F-017, F-018, F-019, F-020, F-021, F-024, F-025, F-026]
  - id: P-17
    nom: Profil
    plateforme: mobile
    features: [F-024, F-025, F-026, F-055, F-056, F-057, F-058, F-059, F-060, F-061, F-062]
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
    features: [F-024, F-027, F-058]
  - id: P-18.a
    nom: 'Photo : erreur de fichier'
    plateforme: mobile
    features: [F-058]
  - id: P-19
    nom: Modifier le profil
    plateforme: mobile
    features: [F-005.b, F-024, F-056]
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
    features: [F-024, F-027.b, F-055]
  - id: P-21
    nom: Mon compte
    plateforme: mobile
    features: [F-005, F-024, F-057.a, F-063, F-071]
  - id: P-21.a
    nom: Suppression échouée
    plateforme: mobile
    features: [F-063]
  - id: P-22
    nom: Premium
    plateforme: mobile
    features: [F-002.a, F-005, F-015, F-024, F-065]
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
    features: [F-002.b, F-005, F-024, F-066, F-067]
  - id: P-24
    nom: Nouveau post — panneau Identifier des personnes
    plateforme: mobile
    features: [F-024, F-027, F-048]
  - id: P-25
    nom: Nouveau post — panneau Ajouter un lieu
    plateforme: mobile
    features: [F-024, F-027, F-049]
  - id: P-26
    nom: Nouveau post — panneau Audience
    plateforme: mobile
    features: [F-024, F-027, F-050, F-072]
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
    features: [F-024, F-027, F-072]
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
    description: Carré arrondi avec un F blanc dont la couleur suit le thème choisi.
    pages: [P-01, P-22, P-23]
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
    questions_ouvertes:
      - 'Accès R-01 supposé : avant connexion, l''icône suit le thème choisi auparavant ; thème lié à l''appareil ou au compte ?'

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
        difference: Croix « Fermer » qui abandonne la création du post et revient à la page d'où elle a été ouverte (D-062)
        acces: [R-02]
      - id: F-005.b
        pages: [P-19]
        plateforme: mobile
        difference: Lien « Annuler » qui abandonne les saisies du profil
        acces: [R-02]
    entites: []
    operations: [lecture]
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
      - Vérification réelle du code (la maquette accepte tout code)
      - Remplissage automatique depuis l'e-mail selon le téléphone
      - Durée de validité du code et nombre d'essais faux avant blocage

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
    questions_ouvertes:
      - Nouvel envoi réel à confirmer

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
      - 'Post du lien partagé expiré, supprimé ou hors de son audience après la connexion (D-054)'

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
      - 'Accès supposé : les résultats de recherche montrent des posts de non-amis s''ils sont publics (audience du post, F-050)'

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
    description: Offre à 1,99 € en un seul paiement, proposée à partir de 1 h d'utilisation.
    pages: [P-03, P-22, P-22.a, P-22.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes:
      - id: F-015.a
        pages: [P-03, P-03.c]
        plateforme: mobile
        difference: Post du fil, 1 sur 20 après 1 h, retiré une fois le soutien donné
    entites: [E-16, E-15]
    operations: [lecture, écriture]
    etats_ui:
      - offre et bouton visibles à partir de 1 h
      - 'soutenu : « Merci pour ton soutien. »'
      - 'paiement échoué : « Le paiement n’a pas abouti. Tu n’as pas été débité. » avec « Réessayer » (P-03 et P-22)'
      - 'paiement annulé : « Paiement annulé. Tu n’as pas été débité. » et de nouveau « Soutenir le projet » (P-22 ; même état sur F-015.a par analogie, D-036)'
    questions_ouvertes:
      - Paiement via l'App Store ou Google Play
      - 'Règle : offre visible à partir de 1 h d''utilisation ; masquée si le compte a déjà soutenu (E-16)'
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
    questions_ouvertes:
      - 'Accès supposé : sur tout post qu''on peut voir (audience du post, F-050)'

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
    questions_ouvertes:
      - 'Accès supposé : sur tout post qu''on peut voir (audience du post, F-050)'

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
    questions_ouvertes:
      - 'Accès supposé : sur tout post qu''on peut voir (audience du post, F-050)'

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
      - 'Accès supposé : sur tout post qu''on peut voir (audience du post, F-050) ; peut-on partager un post « Amis proches » ?'
      - 'Envoyer à un ami (F-019.a) : amis seulement (ami ou non, E-09)'
      - Un lien de post ouvert sans connexion mène à la connexion (P-01)
      - 'Aspect du post reçu dans la conversation de l''ami (F-019.a, D-044) : non dessiné sur P-09'

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
    questions_ouvertes:
      - 'Accès supposé : visible sur tout post qu''on peut voir (audience du post, F-050)'

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
    operations: [lecture]
    etats_ui:
      - pastille avec nombre
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
    description: Toute l'interface perd 10 % de couleur par cycle, noir et blanc après 10 cycles, sans message. Seul le temps passé dans l'appli ouverte compte (D-075).
    pages: [P-03, P-04, P-05, P-06, P-07, P-08, P-09, P-10, P-11, P-12, P-13, P-14, P-15, P-16, P-17, P-18, P-19, P-20, P-21, P-22, P-23, P-24, P-25, P-26, P-28]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-14]
    operations: [lecture, écriture]
    etats_ui:
      - de 0 à 100 % de gris
    questions_ouvertes:
      - 'Deux téléphones ouverts en même temps sur le même compte : le temps compte-t-il deux fois ?'

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
    description: Champ « Ajouter un commentaire… » et bouton « Publier ».
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
    questions_ouvertes:
      - 'Accès supposé : sur tout post qu''on peut voir (audience du post, F-050)'

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
    description: Story plein écran, 2 ou 3 images de 5 s, tap à droite ou à gauche, croix pour fermer.
    pages: [P-08, P-09, P-10, P-10.a, P-10.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-12]
    operations: [lecture, écriture]
    etats_ui:
      - cercle vert non vue
      - cercle gris vue
      - barres de progression
      - 'chargement : anneau blanc centré'
      - 'erreur : « La story n’a pas pu être chargée. » avec « Réessayer »'
    questions_ouvertes:
      - Le statut « vue » n'est pas partagé entre écrans dans la maquette
      - 'Accès supposé : stories des amis seulement (ami ou non, E-09)'
```

```yaml
  - id: F-037
    nom: Consulter ses discussions
    description: Liste des discussions avec dernier message et heure ; tap pour ouvrir.
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
    questions_ouvertes:
      - 'Accès supposé : conversations entre amis seulement (ami ou non, E-09) ; peut-on écrire à un non-ami ?'

  - id: F-038
    nom: Lire une conversation
    description: Bulles vertes à droite, grises à gauche, photos et saisie du contact.
    pages: [P-09, P-09.a, P-09.b, P-09.d]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-11, E-10]
    operations: [lecture]
    etats_ui:
      - contact en train d'écrire
      - 'chargement : anneau centré'
      - 'vide : « Aucun message » · « Écris le premier message à Léa. »'
      - 'erreur : « Les messages n’ont pas pu être chargés. » avec « Réessayer »'
    questions_ouvertes:
      - Réponses automatiques de démo
      - 'Accès supposé : conversations entre amis seulement (ami ou non, E-09)'

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
      - 'Accès supposé : amis seulement (ami ou non, E-09)'

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
    questions_ouvertes:
      - 'Accès supposé : conversations entre amis seulement (ami ou non, E-09)'

  - id: F-041
    nom: Envoyer un message
    description: Champ « Message… » et « Envoyer » dans la bulle.
    pages: [P-09, P-09.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-11]
    operations: [écriture]
    etats_ui:
      - texte tapé visible moins d'1 s puis charabia
      - 'échec : le message reste affiché, marqué « Non envoyé. » avec « Réessayer » (D-030)'
    questions_ouvertes:
      - 'Accès supposé : conversations entre amis seulement (ami ou non, E-09) ; peut-on écrire à un non-ami ?'

  - id: F-042
    nom: Envoyer une photo dans une conversation
    description: Icône image à droite dans la bulle de saisie.
    pages: [P-09, P-09.e]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-11, E-04]
    operations: [écriture]
    etats_ui:
      - visible quand le champ est vide
      - 'échec : la photo cerclée de rouge, « Non envoyée. » avec « Réessayer »'
    questions_ouvertes:
      - Choix de la photo (la maquette envoie une image de démo)
      - 'Accès supposé : conversations entre amis seulement (ami ou non, E-09)'

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
    description: Aperçu carré, grille de photos, sélection multiple jusqu'à 10, « Suivant », pour un post ou une story (D-068).
    pages: [P-12, P-12.a, P-12.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-04, E-03, E-12]
    operations: [lecture, écriture]
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
    description: 'Bouton appareil photo au-dessus de la grille : la photo prise devient la photo du post ou de la story (D-068).'
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
    description: Champ « Écris une légende… » à côté de la miniature, pour un post ou une story (D-068).
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
    questions_ouvertes:
      - 'Règle : l''audience choisie décide qui peut voir le post et agir dessus'

  - id: F-051
    nom: Publier le post
    description: Bouton vert « Partager dans le fil » (ouvre l'Accueil) ou « Partager en story » (ouvre Messages).
    pages: [P-13, P-03.d, P-08.b, P-13.a, P-13.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03, E-04, E-12, E-08]
    operations: [lecture, écriture]
    etats_ui:
      - libellé selon la destination choisie
      - 'envoi : anneau et « Publication… » dans le bouton'
      - 'erreur : « Le post n’a pas été publié. Tes photos et ta légende sont gardées. » avec « Réessayer »'
      - 'succès fil : l''Accueil affiche le toast « Post publié. » (D-031)'
      - 'succès story : Messages affiche le toast « Story publiée. » (D-031)'
    questions_ouvertes:
      - Envoi, flou et charabia côté amis
      - 'Palette et durée de vie du post (E-03) : qui les fixe à la publication, et combien de jours ?'

  - id: F-052
    nom: Rechercher des posts
    description: Toute saisie donne 18 posts dans l'une des 5 palettes (somme des codes modulo 5).
    pages: [P-14, P-15, P-15.a, P-15.b, P-15.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-13, E-03]
    operations: [lecture]
    etats_ui:
      - 'champ vide : suggestions'
      - 'champ rempli : résultats'
      - 'chargement : anneau centré (P-15)'
      - 'aucun résultat : « Aucun résultat » · « Aucun post ne correspond à « … ». Essaie un autre mot. »'
      - 'erreur : « La recherche n’a pas abouti. » avec « Réessayer » (P-15)'
    questions_ouvertes:
      - 'Accès supposé : les résultats incluent des posts de non-amis s''ils sont publics (audience du post, F-050)'
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
    entites: [E-13]
    operations: [lecture]
    etats_ui:
      - 'chargement : anneau centré'
      - 'erreur : « Les suggestions n’ont pas pu être chargées. » avec « Réessayer » ; le champ reste utilisable'
    questions_ouvertes:
      - Origine des suggestions et des tendances

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
    questions_ouvertes:
      - 'Accès supposé : ouvrir un post dépend de son audience (F-050)'

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
    description: Lien « Modifier » puis page avec pseudo (16 max) et description (80 max).
    pages: [P-17, P-19, P-19.a, P-19.b]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-01]
    operations: [lecture, écriture]
    etats_ui:
      - prérempli
      - compteurs 0/16 et 0/80
      - texte tapé visible moins d'1 s puis charabia
      - 'enregistrement : anneau, champs gardés'
      - 'erreur : « Tes modifications n’ont pas été enregistrées. Vérifie ta connexion et réessaie. » avec « Réessayer »'
    questions_ouvertes:
      - 'Pseudo vide : l''ancien est gardé'

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
      - nette environ 1 s
      - floutée
      - 'erreur de fichier : « Cette image n’a pas pu être utilisée. Choisis-en une autre. » (P-18)'
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
    questions_ouvertes: []

  - id: F-061
    nom: Réinitialiser les cycles
    description: Bouton « Réinitialiser » qui rend les couleurs partout.
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
    description: Grille de 9 posts floutés avec jours restants.
    pages: [P-17, P-17.a, P-17.b, P-17.c]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-03]
    operations: [lecture]
    etats_ui:
      - non cliquables
      - 'vide : « Aucun post pour l’instant » · « Tes posts s’affichent ici, avec leurs jours restants. » avec « Créer un post » (F-026, D-035)'
      - 'chargement : anneau centré'
      - 'erreur : « Tes posts n’ont pas pu être chargés. » avec « Réessayer »'
    questions_ouvertes:
      - Ouvrir un de ses posts

  - id: F-063
    nom: Supprimer son compte
    description: Bouton rouge puis confirmation « Supprimer définitivement » ou « Annuler ».
    pages: [P-21, P-21.a]
    plateformes: [mobile]
    acces: [R-02]
    variantes: []
    entites: [E-01, E-02]
    operations: [suppression]
    etats_ui:
      - confirmation
      - 'compte supprimé : « Compte supprimé » et « Merci d’être passé·e. » 2 s, puis P-01 s''ouvre (D-069)'
      - 'échec : « Ton compte n’a pas pu être supprimé. Rien n’a été effacé. » avec « Réessayer »'
    questions_ouvertes:
      - 'Effacement réel des données (la fermeture de la session est réglée par D-053)'

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
    questions_ouvertes:
      - Temps compté par compte ou par appareil ?

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
      - Thème lié au compte ou à l'appareil ?

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
    questions_ouvertes:
      - Réglage lié au compte ou à l'appareil ?

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
    description: 'À la première connexion, choix du pseudo et de l''identifiant (@), puis ouverture de l''Accueil (D-052). Seulement ces deux champs : photo et description plus tard sur P-19 (D-063).'
    pages: [P-27, P-27.a, P-27.b]
    plateformes: [mobile]
    acces: [R-01]
    variantes: []
    entites: [E-02, E-01]
    operations: [lecture, écriture]
    etats_ui:
      - « Créer mon compte » gris tant qu'un champ est vide
      - 'envoi : champs grisés, anneau et « Création du compte… » dans le bouton (D-064)'
      - 'erreur : « Ton compte n’a pas été créé. Vérifie ta connexion et réessaie. » avec « Réessayer », saisies gardées (D-064)'
    questions_ouvertes:
      - 'Règles de l''identifiant : longueur, caractères permis, unicité, message s''il est déjà pris'

  - id: F-071
    nom: Se déconnecter
    description: Bouton « Se déconnecter » sur Mon compte, qui ferme la session de l'appareil et ramène à la Connexion (D-053).
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
      - Un changement de la liste vaut-il pour les posts et stories déjà publiés en « Amis proches » ?
```

```yaml
entites:

  - id: E-01
    nom: Compte utilisateur
    champs:
      - pseudo
      - identifiant (@)
      - description
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
      - session ouverte sur l'appareil (D-053)
    utilisee_par: [F-001, F-003, F-006, F-007, F-008, F-063, F-070, F-071]

  - id: E-03
    nom: Post
    champs:
      - auteur (pseudo, photo)
      - type (photo, vidéo, carrousel, pause, inspire-expire, premium)
      - légende
      - nombre de likes
      - nombre de commentaires
      - nombre d'enregistrements
      - nombre de partages
      - audience
      - jours restants avant expiration
      - palette
      - lien
      - personnes identifiées
      - lieu
    utilisee_par: [F-009, F-010, F-011, F-012, F-014, F-016, F-017, F-018, F-019, F-020, F-021, F-030, F-044, F-046, F-047, F-048, F-049, F-050, F-051, F-052, F-054, F-062, F-068]

  - id: E-04
    nom: Média
    champs:
      - image
      - durée de la vidéo
      - rang dans le carrousel
      - version floutée
    utilisee_par: [F-010, F-011, F-012, F-042, F-044, F-045, F-046, F-051, F-058]

  - id: E-05
    nom: Commentaire
    champs:
      - auteur
      - texte
      - ancienneté
      - nombre de likes
    utilisee_par: [F-016, F-017, F-022, F-030]

  - id: E-06
    nom: Like
    champs:
      - cible (post ou commentaire)
      - auteur
      - date
    utilisee_par: [F-016, F-022]

  - id: E-07
    nom: Collection
    champs:
      - nom
      - posts enregistrés
    utilisee_par: [F-018, F-031]

  - id: E-08
    nom: Notification
    champs:
      - type (like, commentaire, invitation, identification)
      - auteur
      - ancienneté
      - post concerné (miniature)
    utilisee_par: [F-016, F-022, F-028, F-030, F-034, F-051]

  - id: E-09
    nom: Relation d'amitié
    champs:
      - compte (pseudo, identifiant, photo)
      - statut (en attente, demandé, ami)
      - ami proche (oui/non, D-060)
    utilisee_par: [F-022, F-028, F-034, F-043, F-048, F-072]

  - id: E-10
    nom: Conversation
    champs:
      - contact (pseudo, identifiant, photo)
      - dernier message
      - heure
      - lu / non lu
    utilisee_par: [F-019, F-028, F-033, F-034, F-037, F-038, F-039]

  - id: E-11
    nom: Message
    champs: [expéditeur, texte, photo, message cité, post partagé, date]
    utilisee_par: [F-019, F-038, F-040, F-041, F-042]

  - id: E-12
    nom: Story
    champs:
      - auteur
      - images
      - texte
      - ancienneté
      - vue / non vue
      - audience (D-059)
      - personnes identifiées
      - lieu
    utilisee_par: [F-036, F-044, F-046, F-047, F-048, F-049, F-050, F-051, F-068]

  - id: E-13
    nom: Recherche
    champs:
      - texte saisi
      - palette obtenue
      - suggestions
      - tendances (rang, nombre de posts)
    utilisee_par: [F-052, F-053]

  - id: E-14
    nom: Minuteur de couleur
    champs:
      - compte (D-074)
      - durée du cycle
      - temps passé appli ouverte dans le cycle en cours (D-075)
      - cycles écoulés
      - pourcentage de gris
      - temps restant
    utilisee_par: [F-024, F-059, F-060, F-061]

  - id: E-15
    nom: Temps d'utilisation
    champs:
      - durée cumulée
    utilisee_par: [F-015, F-065]

  - id: E-16
    nom: Soutien
    champs:
      - prix (1,99 €)
      - statut (non soutenu, soutenu)
    utilisee_par: [F-015]

  - id: E-17
    nom: Préférences d'interface
    champs:
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
| F-002 | Icône de l'appli sur P-01, P-22, P-23 : même donnée (thème), simple affichage ; taille et contexte en variantes. Le changement en direct relève de F-066. |
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
