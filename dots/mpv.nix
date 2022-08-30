{ pkgs, lib, config, ... }:


{
  programs.mpv = {
    enable = true;
    bindings = {
      l = "seek 5 exact";
      L = "cycle_values loop-file inf no";
      h = "seek -5 exact";
      j = "seek -60 exact";
      k = "seek 60 exact";
      S = "cycle sub";
      C = "cycle sub down";
      "Alt+-" = "add video-zoom -0.25";
      "Alt+=" = "add video-zoom +0.25";
      "Alt+Tab" = "ignore";
    };

    config = {

      stop-screensaver = true;
      volume-max = 500;
      volume = 50;
      fullscreen = "yes";
      #video-unscaled="yes";
      #ao = "pulse";
      af-add = "scaletempo";
      hwdec = "autosafe";
      ytdl-format = "bestvideo[height<=?720]+bestaudio[ext=m4a]/best[height<=?720]";
      #gamma="25";
      #brightness="5";
      vo = "gpu";
      gpu-context = "wayland";
      #gpu-api = "vulkan";
      vd-lavc-threads = 4;
      sub-auto = "fuzzy";
      save-position-on-quit = "yes";
      ignore-path-in-watch-later-config = "yes";
      write-filename-in-watch-later-config = "yes";
      geometry = "50%:50%";
      autofit-larger = "80%x80%";
      sub-codepage = "UTF-8";
      osd-level = 1;
      osd-font = "Fantasque Sans Mono";
      osd-font-size = 36;
      osd-color = "#ffffff";
      osd-border-color = "#000000";
      osd-shadow-color = "#2f343f";
      osd-shadow-offset = 2;
      osd-border-size = 1;
      osd-bar-align-y = 0;
      osd-bar-h = 2;
      osd-bar-w = 60;
      screenshot-format = "png";
      screenshot-png-compression = 8;
      screenshot-directory = "~/pix/mpv";
      slang = "on";
      sub-font = "Noto Sans";
      sub-font-size = 42;
      sub-color = "#75ff00";
      sub-border-color = "#000000";
      sub-border-size = 1;
      sub-shadow-offset = 2;
      sub-shadow-color = "#2f343f";
      sub-spacing = 1;
      sub-pos = 95;
      osd-duration = 2500;
      input-ipc-server = "/tmp/mpvsocket";

    };
    profiles = {
      nodir = {
      sub-auto = "no";
      audio-file-auto = "no";
      };
    };

  };

}
