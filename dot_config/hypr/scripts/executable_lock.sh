#!/usr/bin/env bash
# ~/.config/hypr/scripts/lock.sh

# Start lockscreen (hyprlock)
if command -v hyprlock >/dev/null 2>&1; then
    hyprlock &
else
    echo "Error: hyprlock not installed"
    exit 1
fi

# Optional: backup lock via loginctl
loginctl lock-sessions
