{ lib, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = import ./ssh-hosts.nix { inherit lib; };
  };
}
