nix_shell_status () {
  if [ ! -z $IN_NIX_SHELL ]; then
    printf " [nix]"
  else
    printf ""
  fi
}

# Run spectrum_ls to see all colours
export PROMPT='${ret_status} %{$fg[cyan]%}%c%{$FG[023]%}$(nix_shell_status)%{$reset_color%} $(git_prompt_info)'

unset nix_shell_status
