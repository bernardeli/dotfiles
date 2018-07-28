function prepend_path() {
  PATH="$1:$PATH"
}

function append_path() {
  PATH="$PATH:$1"
}

prepend_path "/usr/local/bin"

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export NIX_PATH="nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs"

unset prepend_path
unset append_path
