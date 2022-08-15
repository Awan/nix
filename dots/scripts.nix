{ lib, pkgs, config, ... }:


{

  # symlink bin scripts to ~/.local/bin

  home.file.".local/bin".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dots/bin";

}
