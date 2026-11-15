{ pkgs, ... }:
{
  home.packages = import ./cli-packages.nix { inherit pkgs; };
}
