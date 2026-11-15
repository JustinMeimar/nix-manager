{ pkgs, ... }:
{
  imports = [ ./nvim.nix ];
  # Retain standalone formatter commands for the Home Manager hosts, while
  # nvim.nix and its plugins can also be imported by NixOS directly.
  home.packages = with pkgs; [
    nixfmt
    libxml2
  ];
}
