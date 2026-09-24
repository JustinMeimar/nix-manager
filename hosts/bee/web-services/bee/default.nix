{ config, lib, pkgs, ... }@args:
let
  staticSite = import ../static-site.nix args;
in
{
  imports = [ (staticSite "bee" { root = import ./page.nix args; }) ];

  services.beefarm.sites.bee = {
    port = 8000;
    anubis.enable = true;
  };
}
