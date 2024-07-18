# Utility function to check if a command is installed
function is_installed
    type -q $argv[1]
end
