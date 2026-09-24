{ pkgs, ... }:
let
  source = "/home/justin/nix-manager/hosts/bee/web-services/dashboard/public";
  root = "/srv/beefarm/dashboard/public";
  index = pkgs.writeTextDir "index.html" (builtins.readFile ./index.html);
in
{
  services.beefarm.sites.dashboard.port = 8002;

  systemd.services.nginx.serviceConfig.BindReadOnlyPaths = [ "${source}:${root}" ];

  systemd.tmpfiles.rules = [
    "d /srv/beefarm 0755 root root -"
    "d /srv/beefarm/dashboard 0755 root root -"
    "d ${root} 0755 root root -"
  ];

  services.nginx = {
    enable = true;
    virtualHosts."dashboard.justinmeimar.com" = {
      listen = [ { addr = "127.0.0.1"; port = 8002; } ];
      root = root;
      extraConfig = ''
        autoindex off;
        disable_symlinks on;
        if_modified_since off;
        etag off;
        add_header Cache-Control "no-store" always;
        add_header X-Content-Type-Options nosniff always;
      '';
      locations."= /".extraConfig = ''
        root ${index};
        try_files /index.html =404;
        default_type text/html;
      '';
      locations."= /__listing__/".extraConfig = ''
        alias ${root}/;
        index __beefarm_directory_listing__.html;
        autoindex on;
        autoindex_format json;
      '';
      locations."~ (^|/)\\." = {
        return = "404";
      };
    };
  };
}
