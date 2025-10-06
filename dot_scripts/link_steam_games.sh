#!/bin/bash

TARGET=~/SteamGames
BASE=~/.local/share/Steam/steamapps/compatdata

mkdir -p "$TARGET/data"

# Link zu installierten Apps
if [ ! -e "$TARGET/apps" ]; then
    ln -s ~/.local/share/Steam/steamapps/common "$TARGET/apps"
fi

# Blacklist von Ordnern, die wir ignorieren wollen
IGNORE=("Microsoft" "Windows" "Temp" "Steamworks Shared" "SteamLinuxRuntime" "Proton - Experimental")

for appdata in Local LocalLow Roaming; do
    find "$BASE" -type d -path "*/AppData/$appdata" | while read -r adir; do
        steamid=$(echo "$adir" | sed -n 's|.*/compatdata/\([0-9]\+\)/.*|\1|p')

        # Nur direkte Unterordner (keine tieferen)
        for sub in "$adir"/*; do
            [ -d "$sub" ] || continue
            gamefolder=$(basename "$sub")

            # Blacklist überspringen
            skip=0
            for bad in "${IGNORE[@]}"; do
                [[ "$gamefolder" == "$bad" ]] && skip=1
            done
            [ $skip -eq 1 ] && continue

            linkname="${gamefolder}_${steamid}"
            if [ ! -e "$TARGET/data/$linkname" ]; then
                echo "Erstelle Link: $TARGET/data/$linkname -> $sub"
                ln -s "$sub" "$TARGET/data/$linkname"
            fi
        done
    done
done
