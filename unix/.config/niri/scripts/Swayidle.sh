#!/bin/bash

# Swayidle toggle script for waybar
# Controls swayidle process (start/stop/status)

MODE="${1:-status}"

is_running() {
    pgrep -x swayidle > /dev/null
}

get_status() {
    if is_running; then
        echo '{"text": "󱫗", "class": "active", "tooltip": "Idle enabled\nClick to disable"}'
    else
        echo '{"text": "󱫗", "class": "notactive", "tooltip": "Idle disabled\nClick to enable"}'
    fi
}

toggle() {
    if is_running; then
        pkill -x swayidle
        notify-send "Swayidle" "Idle management disabled" -i system-suspend-inhibited
    else
        swayidle -w &
        notify-send "Swayidle" "Idle management enabled" -i system-suspend
    fi
}

case "$MODE" in
    status)
        get_status
        ;;
    toggle)
        toggle
        ;;
    *)
        echo "Usage: $0 {status|toggle}"
        exit 1
        ;;
esac
