{ pkgs, ... }:


let

  pkgsUnstable = import <nixpkgs-unstable> {};

in

{
  home.packages = [
    pkgsUnstable.wlopm
#   pkgsUnstable.stacktile
#    pkgsUnstable.swhkd # waiting for it to become available
    pkgsUnstable.wayshot
    pkgs.waybar
    pkgs.swaybg
    pkgs.wev
    pkgs.htop
    pkgs.wofi
    pkgs.swaylock
    pkgs.brightnessctl
    pkgs.swayidle
    pkgs.zsh
    pkgs.eksctl
    pkgs.kubectl
    pkgs.usb-modeswitch
    pkgs.recoll
    pkgs.anki
    pkgs.p7zip
    pkgs.zip
    pkgs.lua
    pkgs.kitty
    pkgs.alacritty
    pkgs.unzip
    pkgs.leafpad
    pkgs.river
    pkgs.mpd
    pkgs.ncmpcpp
    pkgs.xdo
    pkgs.mpc-cli
    pkgs.sxhkd
    pkgs.picom
    pkgs.rofi
    pkgs.feh
    pkgs.mplayer
    pkgs.age
    pkgs.tig
    pkgs.termite
    pkgs.megasync
    pkgs.mpv
    pkgs.ffmpeg
    pkgs.ffmpegthumbnailer
    pkgs.msmtp
    pkgs.notmuch
    pkgs.ranger
    pkgs.redshift
    pkgs.hugo
    pkgs.urlview
    #  pkgs.xorg.xev
    #  pkgs.xorg.xwininfo
    #  pkgs.xorg.xdpyinfo
    #  pkgs.xorg.xkill
    #  pkgs.xorg.xmodmap
    pkgs.xlsfonts
    pkgs.youtube-dl
    pkgs.sxiv
    pkgs.libnotify
    pkgs.youtube-viewer
    pkgs.ueberzug
    pkgs.simplescreenrecorder
    pkgs.zsh-powerlevel10k
    pkgs.unclutter
    pkgs.tmux
    pkgs.weechat
    pkgs.tmate
    pkgs.mutt
    pkgs.google-chrome
    pkgs.fira
    pkgs.yaru-theme
    pkgs.element-desktop
    pkgs.zilla-slab
    pkgs.pciutils
    pkgs.playerctl
    pkgs.pass
    pkgs.pfetch
    pkgs.pavucontrol
    pkgs.tdesktop
    pkgs.isync
    pkgs.ponymix
    pkgs.stow
    pkgs.cmus
    pkgs.imagemagick
    pkgs.powerline-fonts
    pkgs.rxvt-unicode
    pkgs.powerline
    pkgs.nodejs
    pkgs.pipewire
    pkgs.virtualbox
    #   pkgs.xdotool
    pkgs.fd
    pkgs.figlet
    pkgs.fq
    pkgs.gh
    pkgs.gitui
    pkgs.glow
    pkgs.lolcat
    pkgs.lr
    pkgs.ncdu
    pkgs.moreutils
    pkgs.nix-index
    pkgs.nix-info
    pkgs.nix-top
    pkgs.nixfmt
    pkgs.nixpkgs-fmt
    pkgs.wl-clipboard
    pkgs.polybarFull
    pkgs.mako
  ];
}
