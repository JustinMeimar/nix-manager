{ config, lib, ... }@args:
let
  staticSite = import ../static-site.nix args;
  root = "/srv/beefarm/dashboard";
in
{
  imports = [
    (staticSite "dashboard" {
      inherit root;
      extraConfig = ''
        autoindex on;
        disable_symlinks on;
      '';
    })
  ];

  services.beefarm.sites.dashboard = {
    subdomain = "html";
    port = 8002;
    anubis.enable = true;
  };

  systemd.tmpfiles.rules = [
    "d /srv/beefarm 0750 justin nginx -"
    "d ${root} 0750 justin nginx -"
  ];
}
