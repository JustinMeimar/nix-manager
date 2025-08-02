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
      mkHome = system: modules: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = system;
          config.allowUnfree = true;
        };
        inherit modules;
      };

      mkSystem = system: modules: nixpkgs.lib.nixosSystem {
        system = system;
        modules = modules;
      };

    in {      
      homeConfigurations = {
        "justin@zen" = mkHome "x86_64-linux" [
          ./hosts/zen.nix
          nixvim.homeManagerModules.nixvim
          sops.homeManagerModules.sops
        ];
                
        "justin@work" = mkHome "x86_64-linux" [
          ./hosts/work.nix
          nixvim.homeManagerModules.nixvim
        ];
      };

      nixosConfigurations = {
        "bee" = mkSystem "x86_64-linux" [
          ./hosts/bee.nix
          sops.nixosModules.sops
        ];
      };
    };
}

