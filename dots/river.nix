{ config, pkgs, lib, ... }:

{
  # move river configuration file to its directory...
  home.file.".config/river/init".source =
    config.lib.file.mkOutOfStoreSymlink ./river/river-configuration;

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
      ExecStart = [ "%h/.local/bin/river-wallpaper" ];
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
      ExecStart = [ "${pkgs.swayidle}/bin/swayidle -w timeout 60 '${pkgs.swaylock}/bin/swaylock -f -i ~/nix/dots/river/locker.jpeg' before-sleep '${pkgs.swaylock}/bin/swaylock -f -i ~/nix/dots/river/locker.jpeg' timeout 75 '${pkgs.light}/bin/light -O; ${pkgs.light}/bin/light -S 0' resume '${pkgs.light}/bin/light -I' lock '${pkgs.swaylock}/bin/swaylock -f -i ~/nix/dots/river/locker.jpeg'" ];
    };
  };

}
