{ pkgs, lib, config, ... }:


{
  # Create a systemd service for wlsunset
  systemd.user.services.wlsunset = {
    Unit = {
      Description = [ "Sunset service for wayland" ];
    };
    Install = {
      WantedBy = [ "river-session.target" ];
    };
    Service = {
      ExecStart = [ "${pkgs.wlsunset}/bin/wlsunset -T 6500 -t 3400 -l 33.68 -L 73.04 -g 1.0" ];
    };
  };

}
