function ubuntuUpdate --description "Update Ubuntu packages and perform clean up"
    # Define update steps
    set -l update_steps \
        "Updating package list" "sudo apt -qq update" \
        "Listing upgradable packages" "apt list --upgradable" \
        "Upgrading packages" "sudo apt upgrade -yqq" \
        "Removing unused packages and dependencies" "sudo apt autoremove --purge -yqq"

    # Run update steps
    for i in (seq 1 2 (count $update_steps))
        info $update_steps[$i]
        eval $update_steps[(math $i + 1)]
    end

    # Handle snap packages
    if is_installed snap
        info "Refreshing snap packages..."
        sudo snap refresh
    else
        error "Snap is not installed, skipping..."
    end

    # Handle flatpak packages
    if is_installed flatpak
        info "Updating flatpak packages..."
        flatpak update --assumeyes --noninteractive
        info "Removing unused flatpak packages..."
        flatpak uninstall --unused --assumeyes --noninteractive
    else
        error "Flatpak is not installed, skipping..."
    end

    # Handle brew packages
    if is_installed brew
        info "Updating brew packages..."
        brew upgrade
    else
        error "brew is not installed, skipping..."
    end

    success "System update and cleanup complete!" true
end

