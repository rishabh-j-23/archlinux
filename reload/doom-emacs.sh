#!/usr/bin/env bash

# Source centralized logger
source "$(dirname "$0")/../lib/log.sh"

# Remove existing config
if [ -d "$HOME/.doom.d" ]; then
    log_action "REMOVING" "config at '$HOME/.doom.d'"
    rm -rf "$HOME/.doom.d"
fi

# Copy new config
log_action "COPYING" "'$PWD/configs/doom-emacs/.doom.d' to '$HOME/.doom.d'"
cp -r "$PWD/configs/doom-emacs/.doom.d" "$HOME/.doom.d" || { log_error "failed to copy config"; exit 1; }

# Sync doom emacs
log_action "SYNCING" "doom-emacs packages"
"$HOME/.emacs.d/bin/doom" sync || { log_error "doom sync failed"; exit 1; }

log_action "DONE" "doom-emacs config reloaded"
