#!/usr/bin/env bash
# ~/.config/hypr/scripts/suspend.sh

# Erst sperren
~/.config/hypr/scripts/lock.sh

# Kurze Pause, damit der Lockscreen erscheint
sleep 0.1

# Suspend
systemctl suspend
