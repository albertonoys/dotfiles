# Completions for sbxr command
complete --no-files -c sbxr

set -l subcommands create delete increase-size init list migrate mount snapshot ssh start stop trait upload

# Options
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -s v -l verbosity -x -a "CRITICAL ERROR WARNING INFO DEBUG" -d 'Set the verbosity level'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -l version -d 'Show version information'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -l help -d 'Show help message and exit'

# Subcommands
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a create -d 'Create'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a delete -d 'Delete (destroy)'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a increase-size -d 'Increase size'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a init -d 'Initialize'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a list -d 'List'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a migrate -d 'Migrate'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a mount -d 'Mount'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a snapshot -d 'Take a snapshot'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a ssh -d 'SSH into'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a start -d 'Start (up)'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a stop -d 'Stop (halt)'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a trait -d 'Trait'
complete -c sbxr -n "not __fish_seen_subcommand_from $subcommands" -a upload -d 'Upload'

complete -c sbxr -n "__fish_seen_subcommand_from increase-size" -l size -d 'Integer. Increase the size of the of backend storage on this amount of GB. 2 will add 2GB to your current storage'
