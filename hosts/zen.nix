
{ config, pkgs, ... }:

{
  imports = [
    ../home.nix
    ../modules/laptop.nix
  ];
}

