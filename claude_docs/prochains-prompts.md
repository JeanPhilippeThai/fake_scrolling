# Prochains prompts – Fake scrolling

Six séries de prompts sur « Fake scrolling — registre canonique » : les cinq des autres onglets, plus un passage par le design pour les états non dessinés. C'est le plus petit des trois registres, donc le bon candidat pour dérouler toute la suite en premier.

## 1. Rôles, accès et format

La décision suivante est D-024.

```text
Lis « Fake scrolling — registre canonique » : https://claude.ai/artifact/W2ibtgK7oF536LDXh5AAAV
Mets son YAML au format actuel du prompt 2, sans renuméroter aucun ID et sans changer le contenu des features.

1. Ajoute en tête du YAML la section `roles` :

roles:
  - id: R-01
    nom:            # type d'utilisateur
    portee:         # compte

2. Ajoute `acces: [R-xx]` à chaque feature. Une variante n'a son propre `acces` que s'il diffère de celui de sa feature.

3. Aligne les clés :
- Pages : ajoute `plateforme: mobile`.
- Features : ajoute `plateformes: [mobile]` ; chaque variante porte `plateforme` et `pages`.
- Entités : `champs_visibles` devient `champs`.
- Décisions : `decision` devient `choix` ; ajoute `raison` ; garde `impacte`.

Règles d'accès :
- Liste dans `roles` chaque type d'utilisateur visible dans le design (droits, badges, écrans réservés).
- Rôles probables, à confirmer dans le design : personne non connectée (P-01, P-02), utilisateur connecté.
- `acces` = les rôles qui peuvent utiliser la feature.
- Si le design ne montre pas qui a accès, mets ton hypothèse et ajoute une question ouverte.
- Une condition plus fine que le rôle va dans `questions_ouvertes` : elle deviendra une règle dans la spec de la feature. Exemples : audience d'un post (F-050), offre de soutien visible après 1 h (F-015), compte déjà « soutenu » (E-16), ami ou non (E-09).

Avant de modifier le registre, montre-moi :
1. La liste des rôles, avec l'écran qui justifie chacun.
2. Les features dont l'accès est une hypothèse.
3. Les cas ambigus à trancher, avec les options possibles.

Une fois validé, applique au YAML et ajoute la décision D-024. Mets aussi la page à jour : une section Rôles, l'accès sur chaque fiche de feature, les compteurs.
```

Ensuite, trois prompts de la méthode, recopiés ici. Lancez-les dans la même conversation, l'un après l'autre.

**Prompt 3 : vérifier**

```text
Lis « Fake scrolling — registre canonique » : https://claude.ai/artifact/W2ibtgK7oF536LDXh5AAAV
Vérifie la cohérence du registre, sans rien corriger :
- Toute feature listée dans une page doit lister cette page, et inversement.
- Aucune feature sans page, aucune entité sans feature.
- Aucun doublon de nom ou de comportement entre deux features distinctes.
- Aucune variante sans feature parente.
- Aucune feature sans rôle dans `acces`, aucun rôle sans feature, aucun rôle cité qui n'existe pas dans `roles`.

Liste les incohérences trouvées. Je te dirai lesquelles corriger.
```

**Prompt 8 : trier les constats** (juste après la réponse au prompt 3)

```text
Classe chaque incohérence dans une de ces 3 catégories :
A. Erreur du registre → corrige-la directement.
B. Comportement non défini par le design → pose-moi la question avec 2-3 options.
C. Incohérence réelle du design → propose le comportement cible, et une fois validé, ajoute `design_a_mettre_a_jour: true` sur les features concernées.

Applique tout de suite les A. Pour les B et C, attends mes réponses, puis enregistre chaque choix dans `decisions`.
```

**Prompt 4 : appliquer vos décisions** (quand vous avez tranché ; remplacez `[tes choix]`)

```text
Voici mes décisions sur les cas ambigus : [tes choix].
Applique-les au registre, puis renvoie le YAML complet mis à jour.
Ajoute chaque décision dans la section `decisions` avec : id (D-01…), sujet, choix, raison.
```

