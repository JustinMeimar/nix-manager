{ config, pkgs, ... }:
{
  imports = [
    ../modules/home-manager/base.nix
  ];
  specifics = {
    git = {
      enable = true;
      userName = "JustinMeimar";
      userEmail = "meimar@ualberta.ca";
    };
  };
}

