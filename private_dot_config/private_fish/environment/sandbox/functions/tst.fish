function tst --description 'Executes UI and UNITUI tests based on fuzzyfinder'

#   Import colors
    . ~/.config/fish/colors.fish

    set cwd (pwd)
    cd $__dotfiles_CODE_DIR/module

    function goToDir
        cd $argv[1]
    end

    function helpMessage
        echo "Usage: tst [searchQuery] [--all|-a] | [--help|-h]"
        echo
        echo " [searchQuery] : String to search"
        echo "    --all | -a : Include all modules in the search"
        echo "   --help | -h : Show this help message and exit"
        echo
        echo "Tip: You can select multiple tests using TAB"
        echo
        echo "Dependecies:"
        echo " - fzf"
        echo " - fd"
        echo
    end

    set -l options (fish_opt --short=h --long=help)
    set options $options (fish_opt --short=a --long=all)
    argparse $options -- $argv

    if set -q _flag_help
        helpMessage
        return
    end

    set fdArgumentsRegex '(.*module/(portal|staticanalysis|test|style|portalcms|theme|templatebuilder).*(.unit.php|unit.js|phpunit.php))|.*(portal|style|portalcms|theme|templatebuilder)/UITEST/.*.js' --exclude commonactions

    if set -q _flag_all
        set fdArgumentsRegex '.*module/.*(.unit.php|unit.js|phpunit.php)|.*/UITEST/.*.js' --exclude commonactions
    end

    if count $argv[1] > /dev/null
        set fullFilePath (fd -p $fdArgumentsRegex | fzf --multi --ansi --preview-window 'right:40%' --bind one:accept --query $argv[1] --preview='bat --color=always --style=header,grid --line-range :300 ./module/{}')
    else
        set fullFilePath (fd -p $fdArgumentsRegex | fzf --multi --ansi --preview-window 'right:40%' --preview='bat --color=always --style=header,grid --line-range :300 ./module/{}')
    end

    if test -n "$fullFilePath"
        testRunner $fullFilePath
    else
        echo "Exiting because no test was selected"
    end
    goToDir $cwd
end
