{ ... }:
{
  imports = [
    ./bee
    ./bookshelf
    ./dashboard
    ./fossil
  ];

  # Hide host data beneath /srv; expose only the public directory, read-only.
  systemd.services.nginx.serviceConfig = {
    TemporaryFileSystem = [ "/srv:ro" ];
    BindReadOnlyPaths = [ "/srv/beefarm/dashboard" ];
    InaccessiblePaths = [ "-/mnt" "-/media" "/var/lib" ];
  };
}
