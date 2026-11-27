# Design and docs: newest vs current

Compared on 2026-11-27. The docs gain ten decisions (D-152 to D-161) taken while writing the page contracts (prompt 13): the place of a post is typed freely, a new account gets one collection « Favoris », and the conversation, the profile grid, the search suggestions, the likes counter and two late-error cases are settled. The data flows now carry everything the screens show.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 480 -> 521)
- **D-152**: if « Mettre à jour » (P-29) cannot open the store, nothing changes on P-29; no error state.
- **D-153**: a post shared to a friend that no longer exists or can no longer be seen stays a message, shown as a grey box « Ce post n’est plus disponible. ». F-019 is flagged for a redraw of P-09.
- **D-154**: finishing sign-up more than 1 h after starting shows « Ton inscription a expiré. Reconnecte-toi pour la finir. » on P-27, then P-01. F-070 is flagged for a redraw of P-27.
- **D-155**: the profile grid (F-062) shows every post, newest first, loaded by batches. F-062's description changes.
- **D-156**: a conversation (F-038) goes back to its first message, older ones loaded by batches.
- **D-157**: the place of a post or story (F-049) is typed freely, 60 characters at most, and leaves the phone readable (an exception to D-118 and NFR-X-1). P-25 loses its list of places and « Aucun lieu trouvé. ». F-049 is flagged for a redraw of P-25; its description changes.
- **D-158**: the 8 suggestions and 6 trends of P-14 are computed by the server from recent posts, nothing stored; the exact rule stays open in F-053.
- **D-159**: the likes counter of P-17 counts the likes received on the account's posts.
- **D-160**: each collection keeps the colour it gets at creation; E-07 gains the field « couleur ».
- **D-161**: a new account gets one collection, « Favoris », created by F-070 (whose description changes). F-018 is flagged for a redraw of P-06.
- Open questions closed: F-019 (shared post gone), F-038 (history), F-049 (source of places), F-057 (fixed counters), F-062 (grid size), F-070 (sign-up after 1 h).
- Features now list the entities their screens read, and the entities list them back: F-015, F-017, F-019, F-020, F-022, F-030, F-033, F-036, F-037, F-038, F-043, F-048, F-052, F-053, F-057, F-062, F-070, F-071, F-072; E-01, E-03, E-04, E-06, E-07, E-09, E-11, E-14, E-17.

### Conception système – Fake scrolling (`conception-systeme.md`, rev 210 -> 237)
- Data flows: DF-15, DF-17 carry E-01; DF-23, DF-25 carry E-04 and E-05 and serve F-019; DF-31, DF-33 carry E-01 and E-04; DF-35, DF-37 carry E-01; DF-39, DF-41 carry E-01 and E-06 and serve F-020; DF-47, DF-49 carry E-06 and E-09; DF-71, DF-77 serve F-063 and F-071 (clearing the known timer, TB-31).
- Data model: TB-11 gains `couleur` (D-160); `lieu` of TB-06 and TB-19 becomes `varchar(60)` (D-157).
- NFR-X-1 now names the typed place (D-157) as readable; FL-03, FL-16, SM-E-02 and the open-question lines cite D-154, D-157 and D-158 instead of the questions they settled.
- New section « Contrats de pages »: the 29 page contracts live in the repo, `docs/pages/P-01.yaml` to `P-29.yaml`, and the section says how they are written.

## Unchanged

The design canvas « Fake scrolling — app » (71 files) and « Fake scrolling — inventaire des écrans » (rev 156).
