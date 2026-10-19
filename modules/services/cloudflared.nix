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
    systemd.services.cloudflared-tunnel-bee-hole.serviceConfig = {
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      PrivateDevices = true;
      NoNewPrivileges = true;
      CapabilityBoundingSet = "";
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      RestrictSUIDSGID = true;
      RestrictNamespaces = true;
      RestrictRealtime = true;
      LockPersonality = true;
      RestrictAddressFamilies = [ "AF_UNIX" "AF_INET" "AF_INET6" ];
      InaccessiblePaths = [ "/srv" "-/mnt" "-/media" "/var/lib" ];
      UMask = "0077";
      # Tunnel error messages can contain request URLs and other visitor data.
      StandardOutput = "null";
      StandardError = "null";
      LimitCORE = 0;
    };

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
