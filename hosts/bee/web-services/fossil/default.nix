{ pkgs, ... }:
let
  page = pkgs.writeTextDir "index.html" ''
    <!doctype html>
    <html lang="en">
      <head><meta charset="utf-8"><title>Fossil</title></head>
      <body><h1>Fossil: coming soon</h1></body>
    </html>
  '';
in
{
  services.beefarm.sites.fossil = {
    port = 8001;
  };

  services.nginx.virtualHosts."fossil.justinmeimar.com" = {
    listen = [ { addr = "127.0.0.1"; port = 8001; } ];
    root = page;
    extraConfig = ''
      if_modified_since off;
      etag off;
      add_header Cache-Control "no-store" always;
    '';
  };
}
