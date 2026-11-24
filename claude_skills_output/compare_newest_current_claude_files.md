# Design and docs: newest vs current

Compared on 2026-11-24. Prompt 8 on findings 2, 3 and 6 of the last check:
- F-008 and F-051 now read as well as write.
- A story keeps the photos and the caption (D-068).
- A deleted account goes back to Connexion after 2 s (D-069). F-063 is flagged for a redraw.

The design did not change.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 211 -> 224)
- **F-008 Renvoyer le code** and **F-051 Publier le post**: `operations` becomes `[lecture, écriture]`. The countdown and the draft are read (finding 2, L5-02).
- **F-044, F-046, F-047**: they write E-12 as well as E-03. Each description ends « pour un post ou une story (D-068) », and F-046's ends « la photo du post ou de la story (D-068) ».
- **E-12 Story**: `utilisee_par` adds F-044, F-046 and F-047.
- **F-063 Supprimer son compte**:
  - It cites E-02 (the session is closed, D-053).
  - Its state becomes « compte supprimé : « Compte supprimé » et « Merci d’être passé·e. » 2 s, puis P-01 s'ouvre (D-069) ».
  - Its question becomes « Effacement réel des données (la fermeture de la session est réglée par D-053) ».
  - It carries `design_a_mettre_a_jour: true`.
- **E-02 Connexion**: `utilisee_par` adds F-063.
- **D-068** (new): a story keeps the chosen photos and the caption; no design change.
- **D-069** (new): after « Supprimer définitivement », the goodbye stays 2 s, then P-01 opens; F-063 is to be redrawn.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 133 -> 135)
- **P-21, « Confirmer la suppression »**:
  - Data: « Compte, posts, messages, amis ; session de l'appareil fermée (D-053) ; effacement réel : à confirmer ».
  - States: « …, 2 s, puis P-01 s'ouvre (D-069, non dessiné) ».

### Conception système – Fake scrolling (`conception-systeme.md`, rev 14 -> 22)
- **FL-01**:
  - D-069 is added to its decisions.
  - The entry from F-063 says « Compte supprimé » stays 2 s before P-01.
  - The summary says F-008 reads and writes E-02.
- **FL-03**:
  - D-068 is added to its decisions.
  - Steps 1, 1' and 3 write « E-03 ou E-12 ».
  - The summary moves F-051 to « lisent et écrivent ».

## Unchanged

Design canvas « Fake scrolling — app » (69 files).
