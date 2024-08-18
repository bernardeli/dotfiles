      # fd
      # fzf
      # hub
      # nix-direnv # TODO apply via programs.direnv
      # ripgrep
{ config, pkgs, ... }:

{
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  home.packages = [
    pkgs.fd
  ];

  home.stateVersion = "22.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;
}
