#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e
set -u

FZF_DIR="$HOME/.fzf"
FZF_REPO="https://github.com/junegunn/fzf.git"

# Get the latest version of fzf from the repository
get_latest_version() {
    git ls-remote --tags --refs "$FZF_REPO" 2>/dev/null |
    cut -d/ -f3 |
    sort -V |
    tail -n1
}

get_installed_version() {
    if [ -d "$FZF_DIR" ]; then
        (cd "$FZF_DIR" && git describe --tags --abbrev=0 2>/dev/null) || echo "Unknown"
    else
        echo "Not installed"
    fi
}

install_or_update_fzf() {
    local latest_version
    local installed_version

    latest_version=$(get_latest_version)
    installed_version=$(get_installed_version)


    if [ "$installed_version" = "Not installed" ]; then
        echo "Installing fzf..."
        git clone --quiet --depth 1 "$FZF_REPO" "$FZF_DIR" >/dev/null 2>&1
        "$FZF_DIR/install" --all >/dev/null 2>&1
        echo "fzf has been successfully installed (version $latest_version)."
    elif [ "$installed_version" != "$latest_version" ]; then
        echo "Updating fzf from $installed_version to $latest_version..."
        (cd "$FZF_DIR" && git fetch --quiet && git checkout --quiet "$latest_version") >/dev/null 2>&1
        "$FZF_DIR/install" --all >/dev/null 2>&1
        echo "fzf has been successfully updated to version $latest_version."
    else
        echo "fzf is already up to date (version $installed_version)."
    fi
}

# Call the install_or_update_fzf function
install_or_update_fzf
