#!/usr/bin/env sh

rofi -theme ~/.config/rofi/config.rasi -run-command "uwsm app -- {cmd}" "$@"
