{ pkgs, ... }@args:
let
  staticSite = import ../static-site.nix args;
  page = pkgs.writeTextDir "index.html" ''
    <!doctype html>
    <html lang="en">
      <head><meta charset="utf-8"><title>Fossil</title></head>
      <body><h1>Fossil: coming soon</h1></body>
    </html>
  '';
in
{
  imports = [ (staticSite "fossil" { root = page; }) ];

  services.beefarm.sites.fossil = {
    port = 8001;
    anubis.enable = true;
  };
}
