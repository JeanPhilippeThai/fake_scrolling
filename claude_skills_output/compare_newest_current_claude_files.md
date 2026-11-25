# Design and docs: newest vs current

Compared on 2026-11-25. Photo seeds and seed erases now wait in FL-12 when there is no network (D-122). A new server task, FL-14, erases after 24 h the seeds that nothing took (D-123).

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 409 -> 412)
- **D-122** added: without network, the seed of a chosen or taken photo (D-120) and the erase of a removed photo's or closed draft's seeds (D-121) are pending sends of FL-12, with its rules (D-101, D-104, D-112, D-113). A seed still waiting when its draft is gone is never sent. Seeds still waiting go with the publication. This widens D-108's list.
- **D-123** added: « Une tâche de fond du serveur efface, 24 h après son arrivée, toute graine rattachée à rien (ni post, ni story, ni message, ni photo de profil), avec son algorithme ». A publication made later sends the seeds again. Described by FL-14.
- **E-04**: new field « heure d'arrivée de la graine sur le serveur, pour l'effacer après 24 h si rien ne la prend (D-123) ».
- **F-044**: open question « Brouillon perdu sans « Fermer » … quand le serveur efface-t-il ses graines (D-121) ? » removed, settled by D-123.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 103 -> 116)
- **FL-03**: steps 1 and 1' say a seed waits in FL-12 without network (D-122). The « Fermer » row now covers erases sent through FL-12 and seeds never sent. Three rows added: a photo removed from the selection; a draft lost without « Fermer »; publishing with seeds still waiting or already erased by FL-14. A « Réglés le 25 novembre 2026 » line was added.
- **FL-12**: FL-03 is a new entry. Steps 1 and 3 add F-044, F-046, F-005 and E-04 (seed, erase). Two rows added: a seed whose draft disappears is dropped unsent, and seeds still waiting go with the publication. « graine déjà effacée (FL-14) » is a refusal for good.
- **FL-14 Effacer les graines orphelines** added: a server background task, 2 steps (wait, then erase after 24 h), with 4 decision rows (publication within 24 h, publication after the erase, a late erase from FL-12, account deletion).
- **Modèles TLA+**: the sync row adds `D122_RecordedOrDropped`.

## Unchanged

Design canvas `fake-scrolling-app` (70 files); `inventaire-des-ecrans.md` (rev 152).
