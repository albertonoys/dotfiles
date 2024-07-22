#!/bin/bash

check_hosttype() {
    local package_name=$1
    local hosttype=$2
    local current_hosttype=$3

    if [ -z "$hosttype" ] || [[ " ${hosttype[@]} " =~ " $current_hosttype " ]]; then
        echo "Would install $package_name on $current_hosttype environment."
        return 0  # Install the package
    else
        echo "Skipping $package_name installation: not applicable for $current_hosttype environment."
        return 1  # Skip the package
    fi
}

# Only export the function if this script is being sourced
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    export -f check_hosttype
fi
