#!/usr/bin/env bash
set -e

JSON="$HOME/.local/share/chezmoi/pkglist.json"
HOST="$(hostnamectl --static)"

# ensure json exists
[ -f "$JSON" ] || echo "[]" > "$JSON"

# run paru
paru "$@"

# detect installed package (simple version: last argument)
PKG="$1"

# append/update json
tmp="$(mktemp)"
python3 - "$JSON" "$PKG" "$HOST" <<'EOF'
import json, sys, datetime

f, pkg, host = sys.argv[1:]
today = datetime.date.today().isoformat()

data = json.load(open(f))

# update or add
for p in data:
    if p["name"] == pkg:
        if p["allowed_hosts"] is not True:
            if host not in p["allowed_hosts"]:
                p["allowed_hosts"].append(host)
        break
else:
    data.append({
        "name": pkg,
        "allowed_hosts": [host],
        "installed": today
    })

json.dump(data, open(f, "w"), indent=2)
EOF

mv "$tmp" "$JSON"

