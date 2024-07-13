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

execute_template() {
    local chezmoi_source_dir

    local template_name="$1.tmpl"
    chezmoi_source_dir=$(chezmoi source-path)
    local template_path="$chezmoi_source_dir/.chezmoitemplates/$template_name"

    if [ ! -f "$template_path" ]; then
        echo "Error: Template file $template_name not found in .chezmoitemplates directory."
        return 1
    fi

    # Execute the template content as an inline template
    chezmoi execute-template < "$template_path" | bash
}
