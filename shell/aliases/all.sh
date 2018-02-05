########## Alias ##########

alias uuid='uuidgen | tr "[:upper:]" "[:lower:]" | tr -d "\n" | pbcopy'
alias fastcop='git since-master | grep \\.rb$ | xargs ls 2>/dev/null | xargs rubocop --force-exclusion'
alias psg="ps aux | grep -v grep | grep -i --color=auto $1"
alias ll='ls -lGAh'
alias lsg='ll | grep'
alias pj='python -mjson.tool'
alias Grep='grep'
alias gpre='grep'
alias grpe='grep'
alias gtix='gitx'
alias gti='git'
alias cl='highlight -O ansi'
alias fork='open . -a /Applications/Fork.app'
alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something

# ZSH completion trash
export CUCUMBER_FORMAT=progress

alias reload=". ~/.zshrc"
