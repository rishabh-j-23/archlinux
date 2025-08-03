#!/usr/bin/env bash

# Centralized logging functions for package manager scripts
# Usage: source this file in your scripts

# Log an action (e.g., INSTALLING::, COPYING::)
log_action() {
  local action="$1"
  shift
  echo "${action}::$*"
}

# Log an error (always prefixed with ERROR ::)
log_error() {
  echo "ERROR::$*" >&2
}

# Optionally, log a success message
log_success() {
  local action="$1"
  shift
  echo "${action}::SUCCESS $*"
}

# Optionally, log a warning
log_warning() {
  echo "WARNING::$*" >&2
}

# Example usage in scripts:
#   log_action "INSTALLING" "Doom Emacs..."
#   log_error "Failed to install Doom Emacs"
#   log_success "SYNCING" "Packages are up to date"
#   log_warning "This is a warning message"
