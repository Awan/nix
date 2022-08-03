{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = builtins.readFile ./waybar/config.css;
    systemd.target = "river-session.target";
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      modules-right =
        [ "backlight" "network" "temperature" "cpu" "battery" "clock" "tray" ];
      modules-left = [ "river/tags" "mpd" ];

      clock = {
        interval = 1;
        timezone = "Asia/Karachi";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>'';
        format = "{:%a %d/%m %H:%M:%S}";
      };

      battery = {
        bat = "BAT0";
        adapter = "AC";
        full-at = 100;
        interval = 60;
        states = {
          critical = 40;
          warning = 60;
          good = 75;
        };
        format = "{icon} {capacity:4}%";
        format-plugged = "{icon} {capacity:4}% ";
        format-charging = "{icon} {capacity:4}% ";
        format-icons = [ "" "" "" "" "" ];
      };

      cpu = {
        interval = 1;
        format = " {usage:2}%";
      };

      network = {
        interface = "wl*";
        interval = 10;
        format-wifi = "  {essid} ({signalStrength}%)";
        #format-disconnected = "⚠";
        format-disconnected = "";
        tooltip-format-wifi = "{essid} ({signalStrength}%) ";
      };

      "river/tags" = {
        num-tags = 7;
        tag-labels = [ "❶" "❷" "❸" "❹" "❺" "❻" "❼" ];
      };

      tray = {
        icon-size = 15;
        spacing = 5;
        reverse-direction = true;
      };

      temperature = {
        thermal-zone = 1;
        format = " {temperatureC}°C";
        format-critical = " {temperatureC}°C";
        critical-threshold = 70;
      };

      mpd = {
        #server = "127.0.0.1";
        #port = 6600;
        interval = 1;
        #unknown-tag = "";
        format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})";
        format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}";
        random-icons = [ "off = <span color=\#f53c3c\></span> " "on =  " ];
        consume-icons = "on = ";
        repeat-icons = "on =  ";
        single-icons = "on =  1";
        state-icons = ["playing = " "paused = "];
      };

      backlight ={
        interval = 5;
        format = "{icon:3} {percent:4}% ";
        on-scroll-up = "light -A 2";
        on-scroll-down = "light -U 2";
        format-icons = [" "  " "];
      };
    }
  ];
 };
}
