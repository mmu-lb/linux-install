#!/bin/env bash

WP_DIR="$HOME/wallpaper"
WP_CONF="$HOME/linux-dots/sway/conf.d/15-wallpaper"
WP_STYLE="$HOME/linux-dots/custom-scripts/wallpaper-picker/config.rasi"

SELECTED=$(command ls -1 "$WP_DIR" | while read -r img; do
    printf "%s\0icon\x1f%s/%s\n" "$img" "$WP_DIR" "$img"
done | rofi -dmenu -i -p "Wallpaper Picker" -show-icons -theme "$WP_STYLE")

if [[ -n "$SELECTED" ]]; then
    FULL_PATH="$WP_DIR/$SELECTED"
    if [[ "$XDG_CURRENT_DESKTOP" == "sway" ]]; then
        echo "output * bg \"$FULL_PATH\" fill" > "$WP_CONF"
        swaymsg reload
    else
        awww img "$FULL_PATH"
    fi
fi
