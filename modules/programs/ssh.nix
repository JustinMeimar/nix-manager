{ lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = import ./ssh-hosts.nix { inherit lib; };
  };
}
