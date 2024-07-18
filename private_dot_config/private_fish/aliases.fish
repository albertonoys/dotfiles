# Remove previous aliases/abbr
function remove_aliases
    alias | while read -l line
        set -l alias_name (string split ' ' $line)[2]
        functions --erase $alias_name
    end
end

abbr --erase (abbr --list)
remove_aliases

# Common aliases
alias gc.='git checkout .'
alias gd='git diff | bat --language diff'
alias fishConfig='vim ~/.config/fish/config.fish'
alias dot='cd $__dotfiles_PATH'
alias rld='source ~/.config/fish/config.fish'
alias aliasList='alias | bat --paging=never --wrap=never --language=fish && abbr | bat --paging=never --wrap=never --language=fish'
alias ding='tput bel'

abbr gp 'grep -rniI . -e ""'
abbr su "sudo fish"
abbr - 'cd -'
abbr gg 'git gui &'
abbr dotfilesUpdate 'dot && git pull && sudo ./bootstrap.sh && rld'

# Package aliases
if type -q eza
	alias ll='eza --long --group --header --all --group-directories-first --icons=auto'
	alias tree='eza --tree --all --icons=auto'
	alias ls='eza --icons=auto'
end

if type -q nvim
    abbr vim 'nvim'
    alias v='nvim'
end

if type -q chezmoi
    abbr cm 'chezmoi'
    abbr cz 'chezmoi'
end