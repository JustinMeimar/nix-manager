{ config, pkgs, ... }:
let beeHoleToken = config.sops.secrets.cloudflare-bee-hole-tunnel-token.path;
in
{
  imports = [
    ../programs/sops/sops.nix
    ../modules/nixos/base.nix
    ../modules/nixos/services/beefarm.nix
    
    # Todo: Debug stale minima commit problem
    # ../modules/nixos/services/minima.nix
  ];
  
  environment.systemPackages = [
    pkgs.cloudflared
    pkgs.python3
  ];
 
  services.cloudflared = {
    enable = true;
    tunnels = {
      "bee-hole" = {
        credentialsFile = beeHoleToken;
        ingress = {
          "justinmeimar.com" = "http://localhost:8001";
          "gazbolt.justinmeimar.com" = "http://localhost:8002";
          "thymos.justinmeimar.com" = "http://localhost:8002";
        };
        default = "http_status:404"; 
      };
    };
  };
  
  services.beefarm = {
    enable = true;
    domain = "localhost";
  };
}

