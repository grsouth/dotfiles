#!/usr/bin/env bash

set -u

mode=${1:-all}

json_escape() {
  local s=${1//\\/\\\\}
  s=${s//\"/\\\"}
  s=${s//$'\n'/\\n}
  printf '%s' "$s"
}

emit() {
  local text=$1 tooltip=$2 class=$3 percentage=${4:-0}

  printf '{"text":"%s","tooltip":"%s","class":"%s","percentage":%d}\n' \
    "$(json_escape "$text")" \
    "$(json_escape "$tooltip")" \
    "$(json_escape "$class")" \
    "$percentage"
}

find_amd_gpu() {
  local dev vendor

  for dev in /sys/class/drm/card*/device; do
    [[ -e "$dev" ]] || continue
    vendor="$dev/vendor"

    [[ -r "$vendor" ]] || continue
    [[ "$(tr '[:upper:]' '[:lower:]' < "$vendor")" == "0x1002" ]] || continue
    [[ -r "$dev/gpu_busy_percent" ]] || continue
    [[ -r "$dev/mem_info_vram_used" ]] || continue
    [[ -r "$dev/mem_info_vram_total" ]] || continue

    printf '%s\n' "$dev"
    return 0
  done

  return 1
}

format_gib() {
  local bytes=$1
  local gib=$((1024 * 1024 * 1024))
  local tenths=$(((bytes * 10 + gib / 2) / gib))
  local whole=$((tenths / 10))
  local frac=$((tenths % 10))

  if (( frac == 0 )); then
    printf '%d' "$whole"
  else
    printf '%d.%d' "$whole" "$frac"
  fi
}

gpu_path=$(find_amd_gpu) || {
  emit "GPU N/A" "No AMDGPU sysfs device found" "error" 0
  exit 0
}

gpu_usage=$(<"$gpu_path/gpu_busy_percent")
vram_used=$(<"$gpu_path/mem_info_vram_used")
vram_total=$(<"$gpu_path/mem_info_vram_total")

if [[ ! "$gpu_usage" =~ ^[0-9]+$ || ! "$vram_used" =~ ^[0-9]+$ || ! "$vram_total" =~ ^[0-9]+$ || "$vram_total" -eq 0 ]]; then
  emit "GPU N/A" "AMDGPU sysfs metrics are unavailable" "error" 0
  exit 0
fi

vram_percent=$(((vram_used * 100 + vram_total / 2) / vram_total))
vram_used_gib=$(format_gib "$vram_used")
vram_total_gib=$(format_gib "$vram_total")

gpu_class="normal"
if (( gpu_usage >= 90 )); then
  gpu_class="critical"
elif (( gpu_usage >= 70 )); then
  gpu_class="warning"
fi

vram_class="normal"
if (( vram_percent >= 90 )); then
  vram_class="critical"
elif (( vram_percent >= 75 )); then
  vram_class="warning"
fi

tooltip="GPU Usage: ${gpu_usage}%"
tooltip+=$'\n'
tooltip+="VRAM: ${vram_used_gib} GiB / ${vram_total_gib} GiB (${vram_percent}%)"

case "$mode" in
  gpu)
    emit "GPU ${gpu_usage}%" "$tooltip" "$gpu_class" "$gpu_usage"
    ;;
  vram)
    emit "VRAM ${vram_percent}%" "$tooltip" "$vram_class" "$vram_percent"
    ;;
  *)
    class="normal"
    if [[ "$gpu_class" == "critical" || "$vram_class" == "critical" ]]; then
      class="critical"
    elif [[ "$gpu_class" == "warning" || "$vram_class" == "warning" ]]; then
      class="warning"
    fi

    emit "GPU ${gpu_usage}% VRAM ${vram_used_gib}/${vram_total_gib}G" "$tooltip" "$class" "$gpu_usage"
    ;;
esac
