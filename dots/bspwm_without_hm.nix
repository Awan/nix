{ config, pkgs, lib, ... }:

{

  home.file.".config/bspwm".source =
    config.lib.file.mkOutOfStoreSymlink ./bspwm;

  home.file.".config/sxhkd".source =
    config.lib.file.mkOutOfStoreSymlink ./sxhkd;


  home.file.".config/sx/sxrc".source =
    config.lib.file.mkOutOfStoreSymlink ./sxrc;
}
