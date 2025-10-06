#!/usr/bin/env bash
# Menü: Lock / Suspend / Reboot / Shutdown
CHOICE=$(echo -e "Lock\nSuspend\nReboot\nShutdown" | rofi -dmenu -i -p "Power Menu")

case "$CHOICE" in
    Lock)
        ~/.config/hypr/scripts/lock.sh
        ;;
    Suspend)
        ~/.config/hypr/scripts/suspend.sh
        ;;
    Reboot)
        systemctl reboot
        ;;
    Shutdown)
        systemctl poweroff
        ;;
esac
