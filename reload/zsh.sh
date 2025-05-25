#!/usr/bin/env bash

ZSH_CONFIG_DIR="$(pwd)/configs/zsh"

if [[ -f $HOME/.zshrc ]]; then
    echo "REMOVING::packages::zsh::[.zshrc, .oh-my-zsh, .zsh_aliases] from [$HOME]"
    rm -f "$HOME/.zshrc"
    rm -f "$HOME/.zsh_aliases"
    rm -rf "$HOME/.oh-my-zsh/"
fi

echo "COPYING::configs::zsh::to [$HOME]"
cp "$ZSH_CONFIG_DIR/.zshrc" "$HOME/.zshrc"
cp "$ZSH_CONFIG_DIR/.zsh_aliases" "$HOME/.zsh_aliases"
cp -r "$ZSH_CONFIG_DIR/.oh-my-zsh" "$HOME"
