#!/bin/bash

# time range
SINCE_DAYS=2
DATE_FROM=$(date -d "$SINCE_DAYS days ago" "+%s")

echo "=== Explicit installs (pacman + yay) last $SINCE_DAYS days ==="

# merge explicit repo + explicit AUR
explicit_pkgs=$( (pacman -Qqe; yay -Qqe 2>/dev/null) | sort -u )

for pkg in $explicit_pkgs; do
  # try pacman first, fallback yay
  info=$(pacman -Qei "$pkg" 2>/dev/null || yay -Qei "$pkg" 2>/dev/null)

  install_date=$(echo "$info" | awk -F': ' '/Install Date/{print $2}')
  [[ -z "$install_date" ]] && continue

  ts=$(date -d "$install_date" "+%s")

  if (( ts >= DATE_FROM )); then
    echo "$pkg  |  $install_date"
  fi
done
