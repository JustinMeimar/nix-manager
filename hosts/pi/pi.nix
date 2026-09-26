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
      username = "justin";
      homeDirectory = "/home/justin";
      stateVersion = "24.05"; 
    };
  };
}

