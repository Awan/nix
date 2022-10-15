{ pkgs, config, lib, ... }:

{
  programs.urxvt = {
    enable = true;
    fonts = [
      "xft:MonoLisa-Medium:size=17"
    ];
    iso14755 = true;
    keybindings = {
      "M-s" = "vim-scrollback";
      "M-p" = "vim-scrollback-paste";
    };
    scroll.bar.enable = false;
    scroll = {
      keepPosition = true;
      lines = 10000;
      scrollOnKeystroke = true;
    };
    shading = 145;
    transparent = true;
    extraConfig = {
      letterSpace = -1;
      utf = 0;
      locale = 1;
      imlocale = "en_US.UTF-8";
      termName = "xterm-256color";
      geometry = "96x30";
      background = "#1B2B34";
      reverseVideo = 0;
      loginShell = 0;
      jumpScroll = 1;
      skipScroll = 1;
      pastableTabs = 1;
      scrollStyle = "plain";
      thickness = 0;
      inheritPixmap = 0;
      tintColor = "#ffffff";
      blurRadius = "1x65";
      fading = 25;
      fadeColor = "#008B8B";
      utmpInhibit = 1;
      urgentOnBell = 0;
      visualBell = 0;
      mapAlert = 0;
      meta8 = 0;
      mouseWheelScrollPage = 0;
      tripleClickWords = 0;
      insecure = 0;
      cursorUnderline = 1;
      cursorBlink = 0;
      pointerBlank = 1;
      pointerShape = "ul_angle";
      intenstiyStyles = 1;
      buffered = 1;
      depth = 32;
      override-redirect = 0;
      externalBorder = 15;
      internalBorder = 15;
      borderless = 0;
      lineSpace = 0;
      skipBuiltinGlyphs = 0;
      pointerBlankDelay = 1;
      print-pipe = "cat > /tmp/$(echo urxvt.dump.$(date +'%Y%M%d%H%m%S'))";
      secondaryScreen = 1;
      secondaryScroll = 0;
      url-launcher = "google-chrome-stable";
    };
  };
}
