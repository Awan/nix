{ pkgs, config, lib, ... }:



{

# Link urlview
  home.file.".urlview".source =
    config.lib.file.mkOutOfStoreSymlink ./urlview;

# GTK
#gtk = {
#  enable = true;
#  font = {
#    name = "Meslo LGM";
#    size = 9;
#  };
#};

}
