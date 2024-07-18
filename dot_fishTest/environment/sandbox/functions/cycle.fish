function check_if_vpn_or_exit
    if ping -c2 -W1 gitlab.xcade.net | grep "100% packet loss" > /dev/null 2>&1
        substep_info "You need to be connected to the VPN"
        return 1
    end
end

function cycle --description 'Display the current version number for each main branch in IATS'
    if check_if_vpn_or_exit
        set cwd (pwd)
        cd $__dotfiles_CODE_DIR
        git fetch -q origin master alpha beta stable

        set stable_version (git show origin/stable:versioninfo)
        set beta_version (git show origin/beta:versioninfo)
        set alpha_version (git show origin/alpha:versioninfo)
        set master_version (git show origin/master:versioninfo)
        echo -e '\033[0;32m'"Master " '\033[1;32m' $master_version
        echo -e '\033[0;32m'"Alpha  " '\033[1;32m' $alpha_version
        echo -e '\033[0;32m'"Beta   " '\033[1;32m' $beta_version
        echo -e '\033[0;32m'"Stable " '\033[1;32m' $stable_version'\033[0m'
        cd $cwd
    end
end
