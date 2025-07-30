{ config, lib, pkgs, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ../../programs/sops/sops.nix
  ];
}

