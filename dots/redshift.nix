{ pkgs, config, lib, ... }:


{
  services.redshift = {
    enable = true;
    latitude = 33.68;
    longitude = 73.04;
    provider = "manual";
    temperature = {
      day = 6500;
      night = 3400;
    };
    settings = {
      redshift = {
        fade = 1;
        gamma = 0.8;
        adjustment-method = "randr";
        transition = 1;
      };
      randr = {
        screen = 0;
        crtc = 0;
      };
      drm = {
        card = "/dev/dri/card0";
        crtc = 0;
      };
    };
  };

}
