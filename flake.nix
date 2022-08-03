{
  description = "Abdullah Khabir's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        ak = nixosSystem {
          inherit system;
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./nixos/configuration.nix ];
          specialArgs = { inherit inputs; };
        };
      };

      homeConfigurations = {
        "ak@x1c" = homeManagerConfiguration {
          inherit system;
          pkgs = nixpkgs.legacyPackages.${system};
          #modules = [ ./dots/home.nix ];
          homeDirectory = "/home/ak/";
          username = "ak";
          configuration.imports = [ ./dots/home.nix ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
