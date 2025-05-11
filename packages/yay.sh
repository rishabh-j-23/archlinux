#!/usr/bin/env bash

BUILDS_DIR="$(pwd)/builds"
echo "BUILDING::packages::yay::[$BUILDS_DIR]"
sudo pacman -S --noconfirm --needed git base-devel && git clone https://aur.archlinux.org/yay.git $BUILDS_DIR/yay && cd $BUILDS_DIR/yay && makepkg -si
