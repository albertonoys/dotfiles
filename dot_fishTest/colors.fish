# Color functions

function coloredEcho
    set exp $argv[1]
    set color $argv[2]
    set arrow $argv[3]

    set_color "$color"
    if test -n "$arrow"  # Check if arrow is empty
        echo "$arrow $exp"
    else
        echo "$exp"
    end
    set_color normal
end

function info
    coloredEcho "$argv[1]" blue "========>"
end

function success
    coloredEcho "$argv[1]" green "========>"
end

function error
    coloredEcho "$argv[1]" red "========>"
end

function substep_info
    coloredEcho "$argv[1]" yellow "===="
end

function substep_success
    coloredEcho "$argv[1]" cyan "===="
end

function substep_error
    coloredEcho "$argv[1]" red "===="
end