## 2. États non dessinés

Le registre porte 51 questions ouvertes sur 36 features, dont beaucoup signalent un état que le design ne montre pas. L'étape 1 de la méthode demande les états vide, chargement et erreur : autant les dessiner avant d'écrire les flows.

```text
Lis « Fake scrolling — registre canonique » : https://claude.ai/artifact/W2ibtgK7oF536LDXh5AAAV
1. Liste les questions ouvertes qui portent sur un état non dessiné (chargement, erreur, vide, échec d'envoi ou de paiement), groupées par page, avec leur feature. Laisse les autres questions de côté.
2. Je choisis les états à dessiner maintenant ; les autres restent en question ouverte jusqu'à la spec de leur feature.
3. Dessine les états choisis dans le design « Fake scrolling — app » : https://claude.ai/artifact/9fxJvdH8dPEDrrLKNWerJT, sans toucher aux autres écrans.
```

Ensuite, le prompt 9 de la méthode, recopié ici, dans la même conversation.

**Prompt 9 : comparer le design mis à jour au registre**

```text
Voici le design mis à jour. Compare-le au registre actuel, sans renuméroter les IDs :
- Features dont le design correspond maintenant au registre → retire `design_a_mettre_a_jour`.
- Différences restantes entre le design et le registre.
- Nouveaux éléments du design absents du registre → propose de nouveaux IDs à la suite des existants.
```

## 3. Flows

Le prompt 5, rempli pour le premier flow. Relancez-le une fois par ligne du tableau ; la liste est ma proposition d'après les pages et les features du registre, à ajuster.

```text
Lis « Fake scrolling — registre canonique » : https://claude.ai/artifact/W2ibtgK7oF536LDXh5AAAV
En te basant UNIQUEMENT sur les IDs du registre, décris le flow FL-01 « Se connecter avec un compte tiers ou un code e-mail » :
- Séquence : P-xx → F-xxx → P-xx…
- Entités lues et écrites à chaque étape.
- Points de décision et cas d'erreur.
- Features ou pages manquantes dans le registre pour que ce flow fonctionne.
Écris-le dans le doc « Flows – Fake scrolling » (crée-le s'il n'existe pas), une section par flow.
Ne modifie pas le registre : liste ce qui manque, j'arbitre.
```

Pour un job de fond, remplacez la ligne « Séquence » par : `- Déclencheur (minuteur, date ou événement), puis ce que le job fait et les features qui en montrent l'effet.`

| ID | Flow ou job de fond | Type | Repères dans le registre |
| --- | --- | --- | --- |
| FL-01 | Se connecter avec un compte tiers ou un code e-mail | Flow | P-01, P-02, F-001, F-003, F-007, F-008 |
| FL-02 | Publier un post dans le fil ou en story | Flow | P-12, P-13, P-24 à P-26, F-044 à F-051, F-068 |
| FL-03 | Réagir à un post : liker, commenter, enregistrer, partager | Flow | P-03, P-05 à P-07, F-016 à F-019, F-030, F-031 |
| FL-04 | Ajouter un ami, puis accepter ou refuser l'invitation | Flow | P-08, P-11, P-04, F-034, F-043, F-028 |
| FL-05 | Discuter avec un ami et voir sa story | Flow | P-08 à P-10, F-036 à F-042 |
| FL-06 | Rechercher des posts et ouvrir un résultat | Flow | P-14 à P-16, F-052 à F-054 |
| FL-07 | Soutenir le projet après 1 h d'utilisation | Flow | P-03, P-22, F-015, F-065 |
| FL-08 | Modifier son profil et sa photo | Flow | P-17 à P-19, F-056, F-058 |
| FL-09 | Régler le minuteur, l'icône et les carrousels de pause | Flow | P-17, P-23, F-060, F-061, F-066, F-067 |
| FL-10 | Supprimer son compte | Flow | P-20, P-21, F-063 |
| FL-11 | Griser l'app cycle après cycle | Job | F-024, F-059, E-14 |
| FL-12 | Compter le temps d'utilisation et ouvrir l'offre de soutien | Job | F-015, F-065, E-15 |
| FL-13 | Composer le fil : posts de pause, Inspire / Expire, offre de soutien | Job | F-009, F-012.a, F-014, F-015.a |
| FL-14 | Faire expirer les posts | Job | F-062, E-03 |
| FL-15 | Flouter les photos et brouiller les textes après l'envoi | Job | F-030, F-041, F-051, F-058 |
| FL-16 | Faire expirer le code de connexion et autoriser le renvoi | Job | F-007, F-008, E-02 |

