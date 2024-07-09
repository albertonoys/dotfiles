#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

FZF_DIR="$HOME/.fzf"
FZF_REPO="https://github.com/junegunn/fzf.git"

get_latest_version() {
    git ls-remote --tags --refs "$FZF_REPO" |
    cut -d/ -f3 |
    sort -V |
    tail -n1
}

get_installed_version() {
    if [ -d "$FZF_DIR" ]; then
        (cd "$FZF_DIR" && git describe --tags --abbrev=0)
    else
        echo "Not installed"
    fi
}

install_or_update_fzf() {
    local latest_version=$(get_latest_version)
    local installed_version=$(get_installed_version)

    if [ "$installed_version" = "Not installed" ]; then
        echo "fzf is not installed. Installing now..."
        git clone --depth 1 "$FZF_REPO" "$FZF_DIR"
        "$FZF_DIR/install" --all
        echo "fzf has been successfully installed."
    elif [ "$installed_version" != "$latest_version" ]; then
        echo "Updating fzf from $installed_version to $latest_version"
        (cd "$FZF_DIR" && git fetch && git checkout "$latest_version")
        "$FZF_DIR/install" --all
        echo "fzf has been successfully updated."
    else
        echo "fzf is already up to date (version $installed_version)."
    fi
}

install_or_update_fzf
