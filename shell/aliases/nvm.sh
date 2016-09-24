# I want nvm not to fuck with my shell boot time
nvm() {
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"
  nvm "$@"
}

node() {
  unset -f node
  export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"
  node "$@"
}

npm() {
  unset -f npm
  export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"
  npm "$@"
}

