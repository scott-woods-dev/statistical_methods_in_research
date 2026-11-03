#!/usr/bin/env bash
# Release routine: runs every pre-release check in order and stops at the first
# failure. Report-only: it never edits prose, data, or figures.
#
#   tools/release/release.sh            full routine (renders; takes minutes)
#   tools/release/release.sh --fast     steps 1 to 4 only (no render, links, or scan)
#
# Steps: 1 tree, 2 style, 3 figures and values, 4 generated files,
# 5 render, 6 companion render, 7 companion links, 8 accessibility,
# 9 summary. WARN hits from the style check are counted and reported; they
# never fail the release.
# Step 8 needs playwright, @axe-core/playwright, and Chromium (see FIGURES.md).

cd "$(dirname "$0")/../.." || exit 2

FAST=0
[ "$1" = "--fast" ] && FAST=1

START=$SECONDS
LOG=$(mktemp)
SERVER_PID=""
SUMMARY=()
trap '[ -n "$SERVER_PID" ] && kill "$SERVER_PID" 2>/dev/null; rm -f "$LOG"' EXIT

pass() { SUMMARY+=("PASS  $1${2:+ ($2)}"); }
skip() { SUMMARY+=("SKIP  $1${2:+ ($2)}"); }
fail() {
  SUMMARY+=("FAIL  $1${2:+ ($2)}")
  [ -s "$LOG" ] && { echo "--- output of failed step: $1 ---"; cat "$LOG"; }
  summary
  exit 1
}
summary() {
  echo
  echo "Release routine summary"
  printf '  %s\n' "${SUMMARY[@]}"
  echo "  Elapsed: $((SECONDS - START))s"
}

# 1. Tree
if [ -n "$(git status --short)" ]; then
  SUMMARY+=("WARN  1 tree: uncommitted changes (the release does not contain them)")
  git status --short
else
  pass "1 tree" "clean"
fi

# 2. Style (exit 1 on FAIL hits; WARN hits are only counted)
bash tools/style/check_style.sh >"$LOG" 2>&1 || fail "2 style" "FAIL hits"
WARNS=$(grep -E '^\[WARN\]' "$LOG" | sed -E 's/.*\(([0-9]+)\)$/\1/' | awk '{s+=$1} END{print s+0}')
pass "2 style" "${WARNS:-0} WARN hits to review, not blocking"

# 3. Figures and values (validates; does not regenerate)
for n in 01 02 03 04 05 06 07 08 09 10 11 12 13; do
  Rscript r_code/figures/check_chapter.R "$n" >"$LOG" 2>&1 || fail "3 figures" "chapter $n"
done
pass "3 figures" "chapters 01 to 13"

# 4. Generated files must be current (generators land with the index and datasets tasks)
GEN=()
if [ -f tools/index/build_index.R ]; then
  Rscript tools/index/build_index.R >"$LOG" 2>&1 || fail "4 generated" "build_index.R"
  GEN+=(chapters/appendix-index.md)
fi
if [ -f tools/datasets/build_appendix.R ]; then
  Rscript tools/datasets/build_appendix.R >"$LOG" 2>&1 || fail "4 generated" "build_appendix.R"
  GEN+=(chapters/appendix-datasets.md)
fi
if [ ${#GEN[@]} -eq 0 ]; then
  skip "4 generated" "no generators yet"
else
  git diff --exit-code --stat -- "${GEN[@]}" >"$LOG" 2>&1 || fail "4 generated" "stale; commit the regenerated files"
  pass "4 generated" "${GEN[*]}"
fi

if [ "$FAST" = 1 ]; then
  skip "5 render" "--fast"
  skip "6 companion" "--fast"
  skip "7 links" "--fast"
  skip "8 accessibility" "--fast"
  summary
  exit 0
fi

# 5. Render
# Plain `quarto render` builds every format in _quarto.yml (html and pdf); passing
# `--to html --to pdf` left docs/ with only the PDF.
quarto render >"$LOG" 2>&1 || fail "5 render" "quarto render"
for f in docs/index.html docs/chapters/chapter-01.html docs/chapters/appendix-datasets.html docs/chapters/appendix-index.html docs/data/statmethods-datasets.zip; do
  [ -f "$f" ] || { echo "missing $f" >"$LOG"; fail "5 render" "HTML output missing"; }
done
PDF=$(ls docs/*.pdf 2>/dev/null | head -n 1)
PAGES=$([ -n "$PDF" ] && pdfinfo "$PDF" 2>/dev/null | awk '/^Pages:/{print $2}')
pass "5 render" "PDF ${PAGES:-?} pages"

# 6. Companion render. It must follow the book render, which clears docs/;
# the companion's post-render step (r_companion/tools/publish.sh) copies it
# into docs/companion/.
(cd r_companion && quarto render) >"$LOG" 2>&1 || fail "6 companion" "quarto render in r_companion"
for f in docs/companion/index.html docs/companion/chapter-12.html; do
  [ -f "$f" ] || { echo "missing $f" >"$LOG"; fail "6 companion" "HTML output missing"; }
done
CPDF=$(ls docs/companion/*.pdf 2>/dev/null | head -n 1)
[ -n "$CPDF" ] || { echo "missing docs/companion/*.pdf" >"$LOG"; fail "6 companion" "PDF missing"; }
CPAGES=$(pdfinfo "$CPDF" 2>/dev/null | awk '/^Pages:/{print $2}')
pass "6 companion" "PDF ${CPAGES:-?} pages"

# 7. Companion links into the textbook. Section ids come from the heading text,
# so a renamed heading breaks a link silently; check them against the render.
bash tools/links/check_companion_links.sh >"$LOG" 2>&1 || fail "7 links" "broken companion links"
pass "7 links" "$(tail -n 1 "$LOG" | sed -E 's/.*: //')"

# 8. Accessibility, desktop and phone width. Pages: the landing page plus every
# file in chapters/, so the list cannot drift from the book.
PAGES_LIST=("/")
for f in chapters/*.md; do PAGES_LIST+=("/chapters/$(basename "$f" .md).html"); done
python3 -m http.server 8765 -d docs >/dev/null 2>&1 &
SERVER_PID=$!
sleep 1
export NODE_PATH
NODE_PATH=$(npm root -g)
node tools/a11y/scan.cjs --base http://localhost:8765 "${PAGES_LIST[@]}" >"$LOG" 2>&1 \
  || fail "8 accessibility" "desktop width"
VW=390 VH=844 node tools/a11y/scan.cjs --base http://localhost:8765 "${PAGES_LIST[@]}" >"$LOG" 2>&1 \
  || fail "8 accessibility" "phone width"
pass "8 accessibility" "${#PAGES_LIST[@]} pages at 1280 and 390 wide"

# 9. Summary
summary
