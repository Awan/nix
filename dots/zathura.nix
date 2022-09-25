{ lib, config, pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    package = pkgs.zathura;
    extraConfig = ''
      set guioptions shv
      set statusbar-home-title true
      set window-title-home-tilde true
      set selection-clipboard clipboard
      set recolor true
      set default-bg #2E344E
      set default-fg #D8DEE9
      set recolor-lightcolor #2E3440
      set recolor-darkcolor #D8DEE9
      set statusbar-fg #000000
      set statusbar-bg #F0B050
      set inputbar-fg #D8DEE9
      set inputbar-bg #3B4252
      set completion-highlight-fg #000000
      set completion-highlight-bg #5E81AC
      set highlight-color #5E81AC
      set highlight-active-color #88C0D0
      set notification-fg #000000
      set notification-bg #5E81AC
      '';
  };
}
