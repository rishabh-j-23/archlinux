#!/usr/bin/env bash

CONFIGS_DIR="$(pwd)/configs"
TARGET_DIR="$HOME/.config"

if [[ ! -d "$CONFIGS_DIR" ]]; then
    echo "ERROR :: $CONFIGS_DIR does not exist."
    exit 1
fi

echo "Applying all configurations from $CONFIGS_DIR to $TARGET_DIR"

for config in "$CONFIGS_DIR"/*; do
    config_name=$(basename "$config")
    target_path="$TARGET_DIR/$config_name"

    if [[ -e "$target_path" ]]; then
        echo "removing::[$config_name]::[$target_path]"
        rm -rf "$target_path"
    fi

    echo "copying::[$config_name]::[$target_path]"
    cp -r "$config" "$target_path"
done

echo "All configurations have been applied."
