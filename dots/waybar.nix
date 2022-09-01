{ pkgs, config, ... }:

{

  # overlay for wlr/workspaces

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];


  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "river-session.target";
    style =
    ''
      @define-color highlight #726E97;

      window#waybar {
        background: #1e1e1e;
        border-radius: 13px;
        padding: 9px;
        opacity: 0.9;
        border: 3px solid transparent;
        font-size: 20px;
        font-weight: bold;
        font-family: "Meslo LGM for Powerline";
      }

      #tray.needs-attention {
        color: #ff0000;
      }

      #custom-mailsnow {
        color: #ff0000;
      }

      #temperature.critical {
        color: #ff0000;
      }

      #battery, #network, #clock, #cpu, #memory, #temperature, #custom-mailsnow, #tray {
        margin: 0 10px;
        padding: 0 2px;
      }

      #battery.critical {
        color: #ff0000;
        font-weight: bold;
      }

      #battery.warning {
        color: #ff334a;
      }

      #tags button.occupied {
        color: #b22222;
      }

      #tags button.urgent {
        color: #de3163;
      }

      #tags button.focused {
        background: @highlight;
      }

      #tags button {
        padding: 0px 7px;
        border-radius: 7px;
        font-weight: bold;
      }

      #workspaces button {
        padding: 0px 7px;
        border-radius: 7px;
      }

      #workspaces button.active {
        background: @highlight;
      }

      #workspaces button.urgent {
        color: #de3163;
      }
     '';

    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      width = 1880;
      modules-right =
        [ "custom/mailsnow" "idle_inhibitor" "pulseaudio" "backlight" "network" "temperature" "cpu" "battery" "clock" "tray" ];
      modules-left = [ "river/tags" "custom/cmus" ];
      #modules-left = [ "wlr/workspaces" "mpd" ];

      clock = {
        interval = 1;
        timezone = "Asia/Karachi";
        tooltip-format = ''
          <big>{:%Y %B}</big>
          <tt><small>{calendar}</small></tt>'';
        format = "<span color=\"#00FF00\">{:%a %d/%m %H:%M:%S}</span>";
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
        format = "<span color=\"#FA9500\">{icon}</span> <span color=\"#724CF9\">{capacity:2}%</span>";
        format-plugged = "<span color=\"#3772FF\">{icon}</span> <span color=\"#585123\">{capacity:2}% </span>";
        format-charging = "<span color=\"#758BFD\">{icon}</span> <span color=\"#FCBF49\">{capacity:2}% </span>";
        format-icons = [ "" "" "" "" "" ];
      };

      cpu = {
        interval = 1;
        format = "<span color=\"#22577A\"> </span><span color=\"#4B1D3F\">{usage:1}%</span>";
      };

      network = {
        interface = "wl*";
        interval = 10;
        #format-wifi = " {essid}({signalStrength}%) ⬇{bandwidthDownBits}⬆{bandwidthUpBits}";
        format-wifi = "<span color=\"#832161\"> </span><span color=\"#582F0E\">{essid}</span>({signalStrength}%)";
        format-disconnected = "<span color=\"#3A86FF\"></span>";
        tooltip-format-wifi = "{essid} {ipaddr} ";
      };

      "river/tags" = {
        num-tags = 9;
        #tag-labels = [ "₁" "₂" "₃" "₄" "₅" "₆" "₇" "₈" "₉" ];
        tag-labels = [ "" "" "" "" "" "" "" "" "" ];
      };

      tray = {
        icon-size = 15;
        spacing = 5;
        reverse-direction = true;
      };

      temperature = {
        thermal-zone = 1;
        format = "<span color=\"#3A5A40\"> {temperatureC}°C</span>";
        format-critical = " {temperatureC}°C";
        critical-threshold = 70;
      };

      mpd = {
        interval = 1;
        format = "  {stateIcon}<span color=\"#013A63\">{artist}</span> <span color=\"#D645D8\"></span> <span color=\"#3A5A40\">{title}</span> <span color=\"#89023A\">{elapsedTime:%M:%S}/{totalTime:%M:%S}</span>";
        format-stopped = " ";
        format-disconnected = " ";
        format-paused = "  {stateIcon}";
        random-icons = {
          off = "<span color=\"#f53c3c\"></span> ";
          on = " ";
        };
        consume-icons = { on = " "; };
        repeat-icons = { on = " "; };
        single-icons = { on = "  1 "; };
        state-icons = {
          playing = "<span color=\"#945600\"> </span>";
          paused = "<span color=\"#945600\"> </span>";
        };
      };

      backlight = {
        interval = 5;
        format = "<span color=\"#C75000\">{icon}</span><span color=\"#621B00\">{percent}%</span>";
        #on-scroll-up = "brightnessctl s +10";
        on-scroll-up = "${pkgs.light}/bin/light -A 5";
        #on-scroll-down = "brightnessctl s 10-";
        on-scroll-down = "${pkgs.light}/bin/light -U 5";
        format-icons = [" "  " "];
      };

      pulseaudio = {
        format = "<span color=\"#7209B7\">{icon}</span> <span color=\"#004E98\">{volume}%</span>  ";
        format-muted = "  ";
        format-icons = [ "" "" "" "" ];
        default = [ ""  ""];
        on-scroll-up = "${pkgs.pamixer}/bin/pamixer --allow-boost -i 10";
        on-scroll-down = "${pkgs.pamixer}/bin/pamixer --allow-boost -d 10";
        scroll-step = 1;
        on-click = "pavucontrol";
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = { activated = "<span color=\"#E76F51\"> </span> "; deactivated = "<span color=\"#023E8A\"> </span> "; };
      };

      "custom/mailsnow" = {
        interval = 15;
        format = " {}";
        exec-if = "ping -c 2 abdullah.solutions >/dev/null 2>&1";
        exec = pkgs.writeShellScript "mailsnow"
        ''
          maildir=${config.home.homeDirectory}/.local/share/email/x1c/INBOX
          current_mails=$(${pkgs.findutils}/bin/find $maildir/new -type f -printf . | ${pkgs.coreutils}/bin/wc -c)
          if [ $current_mails -gt 0 ]; then
            echo $current_mails
          fi
        '';
      };

      "wlr/workspaces" = {
        format = "{icon}";
        sort-by-name = true;
        on-click = "activate";
        all-outputs = true;
        #format-icons = {
        #  "1" = "";
        #  "2" = "";
        #  "3" = "";
        #  "4" = "";
        #  "5" = "";
        #  "6" = "";
        #  "7" = "";
        #  "8" = "";
        #  "9" = "";
        #  "10" = "";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "7" = "";
          "8" = "";
          "9" = "";
          "10" = "";
          "focused" = "";
          "default" = "";
        };
      };
      "custom/cmus" = {
        interval = 1;
        format = "<span color=\"#D93EAA\"> ♪</span> <span color=\"#00FFFF\">{}</span>";
        exec-if = "pgrep -x cmus";
        on-click = "cmus-remote -u";
        #exec = ''
        #  cmus-remote -C "format_print '%a  %t'" | cut -c-40
        #  '';
        exec = ./waybar/cmus-status;
        escape = true;
      };
    }
  ];
 };
}
