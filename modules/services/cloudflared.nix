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
    sops.secrets.cloudflare-bee-hole-tunnel-token.restartUnits = [
      "cloudflared-tunnel-bee-hole.service"
    ];

    services.cloudflared = {
      enable = true;
      tunnels = {
        "bee-hole" = {
          credentialsFile = beeHoleToken;
          default = "http_status:404";
        };
      };
    };
  };
}
