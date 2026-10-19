{ pkgs, ... }@args:
let
  staticSite = import ../static-site.nix args;
  page = pkgs.writeTextDir "index.html" ''
    <!doctype html>
    <html lang="en">
      <head><meta charset="utf-8"><title>Bookshelf</title></head>
      <body><h1>Bookshelf: coming soon</h1></body>
    </html>
  '';
in
{
  imports = [ (staticSite "bookshelf" { root = page; }) ];

  services.beefarm.sites.bookshelf = {
    port = 8003;
    anubis.enable = true;
  };
}
