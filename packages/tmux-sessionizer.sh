#!/bin/bash
source $(pwd)/lib/log.sh
log_action "INSTALLING" "tmux-sessionizer"

cd $(pwd)/builds/
if [ -d "tmux-sessionizer" ]; then
    log_action "REMOVING" "tmux-sessionizer"
    rm -rf tmux-sessionizer
fi

git_url="https://github.com/ThePrimeagen/tmux-sessionizer"

log_action "CLONING" "$git_url"
git clone "$git_url" ./tmux-sessionizer

log_action "MOVING" "tmux-sessionizer to '$HOME/.local/bin'"
cd tmux-sessionizer
mv tmux-sessionizer ~/.local/bin
log_success "tmux-sessionizer installed"
log_action "[ACTION REQUIRED]" "source rc file"
