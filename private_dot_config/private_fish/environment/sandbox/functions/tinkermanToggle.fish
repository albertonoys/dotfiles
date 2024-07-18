function tinkermanToggle --description 'Toggle tinkerman from config.js'

    set current_value (iatsOptionGet includeTinkerman)

    if test $current_value = "true"
        iatsOptionSet includeTinkerman false
        gum style --foreground 9 --bold "includeTinkerman set to false"
    end
    if test $current_value = "false"
        if gum confirm "includeTinkerman: false, enable?" --default=true --affirmative "Yup." --negative "Nope."
        iatsOptionSet includeTinkerman true
        iats maintenance start && iats maintenance end
        gum style --foreground 10 --bold "includeTinkerman set to true"
        end
    end
end
