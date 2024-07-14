#------------------- config.fish - sbx ----------------------

if not set -q __dotfiles_CODE_DIR
    set -g __dotfiles_CODE_DIR (realpath ~/www/iats/code)
end

if test -e $__dotfiles_PATH/bin
    fish_add_path ($__dotfiles_PATH/bin)
end

# Set initial directory
cd $__dotfiles_CODE_DIR
