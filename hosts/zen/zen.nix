{ config, pkgs, ... }:

{
  imports = [
    ../../modules/programs/default.nix
    ../../modules/packages/default.nix
  ];
  
  home = {
    username = "justin";
    homeDirectory = "/home/justin";
    stateVersion = "24.05";
  };
  
  programs.git = {
    enable = true;
    delta.enable = false;
    settings = {
      user = {
        name = "justinmeimar";
        email = "meimar@ualberta.ca";
      };
      core.editor = "vim";
      delta = {
        navigate = true;
        side-by-side = true;
      };
      merge.conflictstyle = "zdiff3";
    };
  }; 
  
  # allow home-manager to manage itself
  programs.home-manager.enable = true;
}

