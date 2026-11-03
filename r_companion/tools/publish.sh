#!/usr/bin/env bash
# Post-render step for the R companion: copy the rendered book into the main
# site at docs/companion/, so it is served beside the textbook. Render the
# textbook first; a full textbook render clears docs/.
set -euo pipefail
cd "$(dirname "$0")/.."
[ -d ../docs ] || { echo "publish.sh: ../docs not found; render the textbook first. Companion left in r_companion/_book/."; exit 0; }
rm -rf ../docs/companion
cp -r _book ../docs/companion
echo "publish.sh: copied r_companion/_book to docs/companion"
