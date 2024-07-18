function is_installed
    type -q $argv[1]
end

function dir_exists
    test -e $argv[1]
end

function add_to_path_if_exists
    if dir_exists $argv[1]
        fish_add_path -g $arg[1]
    end
end

function run_if_installed
    if test (count $argv) -lt 2
        return 1
    end

    set -l package $argv[1]
    set -l command $argv[2..-1]

    if is_installed $package
        eval $command
    end
end
