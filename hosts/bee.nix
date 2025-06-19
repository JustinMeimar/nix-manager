{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
    ../modules/server.nix
  ];

  programs.git.userEmail = "meimar@ualberta.ca";
  programs.git.userName = "JustinMeimar";
}

