{ config, pkgs, ... }:
{
  imports = [
    ../../modules/programs/default.nix
  ];
  specifics = {
    git = {
      enable = true;
      userName = "JustinMeimar";
      userEmail = "meimar@ualberta.ca";
    };
    home = {
      enable = true;
      username = "justy";
      homeDirectory = "/home/justy";
      stateVersion = "24.05"; 
    };
  };
}

