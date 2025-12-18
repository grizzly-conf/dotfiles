#!/usr/bin/env bash
set -e

# Resolve script directory (so compose.yml is always referenced correctly)
SCRIPT_DIR="/opt/docker/open_interpreter/"

# Set WORKSPACE to current dir if not already set
export WORKSPACE="${WORKSPACE:-$(pwd)}"

# Run interpreter via docker-compose with environment variables expanded inside container
docker compose -f "$SCRIPT_DIR/docker-compose.yml" run --rm --entrypoint sh interpreter \
  -c 'interpreter -y --api_base="$API_BASE" --api_key="$API_KEY" "$@"' -- "$@"
