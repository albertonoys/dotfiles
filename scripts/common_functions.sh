#!/bin/bash

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
