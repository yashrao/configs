#!/bin/bash

# Thresholds for notifications
LOW_THRESHOLD=20   # Battery percentage for "low" warning
CRIT_THRESHOLD=10  # Battery percentage for "critical" warning

# Infinite loop to monitor battery
while true; do
    # Get battery percentage and status using acpi
    BATTERY=$(acpi -b | grep -o '[0-9]\+%' | tr -d '%')
    STATUS=$(acpi -b | grep -o 'Charging\|Discharging\|Full')

    # Check if battery is discharging and below thresholds
    if [ "$STATUS" = "Discharging" ]; then
        if [ "$BATTERY" -le "$CRIT_THRESHOLD" ]; then
            notify-send -u critical "Battery Critical!" "Battery at ${BATTERY}%. Plug in now!"
        elif [ "$BATTERY" -le "$LOW_THRESHOLD" ]; then
            notify-send -u normal "Battery Low" "Battery at ${BATTERY}%. Consider plugging in."
        fi
    fi

    sleep 60
done
