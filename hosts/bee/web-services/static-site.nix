{ config, lib, ... }:
name: virtualHost:
let
  farm = config.services.beefarm;
  site = farm.sites.${name};
  hostname = "${site.subdomain}.${farm.domain}";
in
{
  services.nginx = lib.mkIf (farm.enable && site.enable) {
    enable = true;
    virtualHosts.${hostname} = lib.mkMerge [
      {
        listen = [ { addr = "127.0.0.1"; port = site.port; } ];
      }
      virtualHost
    ];
  };
}
