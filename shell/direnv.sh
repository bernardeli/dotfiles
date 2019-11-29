if which direnv > /dev/null
then
  # silence direnv
  export DIRENV_LOG_FORMAT=
  eval "$(direnv hook zsh)"
fi
