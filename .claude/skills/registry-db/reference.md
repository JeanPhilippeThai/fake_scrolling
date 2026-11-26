# Registry database: how it reads the docs

The details behind [SKILL.md](SKILL.md). Read this when a row looks wrong, or before writing a query on `mentions`, `aliases` or a flow.

## What it reads

- `docs/` (the method's paths) and `claude_docs/` (the Claude Docs as imported): every `*.yaml` file, and the ```` ```yaml ```` blocks of every `*.md` file, joined in order, because an exported doc often splits one YAML over several blocks.
- By its sections, each YAML is a registry (`roles`, `pages`, `features`, `entites`, `decisions`), a data model (`tables`), data flows (`noeuds`, `flux`) or a page contract (`page`, `composants`).
- A flow (`FL`, prompt 5) is prose, not YAML. In any `*.md` file, a heading that starts with a flow's ID defines it (`## FL-01 Connexion`, or `## Flow FL-01 : Connexion`), and the rest of the heading is its name. Its section runs to the next heading of the same or a higher level, subsections included. Every ID cited in the section links to the flow, one link name per kind: `flow_page`, `flow_feature` (variants included), `flow_entity`, `flow_role`, `flow_decision`, `flow_flow`, and `flow_cites` for any other kind. A heading inside a fenced block is not a heading.
- An archived per-platform registry is one with "archive" in its file name or title. It is loaded in its own scope (`web`, `desktop` or `mobile`), next to the `canonical` registry, so that aliases can be checked. Its platform comes from its file name, its title or its pages. Every other doc is canonical, even one named after a platform.
- A format template copied from a prompt (`stockage: N-xx`, or every `nom:` empty) is skipped, never read as data.
- Every ID cited anywhere, even in prose, is recorded in `mentions` with its file and line.

## The tables, in detail

- `defs`: `defs.number` holds an ID as a number (`D-1` for `D-01` and `D-001`). For a flow, `data` is `{"nom", "texte"}`, the section's text, so that `diff` sees a flow change.
- `refs`: every link as the doc writes it, for example `feature_page`, `page_feature`, `feature_role`, `flow_feature`, `table_entity`, `data_flow_feature` or `component_table`.
- `mentions`: an ID followed by "…" is a format example and is left out; a range ("R-01 à R-07") cites every ID in it. After the merge, every live doc, screen inventories included, must cite canonical IDs: a per-platform ID left in one is an L4-13 finding. A doc with "archive" in its file name or title is frozen history: L4-13 and G-02 skip it (`docs.archived`).
- `aliases(kind, id, platform, alias, path, partial, retired)`: `partial` marks a split declared in `alias_partiel`; `retired` marks an old ID whose item is in `ids_retires` (its `id` is empty when the old ID was retired before the merge and never became canonical). `alias_decisions` and `retired` hold `alias_decision` and `ids_retires`.
- `flows` holds the first and last `line` of each flow's section.

## Special cases of the checks

- Flows are written one at a time, so L5-07 (every feature used across pages is in a flow) waits for the end of step 5: it runs once a data model or data flows exist, since prompts 11 and 12 run once every flow is written. Until then it is "not reached", and the checker reads it with a query of its own if needed. L5-01 and L5-06 hold for each flow as soon as it is written.
- G-03 compares two versions of the docs: an ID that disappeared must be in `ids_retires` with the decision that retired it, or live on as an alias, since an ID is never reused. The CI passes `check --since` the base of the pull request, or the commit before the push. Without a previous version it is "not reached". An ID is compared as a number, so `D-1` retires `D-01`.
- Rows from an archived per-platform registry are shown, but never fail the build: archives are frozen. L3 rows from an archive are not shown at all, because an archive passed L3 before the merge (L4-01).
