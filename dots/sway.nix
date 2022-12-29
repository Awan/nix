{ pkgs, config, lib, ... }:

{
  # Wallpaper stuff
  #systemd.user.services.wallpaper = {
  #  Service = { ExecStart = [ "%h/.local/bin/waywall wall" ]; };
  #  Unit = { Description = "Wallpaper Service for Sway"; };
  #  Install = { WantedBy = [ "sway-session.target" ]; };
  #};

  # Locker
  systemd.user.services.locker = {
    Unit = { Description = [ "Automatic Locker for Sway" ]; };
    Install = { WantedBy = [ "sway-session.target" ]; };
    Service = {
      ExecStart = [
        "${pkgs.swayidle}/bin/swayidle -w timeout 60 '~/.local/bin/waywall lock' before-sleep '~/.local/bin/waywall lock' timeout 75 '${pkgs.light}/bin/light -O; ${pkgs.light}/bin/light -S 0' resume '${pkgs.light}/bin/light -I' lock '~/.local/bin/waywall lock'"
      ];
    };
  };

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
        gaps = {
          top = 1;
          bottom = 1;
          horizontal = 5;
          vertical = 5;
          inner = 5;
          outer = 5;
          left = 5;
          right = 5;
          smartBorders = "on";
          smartGaps = true;
        };
        keybindings =
          let modifier = config.wayland.windowManager.sway.config.modifier;
          in lib.mkOptionDefault {
            "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
            "${modifier}+q" = "kill";
            "${modifier}+x" = "exec ~/.local/bin/waywall lock";
            "Mod1+w" = "exec ~/.local/bin/waywall wall";
            "Mod1+Shift+r" = "reload";
            "Mod1+Shift+q" = "exit";
            "Mod4+b" = "splith";
            "Mod4+v" = "splitv";
            "Mod4+s" = "layout stacking";
            "Mod4+w" = "layout tabbed";
            "Mod4+e" = "layout toggle split";
            "Mod4+f" = "fullscreen";
            "Mod4+Shift+space" = "floating toggle";
            "Mod4+space" = "focus mode_toggle";
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
