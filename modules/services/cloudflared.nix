{ config, lib, pkgs, ... }:
let
  cfg = config.services.cloudflared-bee;
  beeHoleToken = config.sops.secrets.cloudflare-bee-hole-tunnel-token.path;
in
{
  options.services.cloudflared-bee = {
    enable = lib.mkEnableOption "cloudflared tunnel for bee";
  };

  config = lib.mkIf cfg.enable {
    services.cloudflared = {
      enable = true;
      tunnels = {
        "bee-hole" = {
          credentialsFile = beeHoleToken;
          ingress = {
            "bee.justinmeimar.com" = "http://localhost:3000";
          };
          default = "http_status:404"; 
        };
      };
    };
  };
}

