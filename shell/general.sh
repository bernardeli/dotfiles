alias uuid='uuidgen | tr "[:upper:]" "[:lower:]" | tr -d "\n" | pbcopy'
alias fastcop='git since-main | grep \\.rb$ | xargs ls 2>/dev/null | xargs rubocop --force-exclusion'
alias fastlint='git since-main | grep \\.html.erb$ | xargs ls 2>/dev/null | xargs erblint'
alias psg="ps aux | grep -v grep | grep -i --color=auto $1"
alias ll='ls -lGAh'
alias lsg='ll | grep'
alias grep="grep --color=auto --exclude={.bzr,CVS,.git,.hg,.svn}"
alias pj='python -mjson.tool'
alias Grep='grep'
alias gpre='grep'
alias grpe='grep'
alias gtix='gitx'
alias gti='git'
alias ag='rg'
alias ack='rg'
alias ism='iex -S mix'
alias path='echo -e ${PATH//:/\\n}'
alias gitx='fork'

alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g S='| sort'
alias -g G='| rg' # now you can do: ls foo G something

export CUCUMBER_FORMAT=progress

# export NIX_PG_VERSION=13

alias reload=". ~/.zshrc"

c() { cd "$HOME/Code/$1" || return; }
_c() { _files -W ~/Code -/; }
compdef _c c

alias nx="nix-shell --command zsh"
alias nxp="nix-shell --command zsh -p"

fgf() {
  cd ~/Code/lookout
}

export DISABLE_SPRING=true
