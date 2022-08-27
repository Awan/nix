{ lib, pkgs, repos, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      river = super.river.overrideAttrs (old: {
        version = repos.river.rev;
        src = repos.river.outPath;
      });

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

      waylock = pkgs.stdenv.mkDerivation rec {
        pname = "waylock";
        version = repos.waylock.rev;
        src = repos.waylock.outPath;

        installFlags = [ "PREFIX=${placeholder "out"}" ];
        nativeBuildInputs = with pkgs; [ pkg-config zig wayland scdoc];
        buildInputs = with pkgs; [ zig wayland-protocols pam libxkbcommon ];
        dontConfigure = true;

        preBuild = ''
          export HOME="$(mktemp -d)"
          '';

        installPhase = ''
          zig build -Drelease-safe -Dcpu=baseline install --prefix $out
          '';

        meta = with lib; {
          description = "A screen locker for wayland";
          homepage = "https://github.com/ifreund/waylock";
          license = licenses.isc;
          platforms = platforms.linux;
        };
      };

    })
  ];
}
