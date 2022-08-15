{ lib, pkgs, repos, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      river = super.river.overrideAttrs (old: {
        version = repos.river.rev;
        src = repos.river.outPath;
      });

      wlopm = pkgs.stdenv.mkDerivation rec {
        pname = "wlopm";
        version = repos.wlopm.rev;
        src = repos.wlopm.outPath;

        installFlags = [ "PREFIX=${placeholder "out"}" ];
        buildInputs = with pkgs; [ wayland wayland-protocols ];

        meta = with lib; {
          description = "Wayland output power management";
          license = licenses.gpl3Only;
          platforms = platforms.linux;
        };
      };

      stacktile = pkgs.stdenv.mkDerivation rec {
        pname = "stacktile";
        version = repos.stacktile.rev;
        src = repos.stacktile.outPath;

        installFlags = [ "PREFIX=${placeholder "out"}" ];
        buildInputs = with pkgs; [ wayland wayland-protocols ];

        meta = with lib; {
          description = "A layout generator for the river wayland compositor";
          homepage = "https://git.sr.ht/~leon_plickat/stacktile";
          license = licenses.gpl3Only;
          platforms = platforms.linux;
        };
      };

    })
  ];
}
