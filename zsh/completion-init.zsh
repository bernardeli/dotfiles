zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit

fpath=(~/.fresh/build/completion $fpath)
