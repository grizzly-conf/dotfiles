#!/usr/bin/env bash
set -e

JSON="$HOME/.local/share/chezmoi/pkglist.json"
HOST="$(hostnamectl --static)"

[ -f "$JSON" ] || echo "[]" > "$JSON"

pkgs=$(pacman -Qqe)

tmp="$(mktemp)"
python3 - "$JSON" "$HOST" <<EOF
import json, sys, datetime, subprocess

f, host = sys.argv[1:]
today = datetime.date.today().isoformat()

data = json.load(open(f))
names = {p["name"] for p in data}

# pacman packages
pkgs = """$pkgs""".split()

for pkg in pkgs:
    if pkg not in names:
        data.append({
            "name": pkg,
            "allowed_hosts": [host],
            "installed": today
        })

json.dump(data, open(f, "w"), indent=2)
EOF

mv "$tmp" "$JSON"

