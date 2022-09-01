{ pkgs, config, lib, ... }:



{

# Link urlview
  home.file.".urlview".source =
    config.lib.file.mkOutOfStoreSymlink ./urlview;
}
