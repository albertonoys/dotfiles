#!/bin/bash

# Ensure the binary directory exists
mkdir -p "$HOME/bin"

# Add the binary directory to PATH if it's not already there
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo 'export PATH=$HOME/bin:$PATH' >> "$HOME/.bashrc"
    export PATH=$HOME/bin:$PATH
fi

# Ensure chezmoi is in the PATH
if ! command -v chezmoi &> /dev/null; then
    if [ -f "$HOME/bin/chezmoi" ]; then
        chmod +x "$HOME/bin/chezmoi"
    else
        echo "Error: chezmoi binary not found in $HOME/bin"
        exit 1
    fi
fi
