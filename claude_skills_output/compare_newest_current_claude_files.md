# Design and docs: newest vs current

Compared on 2026-11-27. One new decision: Maestro drives the app for the runtime checks, on an iPhone simulator and an Android emulator (D-143). The design is unchanged.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 463 -> 464)
- New D-143 « Étape 8 : vérification à l'exécution »: the `app` command of the runtime checks uses Maestro. It drives the app as Expo builds it (D-132), without adding anything to the app. It finds each button, field and link by its accessible name (NFR-X-14), reads what the screen shows and takes the proof screenshots. The NFR-X-14 audit reads the same view of the screen. Proofs run on an iPhone simulator and an Android emulator on every change, and the two-phone test of NFR-X-12 starts two at once. Real phones are checked by hand only, before a release.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 171 -> 173)
- NFR-X-14: its test now says the `app` command finds each element by its name « avec Maestro (D-143) ».
- « Serveur, téléphone et API »: the list of what stays open no longer names the text of P-29, which D-142 settled.

## Unchanged

Design canvas « Fake scrolling — app » (71 files); « Fake scrolling — inventaire des écrans ».
