# Design and docs: newest vs current

Compared on 2026-11-27. The system design now holds the data model (33 tables, TB-01 to TB-33) and the data-flow graph (13 nodes, 84 flows), with two new background tasks (FL-16, FL-17) and eight decisions (D-144 to D-151). Docs only: the design was not imported, and stays as it is.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 464 -> 469)
- D-144: the data model's rules: ids made by the phone (the write number of D-137), everything of an account erased with it, counters counted on demand, states read from rows.
- D-145: the @ is unique, capitals ignored (`@Lea` blocks `@lea`); E-01's « identifiant » says so.
- D-146: « Amis proches » always follows today's list, for posts and stories already published too; F-072's question on it is closed.
- D-147: the server keeps the app's foreground periods 7 days (FL-17); a period sent more than 7 days late counts in full.
- D-148: a post's or story's notifications are erased with it (a story's tag when it ends, FL-13).
- D-149: an e-mail address or Google / Apple account that led to no account is forgotten within 1 h (FL-16).
- D-150: the phone keeps the last timer state and the clock offset in SQLite, so the grey survives a restart offline.
- D-151: the data-flow graph: one app per phone, what counts as a sensitive flow.
- F-070: the @ question keeps length, characters and the « already taken » message; new question on a sign-up finished more than 1 h after it began.
- F-019: new question on what a shared post shows in a conversation once it no longer exists.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 173 -> 179)
- New flows FL-16 « Oublier les connexions inachevées » and FL-17 « Oublier les vieilles périodes au premier plan ».
- New section « Modèle de données »: the tables TB-01 to TB-33 (PostgreSQL N-01, SQLite N-02, secure storage N-03), the entity fields that are computed, the columns with no entity field, and where each state of SM-E-02 to SM-E-16 is read.
- New section « Flux de données »: nodes N-01 to N-13, flows DF-01 to DF-84, the graph, and the 70 sensitive flows for the threat model.
- FL-15 now names its table (TB-26); the background-task row of « Qui fait quoi » adds FL-16 and FL-17 (D-147, D-149).

## Unchanged

Fake scrolling — inventaire des écrans (rev 155); the design (not imported).
