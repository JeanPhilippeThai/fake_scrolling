# Design and docs: newest vs current

Compared on 2026-11-27. Second import of the day: the fixes asked by the doc test on the data model and the data flows. Flows carrying a place, a tag, a like or a story view are now sensitive; the crash-report service is a node; the @ is lowercase only. Docs only: the design was not imported, and stays as it is.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 469 -> 480)
- D-144: a friendship's status is named as a state column, like « vue » and « lu ».
- D-145: the @ is lowercase only, as P-27 draws it, and unique; E-01 and F-070's question follow.
- D-147: says it refines D-105 and D-117; E-14, E-15 and F-024 name the exception of a period sent more than 7 days late.
- D-151: a flow is sensitive as soon as it carries data tied to an account (all entities but E-04 and E-13); the crash-report service is node N-14, reached by no DF flow.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 179 -> 210)
- NFR-X-1: the place chosen from a list (F-049) also leaves the phone readable.
- SM-E-08 and FL-13: a post's or story's notifications are erased with it (D-148).
- SM-E-02: the server forgets an expired code and an unfinished sign-up after 1 h (FL-16, D-149).
- SM-E-14, FL-12 and the SM-E-14 TLA+ row: the 7-day exception of D-147.
- FL-03: F-072's question on published posts is marked settled (D-146).
- Data model: TB-01.identifiant is `text`; TB-33 loses the column `facon`.
- Data flows: node N-14 and its dotted edges in the graph; DF-14 to DF-17, DF-30, DF-32, DF-39 and DF-41 are sensitive; 78 sensitive flows.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 155 -> 156)
- P-27's identifier: « minuscules seulement, unique (D-145) »; length and the « already taken » message stay to confirm.
