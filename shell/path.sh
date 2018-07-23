function prepend_path() {
  PATH="$1:$PATH"
}

function append_path() {
  PATH="$PATH:$1"
}

prepend_path "/usr/local/bin"
# append_path "/usr/local/opt/go/libexec/bin"
# append_path "/usr/local/opt/coreutils/libexec/gnubin"

export NIX_PATH="nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs"

unset prepend_path
unset append_path
