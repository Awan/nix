{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  gtk.font.package = "${pkgs.meslo-lg}";
  gtk.font.name = "Meslo LG";
  gtk.font.size = "11";
}
