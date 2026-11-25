# Design and docs: newest vs current

Compared on 2026-11-25. The flow FL-09 « Soutenir le projet » is written, with five new decisions (D-092 to D-096) and a new background feature F-073 that counts the usage time. The design did not change.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 284 -> 318)

- **D-092**: support is a one-time App Store or Google Play purchase at 1,99 €, once per account. The server keeps the status in E-16, restored on another phone or after a reinstall.
- **D-093**: the usage time (E-15) belongs to the account and is kept on the server, like the colour timer (D-074). It counts only while the app is open, in the foreground and signed in.
- **D-094**: after support, it works as the design shows. P-22 keeps the ring and the offer, with « Merci pour ton soutien. » in place of the button. The Premium post (F-015.a) shows the thanks until the feed reloads, then is never offered again.
- **D-095**: « Merci pour ton soutien. » shows as soon as the store confirms. If the server doesn't record the purchase, the app resends it silently at each launch. P-22.a and P-03.c show only when the store charged nothing.
- **D-096**: new feature **F-073** « Compter le temps d'utilisation ». It is a background job with no visible element, on the same 25 pages as F-024 (P-03 to P-28), and it reads and writes E-15.
- **F-015**: description and states updated (D-092, D-094, D-095). Its open questions on the payment channel and on the hiding rule are closed. Two new ones: a store refund, and a pending purchase.
- **F-015.a**: its `difference` now says the thanks stay until the feed reloads (D-094).
- **F-065**: the « par compte ou par appareil » question is closed (D-093).
- **E-15**: new fields `compte` and « durée cumulée, appli ouverte et au premier plan ». `utilisee_par` adds F-073.
- **E-16**: new fields `compte` (D-092) and « achat du store » (D-095).
- **P-03 to P-26, and P-28** (25 pages): `features` adds F-073.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 32 -> 34)

- **FL-09 Soutenir le projet** added:
  - a 7-step sequence: count the time, follow it on P-22, the offer at 1 h, pay, thanks, after support, another phone;
  - 11 decision points;
  - the registry gaps settled (D-092 to D-096), and the questions left open (F-015, F-073).
- **FL-05**: its out-of-scope line now points to FL-09, and its open F-065 question now says it was settled by D-093.

## Unchanged

Design canvas « Fake scrolling — app » (69 files); Fake scrolling — inventaire des écrans (rev 137).
