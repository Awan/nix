{ config, lib, pkgs, protocol, ... }:

{
  xsession = {
    enable = true;
    profilePath = ".xprofile";
    #pointerCursor.x11.enable = true;
    #pointerCursor = "ul_angle";
    #initExtra = ''
    #  "bspc config external_rules_command $HOME/.config/bspwm/external_rules"
    #  '';
    windowManager = {
      bspwm = {
        enable = true;
        monitors = { eDP-1 = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" ]; };
        settings = {
          merge_overlapping_monitors = true;
          remove_unplugged_monitors = true;
          remove_disabled_monitors = true;
          border_width = 1;
          window_gap = 5;
          right_padding = 0;
          bottom_padding = 0;
          left_padding = 0;
          top_monocle_padding = 0;
          right_monocle_padding = 0;
          bottom_monocle_padding = 0;
          left_monocle_padding = 0;
          ignore_ewmh_focus = false;
          initial_polarity = "second_child";
          split_ratio = 0.5;
          borderless_monocle = true;
          gapless_monocle = true;
          directional_focus_tightness = "low";
          focus_follows_pointer = true;
          pointer_follows_monitor = true;
          pointer_follows_focus = false;
          click_to_focus = "any";
          single_monocle = true;
          pointer_action1 = "move";
          presel_feedback = true;
          status_prefix = "W";
          automatic_scheme = "longest_side";
          presel_feedback_color = "#58FAF4";
          focused_border_color = "#800000";
          active_border_color = "#F10CF1";
          normal_border_color = "#28DECB";
          pointer_modifier = "mod4";
          pointer_action3 = "resize_side";
        };
        startupPrograms = [ "~/.local/bin/mypanel" "sxhkd -c ~/.config/sxhkd/sxhkdrc" "feh --bg-scale ~/pix/wall/blurry/ --randomize" "mako" "picom -b" "bspc config external_rules_command $HOME/.config/bspwm/external_rules" ];
      };
    };
  };
}
