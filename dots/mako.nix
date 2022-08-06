{ pkgs, ... }:

{
  programs.mako = {
    enable = true;
    anchor = "top-right";
    backgroundColor = "#282828FF";
    borderColor = "#4C7899FF";
    borderRadius = 30;
    borderSize = 10;
    defaultTimeout = 10000;
    font = "Meslo LG M";
    height = 150;
    icons = true;
    #iconsPath = "~/.local/share/icons/";
    layer = "overlay";
    margin = "15";
    maxIconSize = 32;
    maxVisible = -1;
    padding = "15";
    progressColor = "over #5588AAFF";
    sort = "+time";
    textColor = "#FFC96D9E";
    width = 300;
  };
}
