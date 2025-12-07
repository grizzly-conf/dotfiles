#!/usr/bin/env bash
set -e

JSON="$HOME/.local/share/chezmoi/explicit-packages.json"
HOST="$(hostnamectl --static)"

missing=$(python3 - "$JSON" "$HOST" <<'EOF'
import json, sys, subprocess

f, host = sys.argv[1:]
data = json.load(open(f))

installed = subprocess.check_output(["pacman", "-Qq"], text=True).splitlines()

need = []
for p in data:
    a = p["allowed_hosts"]
    if a is True or host in a:
        if p["name"] not in installed:
            need.append(p["name"])

print(" ".join(need))
EOF
)

[ -n "$missing" ] && sudo pacman -S --needed $missing

