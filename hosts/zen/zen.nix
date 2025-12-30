{ config, pkgs, ... }:

{
  imports = [
    ../../modules/programs/default.nix
  ];
  
  home.packages = [
    pkgs.age
    pkgs.bat
    pkgs.dust
    pkgs.github-cli
    pkgs.htop
    pkgs.just
    pkgs.jq
    pkgs.lazygit
    pkgs.mutagen
    pkgs.ripgrep
    pkgs.rr
    pkgs.sshfs
    pkgs.tree 
    pkgs.wget
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
  
  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "24.05"; 
  };
  
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "justinmeimar";
        email = "meimar@ualberta.ca";
      };
    }; 
  }; 
  
  # allow home-manager to manage itself
  programs.home-manager.enable = true;
}

