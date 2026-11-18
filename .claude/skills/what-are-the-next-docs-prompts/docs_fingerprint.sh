#!/usr/bin/env bash
# Print a 12-character fingerprint of the app's design, docs and method files, committed or not.
# Same files with the same content give the same fingerprint; any edit, addition or removal changes it.
set -eu
cd "$(git rev-parse --show-toplevel)"
git ls-files -z -c -o --exclude-standard -- docs design claude_docs claude_design workflow_docs \
  | sort -z -u \
  | xargs -0 -r sha1sum 2>/dev/null \
  | sha1sum | cut -c1-12
