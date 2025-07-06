#!/usr/bin/env bash

./dev.sh configs hypr 2>/dev/null
hyprctl reload 2>/dev/null

# Flush extra stdin (prevents enter key bleed)
read -t 0.1 -n 10000 || true
