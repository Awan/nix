{ config, pkgs, ... }:

{

  home.username = "ak";
  home.homeDirectory = "/home/ak";

  # Just keep home.nix short and simple. and give every program a single dedicated file.
  # then import them here.

  imports = [
    ./alacritty.nix
    ./gpg-agent.nix
    ./git.nix
    ./kitty.nix
    ./river.nix
    ./packages.nix
    ./zsh.nix
  ];

  systemd.user.startServices = "suggest";
  # Allow unFree packages in userspace with flakes + Home-Manager
  nixpkgs.config.allowUnfreePredicate = (_: true);
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.

  programs.home-manager.enable = true;


}