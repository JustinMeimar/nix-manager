{ config, lib, pkgs, ...}:
let
  port = 8001;
in {
  # TODO: Add habit tracker!
  services.beefarm.sites.habits = {
    enable = false;

    # systemd service config
    serviceConfig = {
      description = "Custom Localhost Habit Tracker";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.python3}/bin/python3 -m http.server ${builtins.toString(port)}";
        Restart = "always";
        User = "justin";
        WorkingDirectory = "/tmp";
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