## 4. États

Nouveau prompt, pour l'étape 6. Il se lance une fois les flows écrits.

```text
Lis « Fake scrolling — registre canonique » et le doc « Flows – Fake scrolling ».

1. Liste les entités dont le registre ou les flows montrent des états (statut, expiration, compteur). Candidates : Relation d'amitié (E-09 : en attente, demandé, ami, refusé), Minuteur de couleur (E-14 : cycles écoulés, réinitialisation), Connexion (E-02 : code envoyé, vérifié, expiré), Soutien (E-16 : non soutenu, soutenu), Post (E-03 : publié, expiré), Story (E-12 : non vue, vue). Je valide la liste.

2. Pour chaque entité validée, une à la fois, écris SM-E-xx :
- États possibles.
- Transitions autorisées : départ → arrivée, déclencheur (F-xxx, FL-xx ou job de fond), condition.
- Règles qui doivent toujours rester vraies, numérotées BR-<feature>-<n>.
- États ou transitions que le design ne montre pas : questions à trancher.

3. Je choisis les règles à vérifier. Écris alors le modèle TLA+ SM_E_xx, chaque règle vérifiée nommée d'après sa règle métier (BR_xxx_n pour BR-xxx-n).

4. Dis-moi si un modèle de synchronisation est nécessaire : le minuteur de couleur (E-14) et le temps d'utilisation (E-15) sont-ils propres à un appareil ou partagés par le compte ?

N'ajoute aucune règle et ne change pas le registre sans mon accord.
```

## 5. Exigences non fonctionnelles

Nouveau prompt, pour l'étape 7.

```text
À partir de « Fake scrolling — registre canonique » et du doc « Flows – Fake scrolling », propose les exigences non fonctionnelles de toute l'app (NFR-X-1, NFR-X-2…) : confidentialité, rapidité, sécurité, accessibilité.
- Chaque exigence a un chiffre ou un test (« moins de 300 ms au p95 »), jamais un adjectif.
- Cite les features et les entités concernées.
- Inclus : un nom accessible sur chaque bouton, champ et lien.
- N'ajoute une exigence propre à une feature (NFR-<feature>-<n>) que si elle est spécifique.
- Points à couvrir : fluidité du défilement du fil (F-009), lisibilité de l'app grisée (F-024), animations figées quand l'appareil les réduit (F-014), paiement du soutien (F-015), suppression réelle du compte (F-063).
Liste à part les exigences dont le chiffre est une hypothèse. Je valide, puis tu les écris dans le doc « Règles transverses – Fake scrolling ».
```

## 6. System design

Le prompt 6, rempli pour la première question. Relancez-le pour chacune des questions de la liste, une à la fois.

```text
À partir de « Fake scrolling — registre canonique » et des flows FL-01 à FL-16, dis ce qui doit être réel et ce qui reste généré : posts, comptes de l'annuaire, résultats de recherche, réponses des contacts, envoi du code par e-mail.
Cite toujours les IDs concernés.
Si tu proposes un changement au registre, liste-le séparément et n'applique rien sans mon accord.
Une fois validé, ajoute la décision dans `decisions`.
```

Questions suivantes, à mettre à la place de la première phrase :

