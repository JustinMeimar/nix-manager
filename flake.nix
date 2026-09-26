{
  description = "Justin's Nix Flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";

    home-manager-pi = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixos-raspberrypi/nixpkgs";
    };

    # add home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # add nixvim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # add sops-nix
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { nixpkgs, nixos-raspberrypi, home-manager, home-manager-pi, nixvim, sops, plasma-manager, ... }:
    let
      mkHome = system: modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
          modules = modules ++ [
            nixvim.homeModules.nixvim
          ];
        };

      mkSystem = system: modules:
        nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./modules/nix-maintenance.nix
            { nixpkgs.pkgs = import nixpkgs { inherit system; config.allowUnfree = true; }; }
          ] ++ modules;
        };

      mkDevShells = system:
        let
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
            config.android_sdk.accept_license = true;
          };
        in
        import ./shells { inherit pkgs; };

    in {
      homeConfigurations = {
        "justin@bee" = mkHome "x86_64-linux" [
          ./hosts/bee/bee.nix
        ];
      };

      nixosConfigurations = {
        "pi" = nixos-raspberrypi.lib.nixosSystem {
          modules = [
            ./modules/nix-maintenance.nix
            nixos-raspberrypi.nixosModules.raspberry-pi-5.base
            nixos-raspberrypi.nixosModules.raspberry-pi-5.page-size-16k
            nixos-raspberrypi.nixosModules.raspberry-pi-5.display-vc4
            ./hosts/pi/configuration.nix
            home-manager-pi.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.justin = import ./hosts/pi/pi.nix;
            }
          ];
        };
        "bee" = mkSystem "x86_64-linux" [
          ./hosts/bee/configuration.nix
          sops.nixosModules.sops
        ];
        "zen" = mkSystem "x86_64-linux" [
          ./hosts/zen/zen-system.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.justin = import ./hosts/zen/zen.nix;
            home-manager.extraSpecialArgs = { inherit nixvim; };
            home-manager.sharedModules = [ nixvim.homeModules.nixvim plasma-manager.homeModules.plasma-manager ];
          }
        ];
      };

      devShells = {
        x86_64-linux = mkDevShells "x86_64-linux";
        aarch64-linux = mkDevShells "aarch64-linux";
      };
    };
}
