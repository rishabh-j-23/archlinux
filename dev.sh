#!/usr/bin/bash

ACTION=$1
PACKAGE=$2

LOGGER="ERROR ::"

if [[ "$ACTION" == "config" ]]; then
    if [[ -z "$PACKAGE" ]]; then
        echo "$LOGGER Missing package argument for config"
        exit 1
    fi

    if [[ $PACKAGE == "all" ]]; then
        $(pwd)/configs/all.sh
        exit 0
    fi

    CONFIG_PATH="$(pwd)/configs/$PACKAGE"
    if [[ -d "$CONFIG_PATH" ]]; then
        PACKAGE_CONFIG_DIR="$HOME/.config/$PACKAGE"
        echo "removing::config at '$PACKAGE_CONFIG_DIR'"
        rm -rf $PACKAGE_CONFIG_DIR
        echo "copying::'$CONFIG_PATH' to '$PACKAGE_CONFIG_DIR'"
        cp -r $CONFIG_PATH $PACKAGE_CONFIG_DIR
    else
        echo "$LOGGER $CONFIG_PATH not found"
        exit 1
    fi

elif [[ "$ACTION" == "install" ]]; then
    if [[ -z "$PACKAGE" ]]; then
        echo "$LOGGER Missing package argument for install"
        exit 1
    fi

    INSTALL_SCRIPT="$(pwd)/packages/$PACKAGE.sh"
    if [[ -f "$INSTALL_SCRIPT" ]]; then
        echo "INSTALLING::$INSTALL_SCRIPT"
        $INSTALL_SCRIPT
    else
        echo "$LOGGER $INSTALL_SCRIPT not found"
        exit 1
    fi
else
    echo "$LOGGER use 'config' || 'install' as first arg"
    exit 1
fi
