#!/usr/bin/bash

BASE_DIR="${DEV_CONFIG:-$(pwd)}"
LOGGER="ERROR ::"
DRY_RUN=0

run_cmd() {
    if [[ $DRY_RUN -eq 1 ]]; then
        echo "[DRY RUN] $*"
    else
        eval "$@"
    fi
}

reload_package() {
    local package=$1
    local reload_script="$BASE_DIR/reload/$package.sh"
    if [[ -f "$reload_script" ]]; then
        echo "RELOADING::${package}::[$reload_script]"
        run_cmd "bash \"$reload_script\""
        return 0
    else
        echo "$LOGGER $reload_script not found"
        return 1
    fi
}

config_package() {
    local package=$1
    if [[ -z "$package" ]]; then
        echo "$LOGGER Missing package argument for config"
        return 1
    fi

    if [[ "$package" == "all" ]]; then
        run_cmd "\"$BASE_DIR/configs/all.sh\""
        return 0
    fi

    local config_path="$BASE_DIR/configs/$package"
    if [[ -d "$config_path" ]]; then
        local package_config_dir="$HOME/.config/$package"
        echo "removing::config at '$package_config_dir'"
        run_cmd "rm -rf \"$package_config_dir\""
        echo "copying::'$config_path' to '$package_config_dir'"
        run_cmd "cp -r \"$config_path\" \"$package_config_dir\""
        return 0
    else
        echo "$LOGGER $config_path not found"
        return 1
    fi
}

install_package() {
    local package=$1
    if [[ -z "$package" ]]; then
        echo "$LOGGER Missing package argument for install"
        return 1
    fi

    local install_script="$BASE_DIR/packages/$package.sh"
    if [[ -f "$install_script" ]]; then
        echo "INSTALLING::packages::$package"
        run_cmd "bash \"$install_script\""
        return 0
    else
        echo "$LOGGER $install_script not found"
        return 1
    fi
}

main() {
    # Check if first arg is --dry-run
    if [[ "$1" == "--dry-run" ]]; then
        DRY_RUN=1
        shift
    fi

    local action=$1
    local package=$2

    case "$action" in
        reload)
            reload_package "$package" || exit 1
            ;;
        configs)
            config_package "$package" || exit 1
            ;;
        install)
            install_package "$package" || exit 1
            ;;
        *)
            echo "$LOGGER use 'config' || 'install' || 'reload' as first arg"
            exit 1
            ;;
    esac
}

main "$@"
