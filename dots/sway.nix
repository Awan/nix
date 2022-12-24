{ pkgs, config, lib, ... }:

{
  wayland.windowManager = {
    sway = {
      enable = true;
      config = {
        focus = {
          followMouse = "always";
          newWindow = "smart";
        };
        modifier = "Mod4";
        workspaceAutoBackAndForth = true;
        window = {
          hideEdgeBorders = "smart";
          border = 2;
        };
        up = "k";
        down = "j";
        right = "l";
        left = "h";
        terminal = "alacritty";
        modes = {
          resize = {
            h = "resize shrink width 10 px";
            j = "resize grow height 10 px";
            k = "resize shrink height 10 px";
            l = "resize grow width 10 px";
            Escape = "mode default";
            Return = "mode default";
          };
        };
        startup = [{
          command = "systemctl --user restart waybar";
          always = true;
        }];
        menu = "${pkgs.wofi}/bin/wofi --insensitive --show drun,run";
        bars = [ ];
      };
    };
  };
}
