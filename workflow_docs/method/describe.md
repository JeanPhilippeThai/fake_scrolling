# Describe the app

Part of [the method](../method.md). Snapshot of the "Describe" tab of the Claude Doc ["Building apps with Claude: the method"](https://claude.ai/artifact/CNNN4eUxaLSfQh2ohtNAP4), revision 21, taken on 2026-11-19.

Steps 1 to 8 of the pipeline, wide and shallow: from the Claude Design mock-up to a checked registry, flows, entity states and a system design. Read this part before starting an app, and whenever the registry, a flow or a design decision changes. How the code is laid out is in [Code structure](code-structure.md); how the design is checked is in [Verification](verification.md).

## The design cycle

The repo holds the official design, the one the method has checked. Claude Design on claude.ai is where the next version is drawn. The two go back and forth, one round at a time:

1. **Draw** the next version on claude.ai.
2. **Import** it into the repo (`import-design-and-docs-artifact`), **compare** it with the current version (`compare-newest-current-claude-files`) and **promote** it (`promote-newest-claude-files`).
3. **Check** it with the method: the doc tests list the missing screens, states and edge cases.
4. **Fix** it in the repo: Claude draws what is missing in `claude_design/`. The repo is now ahead of claude.ai.
5. **Publish** the repo's design back to claude.ai (`publish-claude-design`) before drawing there again.

Each import records what claude.ai held, file by file. Promotion refuses to replace a repo change that was never published, and publishing refuses to overwrite what was drawn on claude.ai since the last import: when both sides changed, they are merged by hand. Docs are not part of this cycle: a doc is always edited in its Claude Doc first, then imported.

The owner may remove or change on claude.ai what the repo drew in the last round, or remove an ID from a doc. The comparison lists each of these, and the owner says whether it was on purpose. On purpose: a decision in the registry says what is not wanted and why (and ids_retires lists a removed ID with it), so that the doc tests stop asking for it at every round. By mistake: it is restored on claude.ai before promoting. An ID removed without being retired fails check G-03.

## The prompts

These prompts take a Claude Design mock-up to a checked registry, then to flows and a system design. They are kept in French, word for word as used; prompt 2's format was aligned on 16 November 2026 with the multi-platform registry format (platforms, variant pages, entity fields), and roles and access were added on 17 November, along with web as a platform. Prompts 1 to 6 are the main line, and prompts 5 and 6 are reused for every flow and every question. Prompts 8 to 10, after them, cover cases met in practice, prompts 11 and 12 write the data model and the data-flow graph in step 8, and prompts 13 and 14 then write a contract for every page and check it against them. Prompt 7, for changes after code exists, is in [Build the app](build.md).

**Prompt 1: raw extraction**

```text
Pour chaque écran de ce design, attribue un ID P-01, P-02… et liste tout ce que l'utilisateur peut voir ou faire sur cet écran.

Règles :
- Ne regroupe RIEN entre les pages à cette étape, même si deux éléments se ressemblent.
- Pour chaque élément : nom (verbe + objet, ex. "Ajouter au panier"), description en une ligne, données affichées ou modifiées, états visibles (vide, chargement, erreur…).
- Marque "à confirmer" tout ce que tu déduis au lieu de le voir dans le design.

Format : une section par page, titre "P-xx Nom de la page", puis la liste.
```

**Prompt 2: consolidated registry**

````text
À partir de cette extraction, construis le registre canonique en YAML avec exactement cette structure :

```yaml
roles:
  - id: R-01
    nom:            # type d'utilisateur, ex. Admin, Observateur
    portee:         # compte | projet | autre périmètre visible dans le design

pages:
  - id: P-01            # P-Wxx / P-Dxx / P-Mxx une fois les plateformes fusionnées (prompt 10)
    plateforme: mobile
    nom:
    features: [F-001, F-002.a]

features:
  - id: F-001
    nom:            # verbe + objet
    description:
    plateformes: [mobile]
    pages: [P-01, P-03]
    acces: [R-01, R-02]
    variantes:
      - id: F-001.a
        plateforme: mobile
        pages: [P-03]
        difference:
        acces: [R-01]   # seulement s'il diffère de celui de la feature
    entites: [E-01]
    operations: [lecture, écriture]
    etats_ui: []
    questions_ouvertes: []

entites:
  - id: E-01
    nom:
    champs: []
    utilisee_par: [F-001]

decisions: []
```

Règles de regroupement :
- Même intention + mêmes données + même comportement = une seule feature F-xxx.
- Même intention mais comportement ou données différents = variante F-xxx.a, F-xxx.b.
- Les liens vont dans les deux sens : une page liste ses features ET chaque feature liste ses pages.
- Les IDs sont définitifs : ne jamais renuméroter. Un ID retiré va dans une section `ids_retires` à la fin du YAML, avec la décision qui le retire (`- {id: F-009.a, decision: D-07}`) : il n'est jamais réutilisé.
- `plateforme` et `plateformes` indiquent la plateforme de ce design : web, desktop ou mobile (iOS et Android partagent le design mobile). Un design par plateforme = un registre par plateforme, fusionnés ensuite avec le prompt 10.

Règles d'accès :
- Liste dans `roles` chaque type d'utilisateur visible dans le design (droits, badges, écrans réservés).
- `acces` = les rôles qui peuvent utiliser la feature. Une variante n'a son propre `acces` que s'il diffère.
- Si le design ne montre pas qui a accès, mets ton hypothèse et ajoute une question ouverte.
- Une condition plus fine que le rôle (ex. "seulement ses propres dépenses") va dans `questions_ouvertes` : elle deviendra une règle dans la spec de la feature.

Après le YAML, ajoute deux sections :
1. "Regroupements effectués" : chaque fusion avec sa justification en une ligne.
2. "Cas ambigus à trancher" : chaque hésitation, avec les options possibles.
````

**Prompt 3: check**

```text
Vérifie la cohérence du registre, sans rien corriger :
- Toute feature listée dans une page doit lister cette page, et inversement.
- Aucune feature sans page, aucune entité sans feature.
- Aucun doublon de nom ou de comportement entre deux features distinctes.
- Aucune variante sans feature parente.
- Aucune feature sans rôle dans `acces`, aucun rôle sans feature, aucun rôle cité qui n'existe pas dans `roles`.

Liste les incohérences trouvées. Je te dirai lesquelles corriger.
```

**Prompt 4: apply your decisions** (once the ambiguous cases are settled)

```text
Voici mes décisions sur les cas ambigus : [tes choix].
Applique-les au registre, puis renvoie le YAML complet mis à jour.
Ajoute chaque décision dans la section `decisions` avec : id (D-xx), sujet, choix, raison.
```

**Prompt 5: flows** (reuse for each flow)

```text
En te basant UNIQUEMENT sur les IDs du registre, décris le flow FL-01 "[nom du flow]" :
- Séquence : P-xx → F-xxx → P-xx…
- Entités lues et écrites à chaque étape.
- Points de décision et cas d'erreur.
- Features ou pages manquantes dans le registre pour que ce flow fonctionne.
```

**Prompt 6: system design** (reuse for each question)

```text
À partir du registre et des flows FL-xx, [ta question : ex. "propose le découpage en API", "qu'est-ce qui doit être côté serveur vs client", "quel modèle de données pour E-xx"].
Cite toujours les IDs concernés.
Si tu proposes un changement au registre, liste-le séparément et n'applique rien sans mon accord.
Une fois validé, ajoute la décision dans `decisions`.
```

## Prompts for special cases

Three prompts for situations the main line does not cover. The same rules hold: IDs are never renumbered, and every choice ends up in `decisions`.

**Prompt 8: sort the check's findings** (right after prompt 3)

```text
Classe chaque incohérence dans une de ces 3 catégories :
A. Erreur du registre → corrige-la directement.
B. Comportement non défini par le design → pose-moi la question avec 2-3 options.
C. Incohérence réelle du design → propose le comportement cible, et une fois validé, ajoute `design_a_mettre_a_jour: true` sur les features concernées.

Applique tout de suite les A. Pour les B et C, attends mes réponses, puis enregistre chaque choix dans `decisions`.
```

**Prompt 9: design changed after the extraction** (before any code exists; once it does, use prompt 7)

```text
Voici le design mis à jour. Compare-le au registre actuel, sans renuméroter les IDs :
- Features dont le design correspond maintenant au registre → retire `design_a_mettre_a_jour`.
- Différences restantes entre le design et le registre.
- Nouveaux éléments du design absents du registre → propose de nouveaux IDs à la suite des existants.
```

**Prompt 10: merge per-platform registries** (one design per platform; then run prompts 3 and 8 on the merged registry, and archive the old ones)

````text
Fusionne les registres [Desktop] et [Mobile] de [nom de l'app] en un seul registre canonique, en YAML :

```yaml
roles:
  - id: R-01
    nom:
    portee:
    alias: {desktop: R-02, mobile: R-01}

pages:
  - id: P-D01          # P-Wxx web, P-Dxx desktop, P-Mxx mobile
    plateforme: desktop
    nom:
    alias: P-01        # ancien ID
    features: [F-001]

features:
  - id: F-001
    nom:
    description:
    plateformes: [desktop, mobile]
    pages: [P-D01, P-M01]
    alias: {desktop: F-004, mobile: F-012}
    acces: [R-01]
    variantes:
      - id: F-001.a
        plateforme: mobile
        pages: [P-M01]
        difference:
    entites: [E-01]
    operations: []
    etats_ui: []
    questions_ouvertes: []

entites:
  - id: E-01
    nom:
    alias: {desktop: E-04, mobile: E-03}
    champs: []
    utilisee_par: []

decisions:
  - id: D-001
    alias: {desktop: D-03}
    sujet:
    choix:
    raison:
```

Règles :
- Même intention + mêmes données = une seule feature, même si l'interface diffère. Comportement différent selon la plateforme = variante avec le champ `plateforme`.
- Une feature présente d'un seul côté garde une seule plateforme : ne l'invente pas pour l'autre.
- Un seul modèle d'entités. Si les champs diffèrent entre les deux registres, prends l'union et signale l'écart.
- Un seul jeu de rôles : le même rôle sous deux noms garde un seul ID, avec ses alias. Si l'accès à une feature diffère d'une plateforme à l'autre, signale-le dans les contradictions.
- Reprends toutes les décisions déjà prises des deux côtés, avec leur alias.
- Quand un registre découpe en plusieurs features ce que l'autre décrit en une, garde le découpage le plus fin. L'ancien ID figure dans `alias` de chaque morceau, et aussi dans `alias_partiel` de chaque morceau qui n'en reprend qu'une partie : `alias_partiel: {desktop: [F-020]}`. Le morceau qui garde l'essentiel de l'ancien ID peut l'avoir en `alias` seul.
- Quand une décision réunit plusieurs anciens ID d'une même plateforme en un seul élément, cite-la : `alias_decision: D-055`.
- Une variante absorbée par sa feature garde son ancien ID dans l'`alias` de cette feature.
- Un ID retiré va dans `ids_retires` avec sa décision, et son ancien ID quand il en a un : `- {id: F-004.a, alias: {desktop: F-003.a}, decision: D-066}`. Un ancien ID qui n'a jamais été canonique s'écrit sans `id` : `- {alias: {desktop: F-009.a}, decision: D-010}`.
- Après la fusion, tout document encore tenu à jour, inventaires d'écrans compris, cite les IDs canoniques (P-D04, pas P-04). Un alias pointe toujours vers un ID d'un registre par plateforme archivé.
- Fusionne les questions ouvertes qui portent sur le même sujet.

Après le YAML, ajoute :
1. « Fusions effectuées » : chaque feature et entité fusionnée, avec sa justification.
2. « Contradictions » : les cas où les deux registres ou deux décisions disent des choses différentes.
3. « Cas ambigus à trancher » : les cas encore ouverts des deux registres, dédoublonnés, chacun avec ses alias.
````

## Prompts for the data model and data flows

Two prompts for step 8, run in this order once the flows exist. Each writes one file of the system design. The graph is drawn from its file, never edited by hand.

**Prompt 11: data model** (tables, columns and types)

````text
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

**Prompt 12: data-flow graph** (who sends which data to whom)

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
- Un nœud acteur par rôle R-xx. Un nœud par élément d'infra : chaque app, une par plateforme ciblée (web, desktop, iOS, Android), le serveur, chaque stockage, chaque service tiers.
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

## Page contracts

The last part of step 8, run right after prompt 12 and before any code. Every page gets a contract: each component on it, the exact data it reads and writes, the flow that carries that data, and the conditions for it to appear or be enabled. Its point is to make gaps between the design, the registry, the data model and the data flows show up now, not while a feature is being built.

A contract stays one line per item. The detailed rules stay in the feature spec, written at step 10.

**Prompt 13: page contracts** (every page, in one pass)

````text
À partir du registre (pages, features, rôles), de l'extraction du prompt 1, du modèle de données (TB-xx), du graphe de flux (N-xx, DF-xx) et des diagrammes d'états (SM-E-xx), écris le contrat de chaque page dans docs/pages/<id de page>.yaml, avec exactement cette structure :

```yaml
page: P-D04
nom:
acces: [R-01]              # rôles qui peuvent ouvrir la page
entree:
  parametres: []           # ce qu'il faut pour ouvrir la page, ex. id de la dépense
  conditions: []           # ex. "la dépense existe", "l'utilisateur est connecté"
composants:
  - id: C-D04-01
    nom_accessible:        # le libellé lu par un lecteur d'écran et cliqué par la commande app
    type:                  # bouton, champ, liste, texte, carte…
    feature: F-xxx         # ou F-xxx.a
    lit: [TB-xx.colonne]
    ecrit: [TB-xx.colonne]
    flux: [DF-xx]          # les flux qui amènent ou emportent ces données
    visible_si: []         # rôle R-xx, état d'un SM-E-xx, flag F-xxx, valeur d'une colonne TB-xx
    actif_si: []
    etats: [vide, chargement, erreur, interdit]
    questions_ouvertes: []
```

Règles :
- Une ligne par élément : c'est un contrat, pas une spec. Les règles détaillées iront dans la spec de la feature, à l'étape 10.
- Chaque élément vu par le prompt 1 sur cette page devient un composant, ou tu dis pourquoi il disparaît.
- Chaque donnée lue ou écrite cite sa colonne exacte et le flux qui l'amène ou l'emporte.
- Chaque condition cite ce qu'elle teste : un rôle R-xx, un état d'un SM-E-xx, un flag F-xxx ou une colonne TB-xx.
- Si une donnée, une colonne, un flux, un état ou une feature manque, ne l'invente pas : écris MANQUANT suivi de ce qu'il faudrait, et continue.
- Les IDs C-xx sont définitifs : ne jamais renuméroter.

À la fin, liste tous les MANQUANT, page par page.
````

**Prompt 14: check the contracts** (right after prompt 13, then after every change to the registry, the data model, the data flows or a state model)

```text
Vérifie les contrats de pages (docs/pages/*.yaml) contre le registre, le modèle de données, le graphe de flux et les diagrammes d'états, sans rien corriger :
- Chaque MANQUANT encore présent.
- Composant dont la feature n'est pas listée sur cette page dans le registre, et feature de la page sans aucun composant.
- Colonne lue ou écrite qui n'existe pas dans data-model.yaml, et colonne qu'aucun composant ni aucun job ne lit ni n'écrit.
- Donnée lue ou écrite sans flux DF-xx qui la transporte entre l'app de cette page et son stockage.
- Composant ou page visible par un rôle qui n'a pas accès à la feature (`acces`), et page sans rôle autorisé.
- Condition sur un état qui n'existe pas dans le SM-E-xx de l'entité, ou sur un flag ou une colonne qui n'existe pas.
- Paramètre d'entrée d'une page qu'aucune page ni aucun flow ne fournit.
- Deux composants avec le même nom accessible sur la même page.
- Donnée personnelle, identifiant ou paiement écrit via un flux qui n'est pas `sensible: true`.

Liste les écarts page par page, puis classe-les avec le prompt 8.
```

How gaps stay visible from then on:

- Prompts 13 and 14 run once every page has been extracted, before step 9. Their findings go through prompt 8, like the registry check.
- Prompt 14 runs again after each change to the registry, the data model, the data flows or a state model: run it after any of prompts 4, 7, 9, 10, 11 or 12 has changed something.
- From step 3, as soon as the registry exists, the mechanical half of prompt 3, and of prompt 14 once the contracts exist, runs as queries on the registry database, on every pull request (see [Reference](reference.md)). A gap then fails the build the moment it appears. Claude keeps running both prompts for the checks that need judgment.
- A page whose contract still holds a MANQUANT blocks step 10 for every feature on it.

## Pitfalls

| Pitfall | Why it hurts | Instead |
| --- | --- | --- |
| Starting only from pages | Background jobs, expiry and cross-page flows get missed | Run prompt 5 on every flow and job, then map entity states |
| Merging elements too early | Two things that look alike get fused before their differences show | Extract page by page first (prompt 1); merge only in the registry, one reason per merge |
| Vague requirements ("fast", "secure") | No one can tell when they are met | A number or a test: "under 300 ms at p95" |
| Finding a missing column, flow or condition while coding | The gap surfaces late, mid-feature, and the fix ripples back through the design | A contract for every page in step 8 (prompts 13 and 14), checked in CI as soon as they exist |
