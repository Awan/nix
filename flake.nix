{
  description = "Home Manager configuration of Abdullah Khabir";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
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
