# Color mapping
if is_installed gum
    set -g color_map info 153 success 50 error 197 substep_info 226 substep_success 51
else
    set -g color_map info blue success green error red substep_info yellow substep_success cyan
end

# Arrow string
set -g arrow "========>"

# Function to get color from color_map
function get_color
    set -l index (contains -i -- $argv[1] $color_map)
    if test -n "$index"
        echo $color_map[(math $index + 1)]
    else
        echo "white" # default color if not found
    end
end

# Main color function
function colored_echo
    set -l message $argv[1]
    set -l color $argv[2]
    set -l show_arrow $argv[3]

    if is_installed gum
        set -l style_args --foreground $color
        test "$show_arrow" = true; and set message "$arrow $message"
        gum style $style_args $message
    else
        set_color $color
        test "$show_arrow" = true; and echo -n "$arrow "
        echo $message
        set_color normal
    end
end

# Generate color functions
for func in info success error substep_info substep_success
    function $func -V func
        colored_echo $argv[1] (get_color $func) $argv[2]
    end
end
