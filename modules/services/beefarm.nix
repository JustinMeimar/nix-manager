{ config, lib, ... }:
let
  inherit (lib) filterAttrs mapAttrs' mkEnableOption mkIf mkOption nameValuePair types;
  cfg = config.services.beefarm;
  enabledSites = filterAttrs (_: site: site.enable) cfg.sites;
  managedSites = filterAttrs (_: site: site.service != null) enabledSites;
  names = builtins.attrNames enabledSites;
  ports = map (name: enabledSites.${name}.port) names;
  hostnames = map (name: "${enabledSites.${name}.subdomain}.${cfg.domain}") names;

  siteType = types.submodule ({ name, ... }: {
    options = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to publish this site";
      };
      subdomain = mkOption {
        type = types.str;
        default = name;
        description = "First-level subdomain under services.beefarm.domain";
      };
      port = mkOption {
        type = types.port;
        description = "Port where the service listens on 127.0.0.1";
      };
      service = mkOption {
        type = types.nullOr (types.submodule {
          options = {
            description = mkOption { type = types.str; };
            exec = mkOption { type = types.str; };
            user = mkOption {
              type = types.str;
              default = "justin";
            };
          };
        });
        default = null;
        description = "Optional systemd service; leave null to route an existing service";
      };
    };
  });
in
{
  options.services.beefarm = {
    enable = mkEnableOption "bee-farm service publishing";
    domain = mkOption {
      type = types.str;
      description = "Base domain for published services";
    };
    sites = mkOption {
      type = types.attrsOf siteType;
      default = { };
      description = "Services published through the bee Cloudflare tunnel";
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.services.cloudflared-bee.enable;
        message = "bee-farm requires services.cloudflared-bee.enable";
      }
      {
        assertion = builtins.length ports == builtins.length (lib.unique ports);
        message = "bee-farm sites must use distinct loopback ports";
      }
      {
        assertion = builtins.length hostnames == builtins.length (lib.unique hostnames);
        message = "bee-farm sites must use distinct hostnames";
      }
      {
        assertion = lib.all (name:
          let label = enabledSites.${name}.subdomain;
          in builtins.stringLength label <= 63
            && builtins.match "^[a-z0-9]([a-z0-9-]*[a-z0-9])?$" label != null) names;
        message = "bee-farm subdomains must be valid DNS labels";
      }
    ];

    services.cloudflared.tunnels."bee-hole".ingress = mapAttrs' (_: site:
      nameValuePair "${site.subdomain}.${cfg.domain}"
        "http://127.0.0.1:${toString site.port}") enabledSites;

    systemd.services = mapAttrs' (name: site:
      nameValuePair "beefarm-${name}" {
        description = site.service.description;
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          ExecStart = site.service.exec;
          Restart = "always";
          User = site.service.user;
        };
      }) managedSites;
  };
}
