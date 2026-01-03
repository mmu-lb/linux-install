#!/usr/bin/env bash

# Options
OPTIONS="Shutdown\nReboot\nLogout\nCancel"

# Show Rofi menu
CHOICE=$(echo -e $OPTIONS | rofi -dmenu -config ~/linux-install/custom-scripts/powermenu/config.rasi -p "Power Menu:")

# Act on choice
case "$CHOICE" in
    Shutdown)
        systemctl poweroff
        ;;
    Reboot)
        systemctl reboot
        ;;
    Logout)
        swaymsg exit
        ;;
    Cancel|"")
        exit 0
        ;;
esac
