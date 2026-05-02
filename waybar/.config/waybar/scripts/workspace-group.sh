#!/usr/bin/env bash
set -euo pipefail

MAIN_MONITOR="DP-1"
TOP_MONITOR="DP-2"

group="${1:-}"

case "$group" in
  1)
    main_ws=1
    top_ws=4
    ;;
  2)
    main_ws=2
    top_ws=5
    ;;
  3)
    main_ws=3
    top_ws=6
    ;;
  *)
    printf '{"text":"?","tooltip":"Usage: %s [1|2|3]","class":"error"}\n' "$0"
    exit 0
    ;;
esac

json_escape() {
  local s=${1//\\/\\\\}
  s=${s//\"/\\\"}
  s=${s//$'\n'/\\n}
  printf '%s' "$s"
}

emit() {
  local text=$1 tooltip=$2 class=$3

  printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' \
    "$(json_escape "$text")" \
    "$(json_escape "$tooltip")" \
    "$(json_escape "$class")"
}

monitors_json="$(hyprctl monitors -j)"
workspaces_json="$(hyprctl workspaces -j)"

main_active="$(
  jq -r --arg monitor "$MAIN_MONITOR" \
    '.[] | select(.name == $monitor) | .activeWorkspace.id' <<<"$monitors_json"
)"
top_active="$(
  jq -r --arg monitor "$TOP_MONITOR" \
    '.[] | select(.name == $monitor) | .activeWorkspace.id' <<<"$monitors_json"
)"

main_windows="$(
  jq -r --argjson workspace "$main_ws" \
    'map(select(.id == $workspace)) | first | .windows // 0' <<<"$workspaces_json"
)"
top_windows="$(
  jq -r --argjson workspace "$top_ws" \
    'map(select(.id == $workspace)) | first | .windows // 0' <<<"$workspaces_json"
)"

class="empty"
if (( main_windows > 0 || top_windows > 0 )); then
  class="occupied"
fi

if [[ "$main_active" == "$main_ws" && "$top_active" == "$top_ws" ]]; then
  class="active"
elif [[ "$main_active" == "$main_ws" || "$top_active" == "$top_ws" ]]; then
  class="partial"
fi

tooltip="Group $group"
tooltip+=$'\n'
tooltip+="${MAIN_MONITOR}: workspace ${main_ws} (${main_windows} windows)"
tooltip+=$'\n'
tooltip+="${TOP_MONITOR}: workspace ${top_ws} (${top_windows} windows)"

emit "$group" "$tooltip" "$class"
