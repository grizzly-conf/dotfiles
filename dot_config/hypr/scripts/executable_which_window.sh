#!/usr/bin/env bash

# pick coordinates
coords=$(slurp -p)
x=$(echo "$coords" | cut -d',' -f1)
y=$(echo "$coords" | cut -d',' -f2)

# find window under pointer
pid=$(hyprctl activewindow -j | jq -r '.pid')


# resolve executable
exe=$(ps -p "$pid" -o comm=)

# copy to clipboard
echo -n "$exe" | wl-copy

# notify
notify-send "Window executable" "$exe"
