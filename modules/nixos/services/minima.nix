{ config, lib, pkgs, ... }:
let
  minima = builtins.fetchGit {
    url = "https://github.com/JustinMeimar/minima";
    rev = "8217d126a5134ffa875d4516c253baa8edc64103";
  };
  port = 8000;
in {
  services.beefarm.sites.minima = {
    enable = true;

    # systemd service config
    serviceConfig = {
      description = "Minimal Personal Website";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.python3}/bin/python3 -m http.server ${builtins.toString(port)} --directory ${minima}";
        Restart = "always";
        User = "justin";
      };
    };

    # network config for nginx
    network = {
      port = port;
      subdomain = "minima";
      public = true;
    }; 
  };  
}

