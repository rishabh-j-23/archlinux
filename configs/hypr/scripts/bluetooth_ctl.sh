#!/usr/bin/env bash

# Declare options in an array
options=(
  "pon  power on bluetooth"
  "pof  power off bluetooth"
  "con  connect bluetooth devices"
  "cona connect all bluetooth devices"
  "dis  disconnect bluetooth devices"
  "gui  bluetooth settings gui"
)

# Show rofi-wayland menu
choice=$(printf "%s\n" "${options[@]}" | rofi -dmenu -p "bluetooth")

# Extract short code from selected option
code=$(echo "$choice" | awk '{print $1}')

# Match selection
case "$code" in
  *pon)
    bluetoothctl power on
    ;;
  *pof)
    bluetoothctl power off
    ;;
  *con)
    bluetoothctl devices | rofi -dmenu -p "connect" | awk '{print $2}' | xargs -r bluetoothctl connect
    ;;
  *dis)
    bluetoothctl devices | rofi -dmenu -p "disconnect" | awk '{print $2}' | xargs -r bluetoothctl disconnect
    ;;
  *gui)
    blueman-manager &
    ;;
  *cona)
    timeout 5 bash -c '
      bluetoothctl devices | awk "{print \$2}" | while read -r mac; do
        bluetoothctl connect "$mac"
      done
    '
    ;;
  *)
    echo "No valid option selected"
    ;;
esac
