### Require brew install hub
eval "$(hub alias -s)"
fpath=(~/.dotfiles/zsh/_hub $fpath)
autoload -U compinit && compinit

