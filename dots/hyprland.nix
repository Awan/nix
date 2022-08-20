{ pkgs, config, lib, ... }:


{

  # Symlink hyprland.conf
  xdg.configFile."hypr/hyprland.conf".source =
    config.lib.file.mkOutOfStoreSymlink ./hypr/hyprland.conf;

  # Create a target session for hyprland
  systemd.user.targets.hyprland-session = {
    Unit = {
      Description = "Hyprland compositor Session";
      Documentation = [ "man:systemd.special(7)" ];
      BindsTo = [ "graphical-session.target" ];
      Wants = [ "graphical-session-pre.target" ];
      After = [ "graphical-session-pre.target" ];
    };
  };

  # Home-Manager system tray
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

}
