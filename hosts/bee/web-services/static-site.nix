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
        extraConfig = ''
          # These sites only publish files; no uploads or application endpoints.
          if ($request_method !~ ^(GET|HEAD)$) { return 405; }
          client_max_body_size 1k;
          access_log off;
          error_log /dev/null;
          add_header X-Content-Type-Options nosniff always;
        '';
        locations."~ (^|/)\\.".extraConfig = "deny all;";
      }
      virtualHost
    ];
  };
}
