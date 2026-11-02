#!/usr/bin/env bash
# Builds docs/data/statmethods-datasets.zip: every CSV in data/ plus a plain
# Markdown copy of the dataset key (data_key.md). Runs after "quarto render"
# (project post-render in _quarto.yml); safe to run by hand from any folder.
set -euo pipefail
cd "$(dirname "$0")/../.."

[ -d docs ] || { echo "docs/ not found; run quarto render first" >&2; exit 1; }
mkdir -p docs/data
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

cp data/*.csv "$tmp"/
Rscript tools/datasets/build_appendix.R --plain "$tmp/data_key.md" >/dev/null
rm -f docs/data/statmethods-datasets.zip
(cd "$tmp" && zip -q -X "$OLDPWD/docs/data/statmethods-datasets.zip" ./*)
echo "Built docs/data/statmethods-datasets.zip ($(ls "$tmp" | wc -l) files)"
