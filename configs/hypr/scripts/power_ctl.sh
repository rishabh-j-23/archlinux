#!/usr/bin/env bash

# Declare options in an array
options=(
  "l  lock"
  "lo logout"
  "r  suspend"
  "r  reboot"
  "uu shutdown"
)

# Join array elements with newlines
menu="$(printf "%s\n" "${options[@]}")"

# Show rofi-wayland menu
choice=$(echo "$menu" | rofi -dmenu -p "power-menu")

echo "cmd: $choice"

# Match selection
case "$choice" in
  *shutdown)
    systemctl poweroff
    ;;
  *reboot)
    systemctl reboot
    ;;
  *suspend)
    systemctl suspend
    ;;
  *lock)
    command -v hyprlock &>/dev/null && hyprlock \
      || echo "No lock tool found"
    ;;
  *logout)
    command -v hyprctl &>/dev/null && hyprctl dispatch exit \
      || loginctl terminate-user "$USER"
    ;;
  *)
    echo "No valid option selected"
    ;;
esac
