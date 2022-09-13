{ config, pkgs, lib, ... }:

{
  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.keychain;
    agents = [ "ssh id_ed25519" ];
    extraFlags = [ "--quiet" ];
    keys = [ "id_ed25519" ];
  };
}
