#!/bin/bash

options="   Shutdown\n   Reboot\n   Suspend\n   Lock"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power" -theme-str 'window { width: 50%; } listview { columns: 4; lines: 1; }')

case "$chosen" in
    "   Shutdown")
        systemctl poweroff
        ;;
    "   Reboot")
        systemctl reboot
        ;;
    "   Suspend")
        systemctl suspend
        ;;
    "   Lock")
        hyprlock
        ;;
esac
