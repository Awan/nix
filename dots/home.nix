{ config, pkgs, ... }:

{

  home.username = "ak";
#  home.homeDirectory = "/home/ak";

  # Just keep home.nix short and simple. and give every program a single dedicated file.
  # then import them here.

  imports = [
    ./alacritty.nix
    #./foot.nix
    #./termite.nix
    ./mako.nix
    ./mail.nix
    ./gpg-agent.nix
    ./git.nix
    #./kitty.nix
    #./mpd.nix
    ./packages.nix
    #./bspwm.nix
    #./sxhkd.nix
    #./bspwm_without_hm.nix
    #./picom.nix
    ./river.nix
    ./vim.nix
    ./waybar.nix
    ./zsh.nix
  ];

  systemd.user.startServices = "suggest";
  # Allow unFree packages in userspace with flakes + Home-Manager
  nixpkgs.config.allowUnfreePredicate = (_: true);
#  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.

  programs.home-manager.enable = true;


}