1. « propose la stack : une app iOS et Android, et un serveur si la première réponse en demande un. »
2. « le minuteur de couleur et le temps d'utilisation vivent-ils sur l'appareil ou sur le compte (E-14, E-15) ? »
3. « comment encaisser le soutien à 1,99 € par l'App Store et Google Play (F-015, E-16) ? »
4. « peut-on changer l'icône de l'app sur le téléphone, sur iOS et sur Android (F-066) ? »

Ensuite, les prompts 11 et 12 de la méthode, recopiés ici, dans cet ordre.

**Prompt 11 : modèle de données**

````text
Lis « Fake scrolling — registre canonique » et le doc « Flows – Fake scrolling ».
À partir du registre (entités E-xx) et des flows FL-xx, propose le modèle de données dans docs/system-design/data-model.yaml, avec exactement cette structure :

```yaml
tables:
  - id: TB-01
    nom:
    type: table            # table (SQL) | collection (NoSQL)
    stockage: N-xx         # nœud de stockage, déclaré dans data-flows.yaml
    entite: E-xx           # ou "aucune" + raison (table de liaison, table technique)
    raison:
    colonnes:
      - nom:
        type:              # type exact du moteur : uuid, text, numeric(12,2), timestamptz…
        cle:               # primaire | unique | vide
        reference:         # TB-xx.colonne si clé étrangère
        obligatoire: true
    index: []
```

Règles :
- Déclare d'abord chaque stockage comme nœud dans docs/system-design/data-flows.yaml : id N-xx, type: stockage, nom, modele: SQL | NoSQL | fichiers. Le prompt 12 complétera ce fichier.
- Le moteur de chaque stockage est une décision : propose-le avec sa raison, je valide, puis ajoute-le dans `decisions`.
- Chaque entité E-xx du registre est stockée dans au moins une table, et chaque table cite l'entité qu'elle stocke.
- Chaque champ d'une entité correspond à une colonne, ou tu expliques pourquoi il est calculé.
- Pour une collection NoSQL, `colonnes` liste les champs du document ; un champ imbriqué s'écrit parent.enfant.
- Les IDs TB-xx et N-xx sont définitifs : ne jamais renuméroter.

Après le YAML, liste : les champs d'entité sans colonne, les colonnes sans champ d'entité, et les questions à trancher.
````

**Prompt 12 : flux de données**

````text
À partir du registre (rôles R-xx, features F-xxx, entités E-xx), des flows FL-xx et du modèle de données, complète docs/system-design/data-flows.yaml :

```yaml
noeuds:
  - id: N-01
    type: acteur           # acteur | infra | stockage | tiers
    nom:
    role: R-xx             # acteur seulement
    modele:                # stockage seulement : SQL | NoSQL | fichiers

flux:
  - id: DF-01
    de: N-xx
    vers: N-xx
    donnees: [E-xx]
    features: [F-xxx]
    flows: []              # FL-xx, pour un job de fond sans feature
    protocole:
    sensible: false        # true : données personnelles, identifiants, paiement
```

Règles :
- Un nœud acteur par rôle R-xx. Un nœud par élément d'infra : chaque app (desktop, iOS, Android), le serveur, chaque stockage, chaque service tiers.
- Un flux = un transfert de données dans un seul sens. Un aller-retour = deux flux.
- Chaque flux cite les entités transportées et les features qui le déclenchent ; un job de fond cite son flow FL-xx.
- Un flux qui part d'un acteur ne cite que des features auxquelles son rôle a accès (`acces` du registre).
- Un acteur ne parle jamais directement au serveur ou à un stockage : il passe par une app.
- Les IDs N-xx et DF-xx sont définitifs : ne jamais renuméroter.

Après le YAML :
1. Dessine le graphe à partir du YAML : nœuds = N-xx, arêtes = DF-xx.
2. Liste les features qui lisent ou écrivent des données mais n'apparaissent dans aucun flux, et les stockages qu'aucun flux n'atteint.
3. Liste les flux `sensible: true`, pour le threat model.
````

Le threat model part des flux que le prompt 12 marque `sensible: true`.
