{ config, lib, ... }:
let
  inherit (lib) filterAttrs mapAttrs' mkEnableOption mkIf mkOption nameValuePair types;
  cfg = config.services.beefarm;
  enabledSites = filterAttrs (_: site: site.enable) cfg.sites;
  names = builtins.attrNames enabledSites;
  ports = map (name: enabledSites.${name}.port) names;
  protectedSites = filterAttrs (_: site: site.anubis.enable) enabledSites;
  anubisPorts = map (name: protectedSites.${name}.anubis.port) (builtins.attrNames protectedSites);
  hostnames = map (name: "${enabledSites.${name}.subdomain}.${cfg.domain}") names;

  siteType = types.submodule ({ name, config, ... }: {
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
      anubis = {
        enable = mkEnableOption "Anubis protection for this site";
        port = mkOption {
          type = types.port;
          default = 10000 + config.port;
          description = "Loopback port where Anubis accepts tunnel traffic";
        };
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
        assertion = builtins.length (ports ++ anubisPorts)
          == builtins.length (lib.unique (ports ++ anubisPorts));
        message = "bee-farm site and Anubis ports must be distinct";
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
        "http://127.0.0.1:${toString (if site.anubis.enable then site.anubis.port else site.port)}") enabledSites;

    services.anubis.instances = lib.mapAttrs (name: site: {
      settings = {
        BIND = "127.0.0.1:${toString site.anubis.port}";
        BIND_NETWORK = "tcp";
        TARGET = "http://127.0.0.1:${toString site.port}";
        REDIRECT_DOMAINS = "${site.subdomain}.${cfg.domain}";
      };
    }) protectedSites;
  };
}
