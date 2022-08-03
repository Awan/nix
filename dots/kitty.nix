{ config, lib, ... }:

{
  programs = {
    kitty = {
      enable = true;
      settings = {
        background = "#100d15";
        background_opacity = "0.7";
        dim_opacity = "0.75";
        #font_family = "Meslo LG M";
        #font_family = "CodingFontTobi";
        font_family = "Dina";
        enable_audio_bell = "no";
        font_size = "22";
        shell_integration = "no-cursor";
        confirm_os_window_close = "0";
        cursor = "none";
        cursor_shape = "underline";
        cursor_blink_interval = "0";
        #cursor_underline_thickness = "0.5";
      };
    };
  };
}
