# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

export NIXPKGS="https://releases.nixos.org/nixpkgs/nixpkgs-21.03pre243111.51428e8d382/nixexprs.tar.xz"
export HOME_MANAGER="https://github.com/rycee/home-manager/archive/41b1af808f1de69c31f3fd164d5274154ee782e4.tar.gz"

set_nix_path () {
  local nixpkgs_path="nixpkgs=$NIXPKGS"
  local home_manager_path="home-manager=$HOME_MANAGER"

  export NIX_PATH=$nixpkgs_path:$home_manager_path
}

set_nix_path
