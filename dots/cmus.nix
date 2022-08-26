{ pkgs, lib, config, ... }:

{

  # Symlink cmus rc
  xdg.configFile."cmus/rc".source =
    config.lib.file.mkOutOfStoreSymlink ./cmus/rc;

}
