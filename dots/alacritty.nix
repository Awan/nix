{ pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font = rec {
          #normal.family = "MonoLisa-Medium";
          normal.family = "JetBrains Mono";
          #regular.family = "MonoLisa-Medium";
          regular.family = "JetBrains Mono";
          #bold.family = "MonoLisa-Medium";
          bold.family = "JetBrains Mono";
          #bold_italic.family = "MonoLisa-Medium";
          bold_italic.family = "JetBrains Mono";
          regular = { style = "Regular"; };
          italic = { style = "Italic"; };
          bold_italic = { style = "BoldItalic"; };
          bold = { style = "Bold"; };
          size = 19;
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
