{ pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = rec {
          normal.family = "ProggyCleanTT";
          regular.family = "ProggyCleanTT";
          bold.family = "ProggyCleanTT";
          bold_italic.family = "ProggyCleanTT";
          regular = { style = "Regular"; };
          italic = { style = "Italic"; };
          bold_italic = { style = "Bold Italic"; };
          bold = { style = "Bold"; };
          size = 23;
        };
        offset = {
          x = 0;
          y = 0;
        };
        window = { opacity = 0.9; };
        cursor = {
          style = "Underline";
          unfocused_hollow = false;
        };
        mouse = { hide_when_typing = true; };
        colors = {
          #cursor.cursor = "#ff0018";
          text.cursor = "#bde077";
        };
        env = { TERM = "xterm-256color"; };
      };
    };
  };
}
