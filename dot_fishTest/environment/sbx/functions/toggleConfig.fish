function toggleConfig --description 'Toggle boolean from config.js'

    #   Import colors
    . ~/.config/fish/colors.fish

    set config_string $argv[1]
    set current_value (iatsOptionGet $config_string)

    if test $current_value = "true"
        iatsOptionSet $config_string false
        coloredEcho "$config_string set to false" red
    end
    if test $current_value = "false"
        iatsOptionSet $config_string true
        coloredEcho "$config_string set to true" green
    end
end
