#   Import colors
    . ~/.config/fish/colors.fish

function ibr
    set -l number $argv[1]
    set -l text $argv[2]

    # Check if the first parameter is exactly six digits long
    if string match -qr '^\d{6}$' -- $number
        set -l result "T$number$text"
        echo -n "Are you sure this is correct?: "
        coloredEcho "$result" blue

        read -P "Press Enter to confirm or type anything to cancel: " confirm

        if test $status -ne 0
            coloredEcho "Operation cancelled by user." red
            return
        end

        if test "$confirm" = ""
            ib $result
        else
            coloredEcho "Operation cancelled." red
        end
    else
        coloredEcho "The first parameter must be a six-digit number." red
    end
end
