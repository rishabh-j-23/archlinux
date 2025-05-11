#!/bin/bash
mkdir -p "$HOME/Pictures/Screenshots"
FILE="$HOME/Pictures/Screenshots/screenshot-$(date +%F_%H-%M-%S).png"
grim -g "$(slurp)" "$FILE" && notify-send "Screenshot saved" "$FILE" --icon="$FILE"
