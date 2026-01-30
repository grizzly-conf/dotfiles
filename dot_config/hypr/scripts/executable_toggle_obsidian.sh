#!/usr/bin/env bash

# Prüfen, ob special:obsidian bereits sichtbar ist
if hyprctl activeworkspace -j | jq -e '.name == "special:obsidian"' > /dev/null 2>&1; then
    # Workspace ist aktiv -> nur schließen
    hyprctl dispatch togglespecialworkspace obsidian
    exit 0
fi

case "$1" in
    daily)
        xdg-open "obsidian://daily?vault=grizzlyweb"
        ;;
    vault)
        xdg-open "obsidian://open?vault=grizzlyweb"
        ;;
esac

hyprctl dispatch togglespecialworkspace obsidian
