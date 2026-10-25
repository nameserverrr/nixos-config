{
  description = "nameserverrr's NixOS config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixos-autoupdate.url = "github:hmoens/nixos-autoupdate";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };
  outputs =
    { self, nixpkgs, home-manager, flake-utils, plasma-manager, nixos-autoupdate, ... }@attrs:
    {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            ./machines/pc.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;
              home-manager.users.callum = { pkgs, lib, config, osConfig, ... }: {
                imports = [
                  plasma-manager.homeModules.plasma-manager
                  ./home-manager/callum.nix
                ];
              };
            }
            nixos-autoupdate.nixosModules.default
            ({ ... }: {
              nixos-autoupdate = {
                enable = true;
                repoUrl = "https://github.com/nameserverrr/nixos-config";
                branch = "main";
                flakeOutput = "nixosConfigurations.pc";
                frequency = "10min";
              };
            })
          ];
        };
        iso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
            ./machines/iso.nix
          ];
        };
      };
    };
}
