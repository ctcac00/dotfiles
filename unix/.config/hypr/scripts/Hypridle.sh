#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# This is for custom version of waybar idle_inhibitor which activates / deactivates hypridle instead

SERVICE="hypridle.service"

is_running() {
  # Check if hypridle.service is active via systemctl
  systemctl --user is-active "$SERVICE" >/dev/null 2>&1
}

if [[ "$1" == "status" ]]; then
  if is_running; then
    echo '{"text": "RUNNING", "class": "active", "tooltip": "idle_inhibitor NOT ACTIVE
Left Click: Deactivate
Right Click: Lock Screen"}'
  else
    echo '{"text": "NOT RUNNING", "class": "notactive", "tooltip": "idle_inhibitor is ACTIVE
Left Click: Activate
Right Click: Lock Screen"}'
  fi
elif [[ "$1" == "toggle" ]]; then
  # Toggle hypridle.service on and off via systemctl
  if is_running; then
    systemctl --user stop "$SERVICE"
  else
    systemctl --user start "$SERVICE"
  fi
else
  echo "Usage: $0 {status|toggle}"
  exit 1
fi

