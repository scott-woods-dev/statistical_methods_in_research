#!/usr/bin/env bash
# Style and spelling check for the book prose. Report-only: it never edits.
#
#   tools/style/check_style.sh          run from the repo root
#
# FAIL checks are always wrong in this book (CLAUDE.md sections 1 and 4) and
# make the script exit 1. WARN checks match patterns that are sometimes
# legitimate, so they list candidates for review and never change the exit code.
# A line containing any substring listed in tools/style/allow.txt is skipped
# (quoted titles and citations that keep their original spelling).

cd "$(dirname "$0")/../.." || exit 2

FILES=(chapters/*.md index.md data/*.md)
ALLOW=tools/style/allow.txt

# Emit "file:line:text" for every line outside fenced code blocks.
prose() {
  awk 'FNR==1{fence=0} /^```/{fence=!fence; next} !fence{print FILENAME ":" FNR ":" $0}' "${FILES[@]}"
}

scan() { # scan <label> <perl-regex> <fail|warn>
  local label=$1 re=$2 level=$3 out
  out=$(prose | grep -P -- "$re" | { if [ -s "$ALLOW" ]; then grep -vFf "$ALLOW"; else cat; fi; } | grep -P -- "$re")
  [ -z "$out" ] && return
  local n; n=$(printf '%s\n' "$out" | wc -l)
  printf '\n[%s] %s (%d)\n' "${level^^}" "$label" "$n"
  printf '%s\n' "$out" | cut -c1-220
  [ "$level" = fail ] && FAILED=1
}

FAILED=0

# ---- FAIL: always wrong ----
scan "em dash" '—' fail
scan "banned phrase" "(?i)\b(it is important to note|it(’|')s worth noting|delve|unpack(s|ed|ing)?\b|in today(’|')s world|plays? a crucial role|at the end of the day|this underscores the importance|in conclusion)" fail
scan "banned jargon" '(?i)\b(robust\w*|seamless\w*|utili[sz]\w+|landscape|realm|tapestry|foster\w*|streamlin\w+|holistic\w*|multifaceted|nuanced?|myriad|elevat\w+|empower\w*)\b' fail
scan "banned adverb" '(?i)\b(obviously|trivially)\b' fail
scan "H_a notation" '\bH_\{?a\}?\b' fail
scan "British spelling: -our/-re/-ce" '(?i)\b(colour\w*|behaviour\w*|favour\w*|honour\w*|neighbour\w*|labour\w*|humour\w*|centre[sd]?|metres?|litres?|fibre|theatre|defence|licence|grey|catalogue[sd]?|programmes?)\b' fail
scan "British spelling: -ise family" '(?i)\b(summari|organi|recogni|normali|prioriti|characteri|criticiz|criticis|randomi|standardi|generali|minimi|maximi|realis|categori|visuali|specialis|finali|optimi|hypothesi|emphasi|apologi|authori|capitali|customi|familiari|memori|penali|summari|symbolis|synthesi|utili)s(e|ed|es|ing|ation|ations)\b|\banalys(e|ed|ing)\b' fail
scan "British spelling: doubled consonant" '(?i)\b(labell(ed|ing)|modell(ed|ing)|travell(ed|ing|er)|cancell(ed|ing)|fuell(ed|ing)|signall(ed|ing)|levell(ed|ing)|counsell(ed|ing)|totall(ed|ing))\b' fail
scan "British spelling: one-offs" '(?i)\b(whilst|amongst|towards|learnt|spelt|judgement|ageing|enrolment|fulfil|practis(e|ed|es|ing)|per cent|different to|artefacts?|sceptic\w*|aluminium|maths|Centre for Epidemiological Studies)\b' fail

# ---- WARN: candidates for review ----
scan "'clearly' (banned when it presumes the reader sees it; fine as a manner adverb, e.g. 'state it clearly')" '(?i)\bclearly\b' warn
scan "'leverage' (banned as jargon, but a real regression term; judge by context)" '(?i)\bleverag\w+' warn
scan "sentence-initial 'Let us' (propose 'Let's' or a direct rewrite; mid-sentence 'let us' is fine)" '(^[^:]*:[0-9]+:\s*(>\s*)?(- |\d+\. )?|[.?!:]["”]?\s+)Let us\b' warn
scan "'Not X, but Y' / 'not just X, it's Y' frame" "(?i)\b(it(’|')s|it is|this is|that(’|')s|that is) not (just |merely |only |simply )?[^.;:!?]{1,80}[,;] (but |it(’|')s |it is |this is |that(’|')s |that is )|\bnot (just|merely|only) [^.;:!?]{1,60}[,;] (but|it|this|that|they|we)\b|\bnot only\b[^.;:!?]{1,80}\bbut also\b" warn
scan "'rather than X, Y' / 'more than just' filler" '(?i)\bmore than (just|merely|simply)\b' warn

if [ "$FAILED" = 1 ]; then
  printf '\nStyle check: FAIL (see [FAIL] sections above)\n'
  exit 1
fi
printf '\nStyle check: no FAIL hits (WARN items, if any, need review)\n'
