#!/usr/bin/env fish

# Parse command line arguments
set dry_run false
if test (count $argv) -gt 0; and test $argv[1] = "--dry-run"
    set dry_run true
end

# Define the source and destination directories
set CHEZMOI_DIR ~/.local/share/chezmoi
# set SOURCE_DIR ~/.config
set SOURCE_DIR $CHEZMOI_DIR/private_dot_config
set SYMLINK_DIR $CHEZMOI_DIR/symlinked

# Initialize an empty array to keep track of processed directories
set -g processed_dirs

# Function to create directory if it doesn't exist
function create_directory
    set dir (string trim -r -c "/" $argv[1])
    if not contains -- $dir $processed_dirs
        if not test -d $dir
            if $dry_run
                echo "Would create directory: $dir"
            else
                mkdir -p $dir
                echo "Created directory: $dir"
            end
        end
        set -a processed_dirs $dir
    end
end

# Function to create symlink and template
function create_symlink
    set item $argv[1]
    set relative_path (string replace $SOURCE_DIR "" $item)
    set dest_path $SYMLINK_DIR$relative_path

    # Remove "private_" from the destination path
    set dest_path (string replace -a "/private_" "/" $dest_path)
    set dest_path (string replace -r "^private_" "" $dest_path)

    # Construct the correct template path
    set template_relative_path (string replace -r '^/' '' $relative_path)
    set template_path $CHEZMOI_DIR/private_dot_config/$template_relative_path

    if test -f $item
        # Handle file
        set template_file (dirname $template_path)/symlink_(basename $item | string replace -r "^private_" "").tmpl

        create_directory (dirname $dest_path)
        create_directory (dirname $template_file)

        if $dry_run
            echo "Would move file: $item to $dest_path"
            echo "Would create template file: $template_file"
            set template_content "{{ .chezmoi.sourceDir }}/symlinked$relative_path"
            set template_content (string replace -a "/private_" "/" $template_content)
            set template_content (string replace -r "^private_" "" $template_content)
            echo "Template content: $template_content"
        else
            # Copy the file to the symlinked directory
            mv $item $dest_path

            echo "Moved $item to $dest_path"

            # Create the template file
            set template_content "{{ .chezmoi.sourceDir }}/symlinked$relative_path"
            set template_content (string replace -a "/private_" "/" $template_content)
            set template_content (string replace -r "^private_" "" $template_content)
            echo -n $template_content > $template_file

            echo "Created symlink for file: $item"
        end
    else if test -d $item
        # Handle directory
        create_directory $dest_path
        create_directory $template_path

        # Process all items in the directory
        for sub_item in $item/*
            create_symlink $sub_item
        end
    end
end

# Use fzf to select files and directories
set selected_items (fd . $SOURCE_DIR --exclude "private_fish" --exclude '*.tmpl' | fzf -m)

# Process each selected item
for item in $selected_items
    create_symlink $item
end

if $dry_run
    echo "Dry run completed. No changes were made."
end
