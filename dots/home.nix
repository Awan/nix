{ config, pkgs, ... }:

{

  home.username = "ak";
  home.homeDirectory = "/home/ak";
  home.stateVersion = "22.11";

  # Just keep home.nix short and simple. and give every program a single dedicated file.
  # then import them here.

  imports = [
    ./alacritty.nix
    #./foot.nix
    #./termite.nix
    ./feh.nix
    ./fonts.nix
    ./mako.nix
    ./mail.nix
    ./gpg-agent.nix
    ./go.nix
    ./git.nix
    #./hyprland.nix
    #./kitty.nix
    ./keychain.nix
    ./mpd.nix
    ./ncmpcpp.nix
    ./misc.nix
    ./mpv.nix
    ./packages.nix
    #./bspwm.nix
    #./sxhkd.nix
    #./bspwm_without_hm.nix
    #./picom.nix
    #./redshift.nix
    #./river.nix
    ./scripts.nix
    ./ssh.nix
    ./sway.nix
    ./tmux.nix
    ./variables.nix
    ./vim.nix
    ./waybar.nix
    ./wofi.nix
    #./wlsunset.nix
    ./urxvt.nix
    ./zathura.nix
    ./zsh.nix
  ];

  systemd.user.startServices = "suggest";
  # Allow unFree packages in userspace with flakes + Home-Manager
  nixpkgs.config.allowUnfreePredicate = (_: true);
  #  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.

  programs.home-manager.enable = true;

}
