{ pkgs, config, lib, ... }:

{
  wayland.windowManager = {
    sway = {
      enable = true;
      config = {
        assigns = { "2: web" = [{ class = "^Google-chrome$"; }]; };
        focus = {
          followMouse = "always";
          newWindow = "smart";
        };
        modifier = "Mod4";
        defaultWorkspace = "workspace number 1";
        workspaceAutoBackAndForth = true;
        window = {
          hideEdgeBorders = "smart";
          border = 2;
        };
        keybindings =
          let modifier = config.wayland.windowManager.sway.config.modifier;
          in lib.mkOptionDefault {
            "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
            "${modifier}+q" = "kill";
            "${modifier}+x" = "exec ~/.local/bin/waywall lock";
            "Mod1+w" = "exec ~/.local/bin/waywall wall";
          };
        up = "k";
        down = "j";
        right = "l";
        left = "h";
        #terminal = "alacritty";
        floating = {
          titlebar = false;
          criteria = [ { class = "feh"; } { class = "mpv"; } ];
          modifier = "Mod4";
        };
        fonts = {
          names = [ "DejaVu Sans Mono" "FontAwesome5Free" ];
          style = "Bold Semi-Condensed";
          size = 11.0;
        };
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
