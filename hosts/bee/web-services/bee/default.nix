{ config, lib, pkgs, ... }:
let
  farm = config.services.beefarm;
  siteNames = lib.filter
    (name: name != "bee" && farm.sites.${name}.enable)
    (builtins.attrNames farm.sites);
  links = lib.concatMapStringsSep "\n" (name:
    let hostname = "${farm.sites.${name}.subdomain}.${farm.domain}";
    in ''<li><a href="https://${hostname}/">${hostname}<span aria-hidden="true">↗</span></a></li>'') siteNames;
  html = pkgs.writeText "bee-index.html"
    (builtins.replaceStrings [ "@SERVICE_LINKS@" ] [ links ] (builtins.readFile ./index.html));
  page = pkgs.runCommand "bee-site" { } ''
    mkdir -p "$out"
    cp ${html} "$out/index.html"
    cp ${./my-goph-bee.png} "$out/my-goph-bee.png"
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
