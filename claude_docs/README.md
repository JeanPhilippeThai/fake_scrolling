# Fake scrolling — docs (copie locale pour LLM)

Copie des documents claude.ai sur Fake scrolling, importée le 2026-11-18. Les documents sont en français. Ce sont des instantanés : la source fait foi.

## Fichiers

| Fichier | Contenu | Source |
| --- | --- | --- |
| `registre-canonique.yaml` | **Référence.** Registre canonique : 2 rôles (R-), 26 pages (P-), 62 features (F-) et 20 variantes (F-xxx.a), 17 entités (E-), 24 décisions (D-). Mis à jour le 2026-11-17. | https://claude.ai/artifact/W2ibtgK7oF536LDXh5AAAV (bloc YAML de la page) |
| `registre-regroupements.md` | Pourquoi certains éléments d'écran ont été regroupés dans une même feature. Présent seulement dans la page HTML du registre. | Même page, section « Regroupements effectués » |
| `inventaire-des-ecrans.md` | Inventaire écran par écran (P-01 à P-26) : élément, description, données, états visibles. Le registre a été construit à partir de ce document. Daté du 2026-11-15. | https://claude.ai/artifact/JrVRgnJKXnwGC28FuPVUwz |
| `prochains-prompts.md` | Prochaines étapes de la méthode : prompts prêts à lancer (rôles, états non dessinés, flows FL-01 à FL-16, machines à états, exigences non fonctionnelles, system design). | https://claude.ai/artifact/9joNr2k6zjAmWtiozZMhrn, onglet « Fake scrolling » |

## Conventions d'ID

- `R-xx` rôle · `P-xx` page/écran · `F-xxx` feature · `F-xxx.a` variante · `E-xx` entité · `D-xxx` décision · `FL-xx` flow ou job de fond (proposés dans `prochains-prompts.md`, pas encore dans le registre).
- Les IDs sont définitifs : un ID fusionné est retiré et jamais réutilisé. Des numéros manquent donc (F-013, F-023, F-029, F-032, F-035, F-064).
- En cas de conflit, `registre-canonique.yaml` prime sur l'inventaire.
- « à confirmer » dans l'inventaire signale un comportement déduit, ou propre à la maquette, et non visible dans le design.

Le design correspondant est dans `../claude_design/`.
