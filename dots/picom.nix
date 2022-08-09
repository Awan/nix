{ pkgs, ... }:


{
  services.picom = {
    enable = true;
    backend = "xrender";
    inactiveDim = "0.0";
    inactiveOpacity = "0.95";
    activeOpacity = "1.0";
    blurExclude =
    [
      "window_type = 'dock'"
      "window_type = 'desktop'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
    extraOptions =
    ''
      shadow-radius = 7;
      shadow-offset-x = -7;
      shadow-offset-y = -7;
      frame-opacity = 0.5;
      inactive-opacity-override = false;
      focus-exclude = [ "class_g = 'Cairo-clock'" ];
      corner-radius = 20.0;
      rounded-corners-exclude = [ "window_type = 'dock'", "class_g = 'Polybar'", "class_g = 'Lemobar'"];
      mark-wmwin-focused = true;
      mark-overdi-focused = false;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      usage-damage = true;
      log-level = "warn";
    '';
    noDNDShadow = false;
    noDockShadow = false;
    opacityRule =
      [
        "95:class_g = 'URxvt' && focused"
        "80:class_g = 'URxvt' && !focused"
        "60:class_g = 'Termite' && focused"
        "55:class_g = 'Termite' && !focused"
        "40:class_g = 'Bspwm' && class_i = 'presel_feedback'"
      ];
      shadow = false;
      shadowOffsets = [ "-7" "-7" ];
      shadowExclude = 
      [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "class_g = 'Cairo-clock'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
      vSync = true;
      fade = true;
      fadeSteps = [ "0.03" "0.03" ];
  };
}
