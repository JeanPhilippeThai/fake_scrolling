# Next docs prompts

2026-11-19 · commit 3e7c924 · fingerprint 3444ac5c679a

The docs are not clean: fix them before running the next prompts.

## Doc tests
| Doc test | Output | Result |
| --- | --- | --- |
| test-design-and-docs-conformity | `claude_skills_output/design_and_docs_check_output.md` | Failed: 2 blocking (#2, #4), 5 major, 3 minor |

## Fix first
1. **#4 L3-11** (D-037, D-038): D-037 says the registry is imported as `claude_docs/registry.yaml`, D-038 says `claude_docs/registry.md`, and D-037 is not marked replaced. In the registry Claude Doc, mark D-037 « Remplacée en partie par D-038 » (the file name), keeping its rule on ids_retires and digits; then import and promote.
