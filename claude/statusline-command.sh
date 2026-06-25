#!/usr/bin/env bash
# Reads session data from stdin (provided by Claude Code) and displays:
#   - Model name
#   - Git branch
#   - Context window usage percentage
#   - 5-hour and 7-day rate-limit utilization
#
# Pure bash: no jq, no API call, no OAuth token. Works on subscription plans.

input=$(cat)

cwd=""
if [[ $input =~ \"cwd\"[[:space:]]*:[[:space:]]*\"([^\"]*)\" ]]; then
  cwd=${BASH_REMATCH[1]}
fi

# Extract a numeric "$2" field from the object that follows key "$1".
# Returns empty when the key is absent or the value is null.
extract_num() {
  local rest
  [[ $input == *"\"$1\""* ]] || return
  rest=${input#*"\"$1\""}
  if [[ $rest =~ \"$2\"[[:space:]]*:[[:space:]]*(-?[0-9]+(\.[0-9]+)?) ]]; then
    printf '%s' "${BASH_REMATCH[1]}"
  fi
}

model="Claude"
if [[ $input =~ \"display_name\"[[:space:]]*:[[:space:]]*\"([^\"]*)\" ]]; then
  model=${BASH_REMATCH[1]}
fi

branch=""
if git_branch=$(git -C "${cwd:-$PWD}" rev-parse --abbrev-ref HEAD 2>/dev/null); then
  branch=$git_branch
fi

ctx_used=$(extract_num context_window used_percentage)
five_h=$(extract_num five_hour used_percentage)
five_h_reset=$(extract_num five_hour resets_at)
seven_d=$(extract_num seven_day used_percentage)
seven_d_reset=$(extract_num seven_day resets_at)

dim=$(printf '\033[2m')
reset=$(printf '\033[0m')
sep=$(printf '%s · %s' "$dim" "$reset")
red=$(printf '\033[31m')
yellow=$(printf '\033[33m')
green=$(printf '\033[32m')

# ── Formatters ───────────────────────────────────────────────────────────────

format_reset_relative() {
  local ts=$1 now diff
  now=$(date -d now +%s)
  diff=$(( ts - now ))
  if [ "$diff" -le 0 ]; then
    printf '(now)'
  elif [ "$diff" -lt 3600 ]; then
    printf '(%dm left)' $(( diff / 60 ))
  else
    printf '(%dh left)' $(( diff / 3600 ))
  fi
}

format_reset_absolute() {
  date -d "@$1" '+(%b %-d %-I:%M%p)' | tr '[:upper:]' '[:lower:]'
}

format_pct() {
  local pct
  pct=$(printf '%.0f' "$1")
  if [ "$pct" -ge 90 ]; then
    printf '%s%d%%%s' "$red" "$pct" "$reset"
  elif [ "$pct" -ge 70 ]; then
    printf '%s%d%%%s' "$yellow" "$pct" "$reset"
  else
    printf '%s%d%%%s' "$green" "$pct" "$reset"
  fi
}

# ── Context window ────────────────────────────────────────────────────────────

branch_segment=""
if [ -n "$branch" ]; then
  branch_segment=$(printf '%s%s%s' "$sep" "$branch" "")
fi

ctx_segment=""
if [ -n "$ctx_used" ]; then
  ctx_segment=$(printf '%s%sctx:%s %s' "$sep" "$dim" "$reset" "$(format_pct "$ctx_used")")
fi

header_segment=$(printf '%s%s%s%s%s' "$dim" "$model" "$reset" "$branch_segment" "$ctx_segment")

# ── Rate-limit quota (5h / 7d) ────────────────────────────────────────────────

quota_segment=""
if [ -n "$five_h" ] && [ -n "$seven_d" ]; then
  five_h_str="$(format_pct "$five_h")"
  seven_d_str="$(format_pct "$seven_d")"
  [ -n "$five_h_reset" ] && five_h_str="${five_h_str} ${dim}$(format_reset_relative "$five_h_reset")${reset}"
  [ -n "$seven_d_reset" ] && seven_d_str="${seven_d_str} ${dim}$(format_reset_absolute "$seven_d_reset")${reset}"
  quota_segment=$(printf '%s%s5h:%s %s%s%s7d:%s %s' \
    "$sep" "$dim" "$reset" "$five_h_str" \
    "$sep" "$dim" "$reset" "$seven_d_str")
fi

printf '%s%s\n' "$header_segment" "$quota_segment"
