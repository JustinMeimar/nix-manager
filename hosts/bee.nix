{ config, pkgs, ... }:

{
  imports = [
    ../modules/nixos/base.nix
  ];
  
  # specifics = {
  #   git = {
  #     enable = true;
  #     userName = "JustinMeimar";
  #     userEmail = "meimar@ualberta.ca";
  #   };
  # };
}

