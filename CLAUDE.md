# CLAUDE.md

@.claude/workflow-claude-rules.md

## The app

Fake scrolling: a mobile social-feed app, specified with the method in [workflow_docs/method.md](workflow_docs/method.md). No app code yet: the work is on the design and the docs. The app's language is French.

## Links on claude.ai

- Design canvas: [Fake scrolling — app](https://claude.ai/artifact/9fxJvdH8dPEDrrLKNWerJT).
- Claude Doc [Registre canonique – Fake scrolling](https://claude.ai/artifact/A5qaJU9xAkPWfJ6JUNfWHV): the registry in force (D-038).
- Claude Doc [Fake scrolling — inventaire des écrans](https://claude.ai/artifact/JrVRgnJKXnwGC28FuPVUwz).
- Claude Doc [Conception système – Fake scrolling](https://claude.ai/artifact/V35ZLk13bPhs4byZvSoaXg): the flows (FL-xx) and, later, the rest of the system design.

## Where things are

- `claude_design/`: the official design. View it with the `preview-live-designs` skill. `fake-scrolling-app/.claude-ai.json` records what claude.ai held at the last import.
- `claude_docs/`: the docs. Read `INDEX.md` first. Decisions (D-xxx), features (F-xxx) and retired IDs (`ids_retires`) live in `registry.md`, the import of the registry Claude Doc.
- `docs/system-design/`: the TLA+ models (a `.tla` and its `.cfg` per model), chosen by D-107 and listed in the table "Modèles TLA+" of "Conception système". Unlike `claude_docs/`, they are written in the repo: edit them here, citing the flow and decisions they check. To check one locally: `java -cp tla2tools.jar tlc2.TLC -deadlock -config <Model>.cfg <Model>.tla` in that folder.
- `docs/pages/`: the page contracts (prompt 13), one `P-NN.yaml` per page, listed in the section "Contrats de pages" of "Conception système". Like the TLA+ models, they are written in the repo, because the registry database reads one contract per file; the CI checks them (L10, B10).
- `docs/questions.md`: the open questions about the whole app (`Q-NN`); questions about one feature go in its `questions_ouvertes`. Create the file with the first question.
- `claude_skills_output/`: skill reports. `what_are_the_next_docs_prompts_output.md` says what to do next.
- `newest_claude_*/`: gitignored scratch imports from claude.ai.
- `.claude/import-exclude.txt`: artifacts the import leaves out, such as the archived HTML registry page.

## CI

- `registry_db.py check` on the docs, and a check that this file includes the shared rules, on every pull request ([workflow-claude-registry-db.yml](.github/workflows/workflow-claude-registry-db.yml)).
- TLC on every model of `docs/system-design/`, on pull requests that touch that folder ([tla-models.yml](.github/workflows/tla-models.yml)).
