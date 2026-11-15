{ pkgs, ... }:
{
  home.packages = import ./dev-packages.nix { inherit pkgs; };
}
