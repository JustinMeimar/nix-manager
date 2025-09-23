{ config, lib, pkgs, ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./services/beefarm.nix
    ./services/minima.nix
    ./services/habits.nix
  ];

  services.beefarm = {
    enable = true;
    domain = "localhost";
  };
}

