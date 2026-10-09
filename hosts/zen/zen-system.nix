{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./site-blocking.nix
  ];
}
