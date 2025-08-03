#!/usr/bin/env bash

# Source centralized logger
source "$(dirname "$0")/../lib/log.sh"

# install doom emacs if not present
if [ ! -d "$HOME/.emacs.d" ]; then
    log_action "INSTALLING" "doom-emacs::cloning repo to '$HOME/.emacs.d'"
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$HOME/.emacs.d" || { log_error "failed to clone doomemacs"; exit 1; }
fi

# ensure doom binary is available
export PATH="$HOME/.emacs.d/bin:$PATH"

# link/copy your config
if [ -d "$HOME/.doom.d" ]; then
    log_action "REMOVING" "config at '$HOME/.doom.d'"
    rm -rf "$HOME/.doom.d"
fi

log_action "COPYING" "'$PWD/configs/doom-emacs/.doom.d' to '$HOME/.doom.d'"
cp -r "$PWD/configs/doom-emacs/.doom.d" "$HOME/.doom.d" || { log_error "failed to copy config"; exit 1; }

# install doom emacs (if not already installed)
if [ ! -f "$HOME/.emacs.d/bin/doom" ]; then
    log_action "INSTALLING" "doom-emacs::running doom install"
    "$HOME/.emacs.d/bin/doom" install --no-config || { log_error "doom install failed"; exit 1; }
fi

# sync and upgrade doom packages
log_action "SYNCING" "doom-emacs packages"
"$HOME/.emacs.d/bin/doom" sync || { log_error "doom sync failed"; exit 1; }
log_action "UPGRADING" "doom-emacs packages"
"$HOME/.emacs.d/bin/doom" upgrade || { log_error "doom upgrade failed"; exit 1; }

log_action "DONE" "doom-emacs setup complete"
