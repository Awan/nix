{ pkgs, config, lib, callPackage, ... }:

{
  home.packages = [ (pkgs.callPackage ./fonts/monolisa.nix { }) ];
  fonts.fontconfig.enable = true;
  gtk.theme.package = pkgs.dracula-theme;
  gtk.theme.name = "dracula";
  gtk.font.package = "${pkgs.meslo-lg}";
  gtk.font.name = "Meslo LG L";
  gtk.font.size = "11";
}
