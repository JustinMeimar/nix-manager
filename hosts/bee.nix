{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
    ../modules/server.nix
  ];
}

