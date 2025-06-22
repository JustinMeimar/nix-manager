{ config, lib, pkgs, modulesPath, ... }:
{ 
  imports = [
    ./hardware-configuration.nix
    ./../../modules/nixos/base.nix
  ];

  networking.hostName = "bee";
}

