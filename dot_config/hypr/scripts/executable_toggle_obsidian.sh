#!/usr/bin/env bash

case "$1" in
    daily)
        xdg-open "obsidian://daily?vault=grizzlyweb"
        ;;
    vault)
        xdg-open "obsidian://open?vault=grizzlyweb"
        ;;
esac

hyprctl dispatch togglespecialworkspace obsidian
