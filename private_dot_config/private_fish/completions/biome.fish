# Fish shell completion for Biome (https://biomejs.dev/)

function __fish_biome_needs_command
    set cmd (commandline -opc)
    if [ (count $cmd) -eq 1 ]
        return 0
    end
    return 1
end

function __fish_biome_using_command
    set cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

complete -f -c biome

# Main commands
complete -f -c biome -n __fish_biome_needs_command -a version -d "Shows the Biome version information and quit"
complete -f -c biome -n __fish_biome_needs_command -a rage -d "Prints information for debugging"
complete -f -c biome -n __fish_biome_needs_command -a start -d "Start the Biome daemon server process"
complete -f -c biome -n __fish_biome_needs_command -a stop -d "Stop the Biome daemon server process"
complete -f -c biome -n __fish_biome_needs_command -a check -d "Runs formatter, linter and import sorting to the requested files"
complete -f -c biome -n __fish_biome_needs_command -a lint -d "Run various checks on a set of files"
complete -f -c biome -n __fish_biome_needs_command -a format -d "Run the formatter on a set of files"
complete -f -c biome -n __fish_biome_needs_command -a ci -d "Command to use in CI environments"
complete -f -c biome -n __fish_biome_needs_command -a init -d "Bootstraps a new biome project"
complete -f -c biome -n __fish_biome_needs_command -a lsp-proxy -d "Acts as a server for the Language Server Protocol over stdin/stdout"
complete -f -c biome -n __fish_biome_needs_command -a migrate -d "Updates the configuration when there are breaking changes"
complete -f -c biome -n __fish_biome_needs_command -a explain -d "Retrieve the documentation of various aspects of the CLI"
complete -f -c biome -n __fish_biome_needs_command -a clean -d "Clean the logs emitted by the daemon"

# Global options
complete -c biome -l colors -a "off force" -d "Set the formatting mode for markup"
complete -c biome -l use-server -d "Connect to a running instance of the Biome daemon server"
complete -c biome -l verbose -d "Print additional diagnostics"
complete -c biome -l config-path -d "Set the file path to the configuration file"
complete -c biome -l max-diagnostics -d "Cap the amount of diagnostics displayed"
complete -c biome -l skip-errors -d "Skip over files containing syntax errors"
complete -c biome -l no-errors-on-unmatched -d "Silence errors for unmatched files"
complete -c biome -l error-on-warnings -d "Exit with an error code on warnings"
complete -c biome -l reporter -a "json json-pretty github junit summary" -d "Change how diagnostics and summary are reported"
complete -c biome -l log-level -a "none debug info warn error" -d "Set the level of logging"
complete -c biome -l log-kind -a "pretty compact json" -d "Set how the log should look"
complete -c biome -l diagnostic-level -a "info warn error" -d "Set the level of diagnostics to show"

# Options for 'check' command
complete -c biome -n "__fish_biome_using_command check" -l write -d "Writes safe fixes, formatting and import sorting"
complete -c biome -n "__fish_biome_using_command check" -l unsafe -d "Allow unsafe fixes"
complete -c biome -n "__fish_biome_using_command check" -l apply -d "Alias for --write"
complete -c biome -n "__fish_biome_using_command check" -l apply-unsafe -d "Alias for --write --unsafe"
complete -c biome -n "__fish_biome_using_command check" -l formatter-enabled -a "true false" -d "Enable or disable the formatter check"
complete -c biome -n "__fish_biome_using_command check" -l linter-enabled -a "true false" -d "Enable or disable the linter check"
complete -c biome -n "__fish_biome_using_command check" -l organize-imports-enabled -a "true false" -d "Enable or disable organize imports"
complete -c biome -n "__fish_biome_using_command check" -l stdin-file-path -d "Use for formatting code from stdin"
complete -c biome -n "__fish_biome_using_command check" -l staged -d "Only check staged files"
complete -c biome -n "__fish_biome_using_command check" -l changed -d "Only check changed files"
complete -c biome -n "__fish_biome_using_command check" -l since -d "Specify base branch for --changed"

# Options for 'lint' command
complete -c biome -n "__fish_biome_using_command lint" -l write -d "Writes safe fixes"
complete -c biome -n "__fish_biome_using_command lint" -l unsafe -d "Allow unsafe fixes"
complete -c biome -n "__fish_biome_using_command lint" -l apply -d "Alias for --write"
complete -c biome -n "__fish_biome_using_command lint" -l apply-unsafe -d "Alias for --write --unsafe"
complete -c biome -n "__fish_biome_using_command lint" -l only -d "Run only specific rules or groups"
complete -c biome -n "__fish_biome_using_command lint" -l skip -d "Skip specific rules or groups"
complete -c biome -n "__fish_biome_using_command lint" -l stdin-file-path -d "Use for linting code from stdin"
complete -c biome -n "__fish_biome_using_command lint" -l staged -d "Only lint staged files"
complete -c biome -n "__fish_biome_using_command lint" -l changed -d "Only lint changed files"
complete -c biome -n "__fish_biome_using_command lint" -l since -d "Specify base branch for --changed"

# Options for 'format' command
complete -c biome -n "__fish_biome_using_command format" -l write -d "Writes formatted files to file system"
complete -c biome -n "__fish_biome_using_command format" -l stdin-file-path -d "Use for formatting code from stdin"
complete -c biome -n "__fish_biome_using_command format" -l staged -d "Only format staged files"
complete -c biome -n "__fish_biome_using_command format" -l changed -d "Only format changed files"
complete -c biome -n "__fish_biome_using_command format" -l since -d "Specify base branch for --changed"

# Options for 'ci' command
complete -c biome -n "__fish_biome_using_command ci" -l formatter-enabled -a "true false" -d "Enable or disable the formatter check"
complete -c biome -n "__fish_biome_using_command ci" -l linter-enabled -a "true false" -d "Enable or disable the linter check"
complete -c biome -n "__fish_biome_using_command ci" -l organize-imports-enabled -a "true false" -d "Enable or disable organize imports"
complete -c biome -n "__fish_biome_using_command ci" -l changed -d "Only check changed files"
complete -c biome -n "__fish_biome_using_command ci" -l since -d "Specify base branch for --changed"

# Options for 'init' command
complete -c biome -n "__fish_biome_using_command init" -l jsonc -d "Emit a biome.jsonc file"

# Options for 'lsp-proxy' command
complete -c biome -n "__fish_biome_using_command lsp-proxy" -l config-path -d "Set custom configuration file path"

# Options for 'migrate' command
complete -c biome -n "__fish_biome_using_command migrate" -l write -d "Writes the new configuration file to disk"
complete -c biome -n "__fish_biome_using_command migrate" -a "prettier" -d "Migrate from Prettier configuration"
complete -c biome -n "__fish_biome_using_command migrate" -a "eslint" -d "Migrate from ESLint configuration"

# Options for 'migrate eslint' subcommand
complete -c biome -n "__fish_biome_using_command migrate" -n "__fish_seen_subcommand_from eslint" -l include-inspired -d "Include rules inspired from ESLint"
complete -c biome -n "__fish_biome_using_command migrate" -n "__fish_seen_subcommand_from eslint" -l include-nursery -d "Include nursery rules in migration"

# Options for 'explain' command
# Note: The completion for the NAME argument would ideally be dynamically generated based on available topics

# Help option for all commands
complete -c biome -s h -l help -d "Prints help information"
