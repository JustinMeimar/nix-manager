{ config, lib, pkgs, ...}:
let
  port = 8001;
in {
  services.beefarm.sites.minima = {
    enable = true;

    # systemd service config
    serviceConfig = {
      description = "Minimal Personal Website";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.python3}/bin/python3 -m http.server ${builtins.toString(port)}";
        Restart = "always";
        User = "justin";
        WorkingDir = "/tmp";
      };
    };

    # network config for nginx
    network = {
      port = port;
      subdomain = "habits";
      public = true;
    }; 
  };
}

