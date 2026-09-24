{ config, lib, pkgs, ... }:
let
  farm = config.services.beefarm;
  siteNames = lib.filter
    (name: name != "bee" && farm.sites.${name}.enable)
    (builtins.attrNames farm.sites);
  links = lib.concatMapStringsSep "\n          " (name:
    let hostname = "${farm.sites.${name}.subdomain}.${farm.domain}";
    in ''<li><a href="https://${hostname}/">${hostname}</a></li>'') siteNames;
  page = pkgs.writeTextDir "index.html" ''
    <!doctype html>
    <html lang="en">
      <head><meta charset="utf-8"><title>Bee services</title></head>
      <body>
        <h1>Bee services</h1>
        <ul>
          ${links}
        </ul>
      </body>
    </html>
  '';
in
{
  services.beefarm.sites.bee = {
    port = 8000;
  };

  services.nginx.virtualHosts."bee.justinmeimar.com" = {
    listen = [ { addr = "127.0.0.1"; port = 8000; } ];
    root = page;
    extraConfig = ''
      if_modified_since off;
      etag off;
      add_header Cache-Control "no-store" always;
    '';
  };
}
