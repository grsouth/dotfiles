#!/usr/bin/env bash
set -euo pipefail

MAIN_MONITOR="DP-1"
TOP_MONITOR="DP-2"

focused_monitor="$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')"

case "${1:-}" in
  1)
    MAIN_WS=1
    TOP_WS=4
    ;;
  2)
    MAIN_WS=2
    TOP_WS=5
    ;;
  3)
    MAIN_WS=3
    TOP_WS=6
    ;;
  *)
    echo "Usage: $0 [1|2|3]"
    exit 1
    ;;
esac

hyprctl --batch "\
dispatch focusmonitor $MAIN_MONITOR ; \
dispatch focusworkspaceoncurrentmonitor $MAIN_WS ; \
dispatch focusmonitor $TOP_MONITOR ; \
dispatch focusworkspaceoncurrentmonitor $TOP_WS ; \
dispatch focusmonitor $focused_monitor"

pkill -RTMIN+8 waybar 2>/dev/null || true
