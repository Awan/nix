{ pkgs, ... }:

{
    home.file.".config/bspwm" = {
    source = ./bspwm;
    recursive = true;
  };

  home.file.".config/sxhkd" = {
    source = ./sxhkd;
    recursive = true;
  };


}
