{ config, lib, pkgs, ... }:

{
  home.sessionVariables = {
    TERMINAL = "${pkgs.alacritty}/bin/alacritty";
    EDITOR = "vim";
    GOPATH = "~/go";
  };
}
