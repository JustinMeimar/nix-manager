{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.beefarm;
 
  publicSites = filterAttrs (name: site: 
    site.enable && site.network != null && site.network.public
  ) cfg.sites;
  
  siteType = types.submodule {
    options = {
      enable = mkEnableOption "this service"; 
      service = mkOption {
        type = types.submodule {
          options = {
            description = mkOption {
              type = types.str;
            };
            exec = mkOption {
              type = types.str;
            };
          };
        };
      }; 
      network = mkOption {
        type = types.nullOr (types.submodule {
          options = {
            port = mkOption {
              type = types.port;
              description = "Service port";
            };
            subdomain = mkOption {
              type = types.str;
              description = "Subdomain for nginx";
            };
            public = mkOption {
              type = types.bool;
              default = false;
              description = "Internal v.s external service";
            };
          };
        });
        default = null;
        description = "Network configuration (null = internal service)";
      };
    };
  };
in {
  options.services.beefarm = {
    enable = mkEnableOption "beefarm"; 
    domain = mkOption {
      type = types.str;
      default = "localhost";
      description = "Base domain for services";
    }; 
    sites = mkOption {
      type = types.attrsOf siteType;
      default = {};
      description = "Services to manage";
    };
  };

  config = mkIf cfg.enable {

    systemd.services = mapAttrs' (name: site: 
      nameValuePair "beefarm-${name}" ({
        enable = site.enable;
        description = site.service.description;
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = site.service.exec;
          Restart = "always";
          User = "justin";
        };
      })
    )cfg.sites;

    services.nginx = mkIf (publicSites != {}) {
      enable = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      recommendedProxySettings = true;
      
      virtualHosts."${cfg.domain}" = {
        locations = mkMerge [
          {
            "/" = {
              return = "200 'Beefarm is running!'";
              extraConfig = "add_header Content-Type text/plain;";
            };
          } 
          ( mapAttrs' (name: site: 
            nameValuePair "/${name}/" {
              proxyPass = "http://127.0.0.1:${toString site.network.port}/";
              extraConfig = "proxy_set_header Host $host;";
            }
          ) publicSites) 
        ];
      }; 
    };
    networking.firewall.allowedTCPPorts = mkIf (publicSites != {}) [ 80 443 ];    
    environment.systemPackages = [ pkgs.nginx ];
  };
}

