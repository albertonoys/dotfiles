function ubuntuUpdate --description "Update Ubuntu packages and perform clean up"
    # Run update steps
    if is_installed nala
        info "Upgrading packages..."
        sudo nala upgrade --assume-yes
    else
        info "Getting upgradable packages..."
        sudo apt -qq update && apt list --upgradable
        info "Upgrading packages and removing unused..."
        sudo apt upgrade -yqq && sudo apt autoremove --purge -yqq
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
