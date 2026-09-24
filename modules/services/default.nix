{ config, lib, pkgs, ... }:  {
  imports = [
    ./beefarm.nix
    ./cloudflared.nix
    ./signal.nix
    ./ironclaw.nix
  ];
}
