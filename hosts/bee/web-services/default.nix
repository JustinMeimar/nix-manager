{ ... }:
{
  imports = [
    ./bee
    ./bookshelf
    ./dashboard
    ./fossil
  ];

  # Cover malformed requests handled before a virtual host is selected, too.
  services.nginx.logError = "/dev/null";
  services.nginx.commonHttpConfig = "access_log off;";

  # Hide host data beneath /srv; expose only the public directory, read-only.
  systemd.services.nginx.serviceConfig = {
    TemporaryFileSystem = [ "/srv:ro" ];
    BindReadOnlyPaths = [ "/srv/beefarm/dashboard" ];
    InaccessiblePaths = [ "-/mnt" "-/media" "/var/lib" ];
    LimitCORE = 0;
  };
}
