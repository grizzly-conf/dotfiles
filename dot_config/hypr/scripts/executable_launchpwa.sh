#!/usr/bin/env bash

# $1 = profile name
# $2 = URL

profile="$1"
url="$2"

# launch PWA
google-chrome-stable \
  --profile-directory="$profile" \
  --app="$url"

