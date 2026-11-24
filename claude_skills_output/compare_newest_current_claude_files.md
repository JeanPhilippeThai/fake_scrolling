# Design and docs: newest vs current

Compared on 2026-11-24. New decision D-091: on your own phone, a new profile photo shows as it is for about 1 s, then turns into its generated art. Three flow rows and F-005.a are corrected to match the registry and D-090.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 281 -> 284)
- **D-091** added, « Photo de profil nette environ 1 s »: after a profile photo change (F-058), the chosen photo shows as it is for about 1 s, on its owner's phone only, then gives way to its generated art (D-086), like typed text before the charabia (D-083). Only the seed and the algorithm leave the phone. The design does not change.
- **F-058** `etats_ui`: « nette environ 1 s » becomes « nette environ 1 s, sur son seul téléphone, puis art généré (D-091) ».
- **F-005.a** `difference`: ends with « ; ouverte depuis la Recherche (P-14 à P-16), sur P-14 (D-090) ».

### Conception système – Fake scrolling (`conception-systeme.md`, rev 29 -> 32)
- **FL-03**, P-12 « Croix Fermer » row: adds « ; ouverte depuis la Recherche (P-14 à P-16), retour sur P-14 (D-090) ».
- **FL-07** step 5 « Citer un message »: F-040 no longer reads E-11 (« Entités lues » is now « — »), matching its `operations: [écriture]`.
- **FL-08** step 6 « Passer d'un résultat à l'autre »: F-010.a is added to the features, the one that reads E-04.

## Unchanged

Design canvas `fake-scrolling-app` (69 files); `inventaire-des-ecrans.md` (rev 137).
