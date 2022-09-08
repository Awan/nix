{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        font = "Meslo LG M:size=13";
        locked-title = "yes";
        bold-text-in-bright = "palette-based";
      };
      scrollback = {
        lines = "9999";
        multiplier = "5";
        indicator-format = "percentage";
      };
      url = {
        launch = "${pkgs.google-chrome}/bin/google-chrome-stable ${url}";
      };
      cursor = {
        style = "underline";
        blink = "yes";
      };
      mouse = { hide-when-typing = "yes"; };
      colors = { alpha = "0.9"; };
    };
  };
  programs.foot.server = { enable = true; };
}
