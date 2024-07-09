#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if fzf is already installed
if [ -d "$HOME/.fzf" ]; then
    echo "fzf is already installed. Skipping installation."
    exit 0
fi

# Clone fzf repository
git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"

# Run fzf install script
"$HOME/.fzf/install" --all

echo "fzf has been successfully installed."
