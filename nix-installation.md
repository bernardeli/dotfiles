sh <(curl https://nixos.org/nix/install) --no-daemon
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-channel --remove nixpkgs
