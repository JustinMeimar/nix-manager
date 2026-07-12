{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./networking.nix
  ] ++ (if builtins.pathExists ./local.nix then [ ./local.nix ] else []);
}
