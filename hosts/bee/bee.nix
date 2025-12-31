{ config, pkgs, ... }:
let beeHoleToken = config.sops.secrets.cloudflare-bee-hole-tunnel-token.path;
in
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ../../modules/services/default.nix
  ];

  environment.systemPackages = [
    pkgs.cloudflared
    pkgs.python3
  ]; 
  
  sops = { 
    age.keyFile = "/home/justin/.secrets/nix.age";
    defaultSopsFile = ./secrets.yaml.enc;
    secrets = {
      cloudflare-bee-hole-tunnel-token = {
        mode = "0600";
      };
      cloudflare-dydns-token = {
        mode = "0600";
      };
      github-zen = {
        path = "/home/justin/.ssh/github-zen";
        mode = "0666";
      };
    };
  };
  services.beefarm = {
    enable = true;
    domain = "localhost";
  };
}

