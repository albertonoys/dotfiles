#------------------- aliases.fish - sbx ----------------------

# Remove previous aliases if they still exist
functions --erase igmb
functions --erase igab
functions --erase igbb
functions --erase igsb
functions --erase igmt
functions --erase igat
functions --erase igbt
functions --erase igst

alias ir='iatsRebuild'
alias rb='ir'
alias irb='ir base'
alias irt='ir theme'
alias irs='ir style'
alias irp='ir pb'

alias igmp='iatsGo --script=portal_BasePortalPageBuilder master'
alias igm='iatsGo master'
alias iga='iatsGo alpha'
alias igb='iatsGo beta'
alias igs='iatsGo stable'

alias is='iatsStatus'
alias ib='iatsBranch'

alias ipl='iatsPull'
alias imm='iatsMerge -f origin/master --rebase-version'
alias isw='iatsSwitch'
alias ipc='iatsPredictConflicts'

alias ec='vim ~/www/iats/config/config.js'
alias cpo='cd ~/www/iats/portal'
alias isql='mysql -usandbox -p1234 iats'
alias cco='cd $__dotfiles_CODE_DIR'
alias css='sudo -u www-data iats cssAssetParser --all && ding'
alias portalPacks='iats portal packs && ding'
alias portalPacksDev='iats portal packs --dev'
alias maintenanceReset='iats maintenance start && iats maintenance end'
alias restart-iats='iats maintenance restart'
alias tinkerOn='iatsOptionSet includeTinkerman true && maintenanceReset'
alias tinkerOff='iatsOptionSet includeTinkerman false'
alias configGet='iatsOptionGet'

# https://gitlab.xcade.net/avature/sonarqube-reviewer
alias sonar='sqr run iats (git branch --show-current) > /dev/null'

# If ts-tool is installed
if type -q ts
    abbr ips 'ts push'
    abbr ipss 'ts push --sonar-force'
    abbr ipsf 'ts push --fix'
    abbr tp 'ts push'
    abbr tpi 'ts push --interactive'
    abbr tps 'ts push --sonar-force'
    abbr tpf 'ts push --fix'
    abbr tpr "ts push --regex '(templatebuilder|theme|style|portal).*.(js|php)'"
    abbr tss 'ts switch'
    abbr tsm 'ts merge origin/master --fetch --rebase-version'
else
    abbr ips 'iatsPush'
    abbr ipss 'iatsPush --x-test sonar-force'
    abbr ipsf 'iatsPush -F'
    abbr ipst 'iatsPush --x-test filter-team:portalcontentmanagement'
end
