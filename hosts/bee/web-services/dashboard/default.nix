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
        add_header X-Content-Type-Options nosniff always;
      '';
      locations."~ (^|/)\\.".extraConfig = "deny all;";
    })
  ];

  services.beefarm.sites.dashboard = {
    subdomain = "html";
    port = 8002;
    anubis.enable = true;
  };

  systemd.tmpfiles.rules = [
    "d ${root} 0755 justin users -"
  ];
}
