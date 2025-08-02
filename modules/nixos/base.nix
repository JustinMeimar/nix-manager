{ config, lib, pkgs, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ../modules/home-manager/base.nix
    ../../programs/sops/sops.nix
  ]; 
}

