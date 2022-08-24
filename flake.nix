{
  description = "Home Manager + NixOS configuration of Abdullah Khabir";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wlopm = {
      url = "git+https://git.sr.ht/~leon_plickat/wlopm";
      flake = false;
    };
    river = {
      type = "git";
      url = "https://github.com/ifreund/river";
      submodules = true;
      flake = false;
    };
    stacktile = {
      type = "git";
      url = "https://git.sr.ht/~leon_plickat/stacktile";
      rev = "0e5baf19920c5cc92bd0d00c37bf0a0192f9842d";
      flake = false;
    };
    waylock = {
      type = "git";
      url = "https://github.com/ifreund/waylock";
      rev = "d8d944558378071df1ffa3c93e887dd2293aaef2";
      submodules = true;
      flake = false;
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = { self, nixpkgs, home-manager, wlopm, river, stacktile, waylock, hyprland, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.ak = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./dots/home.nix
          {
            home = {
              username = "ak";
              homeDirectory = "/home/ak";
              stateVersion = "22.11";
            };
          }
        ];
        extraSpecialArgs.repos = { inherit wlopm stacktile river waylock; };
      };

      nixosConfigurations.x1c = nixpkgs.lib.nixosSystem {
        #inherit pkgs;
        system = "x86_64-linux";
        modules = [
          ./nixos/configuration.nix
          ./nixos/hardware-configuration.nix
        ];
      };
    };
}
