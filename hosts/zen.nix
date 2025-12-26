{ config, pkgs, ... }:

{
  imports = [
    ../modules/home-manager/base.nix
    ../programs/sops/sops.nix
  ];
  
  home.packages = [
    pkgs.cloc
    pkgs.docker-compose
    pkgs.zathura
    pkgs.typst
    pkgs.tinymist
    pkgs.ninja
    pkgs.sops
    pkgs.boost
    pkgs.opam
    pkgs.ocaml
    pkgs.dune_3
    pkgs.radare2
    pkgs.uv
    pkgs.ruff
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

