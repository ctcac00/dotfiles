#!/usr/bin/env sh

LAYOUT=$(hyprctl getoption general:layout | grep -o dwindle)
if [ "$LAYOUT" = "dwindle" ]; then
  hyprctl keyword general:layout master
  notify-send -e -u low "Layout mode" "Master"
else
  hyprctl keyword general:layout dwindle
  notify-send -e -u low "Layout mode" "Dwindle"
fi
