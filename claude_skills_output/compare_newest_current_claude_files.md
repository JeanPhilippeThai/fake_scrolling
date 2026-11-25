# Design and docs: newest vs current

Compared on 2026-11-25. Four new decisions (D-114 to D-117) from step 6: account creation creates the timer, usage time and support record; the server records one support per account; a waiting support goes with a deleted account; time spent offline counts. The "Modèles TLA+" table now points to the five checked models.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 376 -> 387)
- **D-114** added: creating an account (F-070) also creates E-14 (stopped, no cycle elapsed), E-15 (0 s) and E-16 (non soutenu). F-070's `entites` become `[E-02, E-01, E-14, E-15, E-16]`, its description says so, and E-14, E-15 and E-16 list F-070 in `utilisee_par`.
- **D-115** added: the server records only one support per account; a second purchase made on another phone before the first is recorded changes nothing. F-015 gets the open question « Second achat fait sur un autre téléphone du compte avant que le serveur ait enregistré le premier (D-115) : remboursé par le store, et comment ? ».
- **D-116** added (refines D-113): a waiting support is dropped when its account is deleted, on this phone or another.
- **D-117** added: seconds in the foreground without network count for E-14 and E-15. The phone sends each period through FL-12. The server merges periods across phones, counting a shared second once, and only seconds after the last reset count for the timer.
- **E-14, E-15, E-16** fields: « y compris sans réseau (D-117) » on the time fields; E-16's purchase field adds « abandonné si le compte est supprimé (D-116) ; un seul enregistré par compte (D-115) ».
- **F-060** gets the open question « Un téléphone dont l'horloge est fausse peut faire gagner un réglage plus ancien (D-111) : corriger l'heure des téléphones par celle du serveur ? ».

### Conception système – Fake scrolling (`conception-systeme.md`, rev 60 -> 84)
- **FL-01**: step 4 (F-070) also writes E-14, E-15 and E-16 with their starting values (D-114).
- **FL-05**: the timer advances even without network; the phone greys by itself and sends its seconds through FL-12 (D-117).
- **FL-09**: E-15 counts offline seconds sent through FL-12 (D-117); the server records one support per account even if another phone paid meanwhile (D-115).
- **FL-11**: waiting sends are dropped with the account, support included (D-116).
- **FL-12**: a new input, offline foreground periods (F-024, F-073). E-15 joins what step 3 writes. Two phones' offline seconds merge (D-105, D-117). A refused support is dropped only with its account (D-116). A phone no longer connected to a deleted account drops that account's sends at its next exchange with the server.
- **SM-E-02, SM-E-14, SM-E-16**: tables updated for D-114, D-115, D-116 and D-117; F-015's open list adds the second purchase (D-115).
- **Modèles TLA+** (was « Modèles TLA+ à écrire »): the models live in `docs/system-design/`, checked by TLC in CI. The table lists each model's file and the rules it checks, named after their decisions until their BR exist. A note records what TLC found: a support confirmed by the store after the account was deleted on another phone is debited, then dropped (D-116).

## Unchanged

Design canvas « Fake scrolling — app » (69 files); « Fake scrolling — inventaire des écrans » (rev 147).
