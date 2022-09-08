{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    backend = "xrender";
    #inactiveDim = "0.0";
    inactiveOpacity = 0.95;
    activeOpacity = 1.0;
    #blurExclude =
    #[
    #  "window_type = 'desktop'"
    #  "window_type = 'dock'"
    #  "_GTK_FRAME_EXTENTS@:c"
    #];
    settings = {
      shadow = {
        radius = 7;
        offset-x = -7;
        offset-y = -7;
      };
      frame-opacity = 0.5;
      inactive-opacity-override = false;
      corner-radius = 20.0;
      mark-wmwin-focused = true;
      mark-overdi-focused = false;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      usage-damage = true;
      log-level = "warn";
    };
    #noDNDShadow = false;
    #noDockShadow = false;
    opacityRules = [
      "95:class_g = 'URxvt' && focused"
      "80:class_g = 'URxvt' && !focused"
      "60:class_g = 'Termite' && focused"
      "55:class_g = 'Termite' && !focused"
      "40:class_g = 'Bspwm' && class_i = 'presel_feedback'"
    ];
    shadow = false;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
    vSync = true;
    fade = true;
    fadeSteps = [ 3.0e-2 3.0e-2 ];
  };
}
