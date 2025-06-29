#!/usr/bin/env bash

./dev.sh configs waybar
sleep 1
pkill waybar
waybar &
