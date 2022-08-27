{
  description = "Home Manager + NixOS configuration of Abdullah Khabir";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
  };

  outputs = { self, nixpkgs, home-manager, river, stacktile, ... }:
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
        extraSpecialArgs.repos = { inherit stacktile river; };
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
