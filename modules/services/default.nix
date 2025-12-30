{ config, lib, pkgs, ... }:  { 
  imports = [
    ./beefarm.nix
    ./minima.nix
    ./cloudflared.nix
  ];
}

