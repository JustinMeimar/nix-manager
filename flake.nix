{
  description = "Justin's Nix Flake";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
  };

  outputs = { nixpkgs, home-manager, nixvim, sops, ... }:
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
          modules = modules;
        };

      mkDevShells = system:
        let
          pkgs = import nixpkgs {
            system = system;
          };
        in
        import ./shells { inherit pkgs; };

    in {
      homeConfigurations = {
        "justin@zen" = mkHome "x86_64-linux" [
          ./hosts/zen/zen.nix
          sops.homeManagerModules.sops
        ];
        "justin@work" = mkHome "x86_64-linux" [
          ./hosts/work/work.nix
        ];
        "justy@pi" = mkHome "aarch64-linux" [
          ./hosts/pi/pi.nix
        ];
        "justin@bee" = mkHome "x86_64-linux" [
          ./hosts/bee/bee.nix
        ];
      };

      nixosConfigurations = {
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
            home-manager.sharedModules = [ nixvim.homeModules.nixvim ];
          }
        ];
      };

      devShells = {
        x86_64-linux = mkDevShells "x86_64-linux";
        aarch64-linux = mkDevShells "aarch64-linux";
      };
    };
}

