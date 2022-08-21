{ pkgs, config, lib, ... }:


# symlink wofi style.css

{
  xdg.configFile."wofi/style.css".source =
    config.lib.file.mkOutOfStoreSymlink ./wofi/style.css;

}
