#!/bin/bash

while true; do
    # Get battery info
    BAT_INFO=$(acpi -b)
    PERCENT=$(echo "$BAT_INFO" | grep -P -o '[0-9]+(?=%)')
    STATUS=$(echo "$BAT_INFO" | grep -q "Charging" && echo "Charging" || echo "Discharging")

    # Default sleep (check every 15 minutes if high/charging)
    SLEEP_TIME=900

    if [ "$STATUS" = "Discharging" ]; then
        if [ "$PERCENT" -le 10 ]; then
            notify-send -u critical -i battery-caution "BATTERY CRITICAL" "Level: ${PERCENT}% - Plug in NOW!"
            SLEEP_TIME=120  # Check every 120 seconds
        elif [ "$PERCENT" -le 20 ]; then
            notify-send -u normal -i battery-low "Battery Low" "Level: ${PERCENT}%"
            SLEEP_TIME=300  # Check every 5 minutes
        elif [ "$PERCENT" -le 30 ]; then
            SLEEP_TIME=600 # Check every 10 minutes
        fi
    fi

    # If charging, reset to slow polling
    if [ "$STATUS" = "Charging" ]; then
        SLEEP_TIME=900
    fi

    sleep $SLEEP_TIME
done
