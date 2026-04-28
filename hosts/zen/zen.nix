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
    signing.format = null;
    settings = {
      user = {
        name = "justinmeimar";
        email = "meimar@ualberta.ca";
      };
      core.editor = "vim";
      merge.conflictstyle = "zdiff3";
    };
  };

  programs.delta.enable = false; 
  
  # allow home-manager to manage itself
  programs.home-manager.enable = true;
}

