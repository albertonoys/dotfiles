function ubuntuUpdate --description "Update Ubuntu packages and perform clean up"
    # Check for gum installation
    if not type -q gum
        echo "gum could not be found, please install gum to proceed."
        exit 1
    end

    # Update the package list
    gum style --foreground 212 --bold "Updating package list..."
    sudo apt -qq update

    # List upgradable packages
    gum style --foreground 212 --bold "Listing upgradable packages..."
    apt list --upgradable

    # Upgrade all upgradable packages
    gum style --foreground 212 --bold "Upgrading packages..."
    sudo apt upgrade -yqq

    # Refresh snap packages if snap is installed
    if type -q snap
        gum style --foreground 212 --bold "Refreshing snap packages..."
        sudo snap refresh
    else
        gum style --foreground 203 --bold "Snap is not installed, skipping..."
    end

    # Update flatpak packages if flatpak is installed
    if type -q flatpak
        gum style --foreground 212 --bold "Updating flatpak packages..."
        flatpak update --assumeyes --noninteractive

        # Remove unused flatpak packages
        gum style --foreground 212 --bold "Removing unused flatpak packages..."
        flatpak uninstall --unused --assumeyes --noninteractive
    else
        gum style --foreground 203 --bold "Flatpak is not installed, skipping..."
    end

    # Remove unused packages and dependencies
    gum style --foreground 212 --bold "Removing unused packages and dependencies..."
    sudo apt autoremove --purge -yqq

    gum style --foreground 212 --bold "System update and cleanup complete!"
end
