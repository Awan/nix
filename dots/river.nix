{ config, pkgs, lib, ... }:

{
  # include overlay
  imports = [ ./river/wayland-overlay.nix ];
  # move river configuration file to its directory...
  xdg.configFile."river/init".source =
    config.lib.file.mkOutOfStoreSymlink ./river/init;

  # lets create a target session for river
    systemd.user.targets.river-session = {
      Unit = {
        Description = "River Compositor Session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };

  # lets create wallpaper service/timer
  #systemd.user.timers.wallpaper = {
  #  Install = {
  #    WantedBy = [ "river-session.target" ];
  #  };
  #  Timer = {
  #    OnUnitActiveSec = [ "1s" ];
  #    OnCalendar = [ "*:0/1" ];
  #    Unit = [ "wallpaper.service" ];
  #  };
  #  Unit = {
  #    Description = "Wallpaper Service for River";
  #  };
  #};

  systemd.user.services.wallpaper = {
    Service = {
      ExecStart = [ "%h/.local/bin/waywall wall" ];
    };
    Unit = {
      Description = "Wallpaper Service for River";
    };
    Install = {
      WantedBy = [ "river-session.target" ];
    };
  };

  # lets create a locker for river-session
  systemd.user.services.locker = {
    Unit = {
      Description = [ "Automatic Locker for river-session" ];
    };
    Install = {
      WantedBy = [ "river-session.target" ];
    };
    Service = {
      ExecStart = [ "${pkgs.swayidle}/bin/swayidle -w timeout 60 '~/.local/bin/waywall lock' before-sleep '~/.local/bin/waywall lock' timeout 75 '${pkgs.light}/bin/light -o; ${pkgs.light}/bin/light -S 0' resume '${pkgs.light}/bin/light -I' lock '~/.local/bin/waywall lock'" ];
    };
  };

}
