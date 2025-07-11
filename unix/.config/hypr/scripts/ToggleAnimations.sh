#!/usr/bin/env sh

HYPRANIMATIONS=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRANIMATIONS" = 1 ]; then
  hyprctl keyword animations:enabled 0
  notify-send -e -u low "Animations:" "Disabled"
else
  hyprctl keyword animations:enabled 1
  notify-send -e -u low "Animations:" "Enabled"
fi
