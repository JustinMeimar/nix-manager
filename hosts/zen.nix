{ config, pkgs, ... }:

{
  imports = [
    ../modules/home-manager/base.nix
    ../programs/sops/sops.nix
  ];
  
  home.packages = [
    pkgs.docker-compose
    pkgs.zathura
    pkgs.typst
    pkgs.tinymist
    pkgs.ninja
    pkgs.sops
    pkgs.nodejs_23
    pkgs.boost
    pkgs.opam
  ];

  specifics = {
    git = {
      enable = true;
      userName = "JustinMeimar";
      userEmail = "meimar@ualberta.ca";
    };
    home = {
      enable = true;
      username = "justin";
      homeDirectory = "/home/justin";
      stateVersion = "24.05"; 
    };
  }; 
}

