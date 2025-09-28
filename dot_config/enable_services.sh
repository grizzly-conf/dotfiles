#!/usr/bin/env bash
set -euo pipefail

echo "[chezmoi] Enabling Hyprland session services..."

# Reload user daemon in case new services were added
systemctl --user daemon-reload

# Liste der Services
SERVICES=(waybar mako hypridle hyprlock)

# Enable & Start
for svc in "${SERVICES[@]}"; do
    echo "-> Enabling and starting ${svc}.service"
    systemctl --user enable "${svc}.service"
done

echo "[chezmoi] All Hyprland services enabled and started successfully!"
