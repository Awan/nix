{ pkgs, config, ... }:

{
  programs.go = {
    enable = true;
    goPath = "go";
    goBin = "go/bin";
  };
}
