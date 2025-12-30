{ config, lib, pkgs, ... }:
let beeHoleToken = config.sops.secrets.cloudflare-bee-hole-tunnel-token.path;
in
{
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
}
