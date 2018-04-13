function prepend_path() {
  if [ -d "$1" ]; then
    PATH="$1:$PATH"
  fi
}

function append_path() {
  if [ -d "$1" ]; then
    PATH="$PATH:$1"
  fi
}

append_path "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
append_path "/usr/local/opt/go/libexec/bin"
append_path "/usr/local/opt/coreutils/libexec/gnubin"

export NIX_PATH="nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs"

unset prepend_path
unset append_path

nix_shell_status () {
  if [ ! -z $IN_NIX_SHELL ]; then
    printf " [nix]"
  else
    printf ""
  fi
}

# Run spectrum_ls to see all colours
export PROMPT='${ret_status} %{$fg[cyan]%}%c%{$FG[023]%}$(nix_shell_status)%{$reset_color%} $(git_prompt_info)'
