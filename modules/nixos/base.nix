# this is a thin wrapper for NixOS machines to share, not currently used for 
# anything since only one such machine exists.

{ config, lib, pkgs, ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
  ];
}

