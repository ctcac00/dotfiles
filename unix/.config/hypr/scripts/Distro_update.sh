#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Simple bash script to check and will try to update your system

# Check for required tools (kitty)
if ! command -v kitty &>/dev/null; then
  notify-send "Need Kitty:" "Kitty terminal not found. Please install Kitty terminal."
  exit 1
fi

# Detect distribution and update accordingly
if command -v paru &>/dev/null || command -v yay &>/dev/null; then
  # Arch-based
  if command -v paru &>/dev/null; then
    kitty -T update paru -Syu
    notify-send -u low 'Arch-based system' 'has been updated.'
  else
    kitty -T update yay -Syu
    notify-send -u low 'Arch-based system' 'has been updated.'
  fi
else
  # Unsupported distro
  notify-send -u critical "Unsupported system" "This script does not support your distribution."
  exit 1
fi
