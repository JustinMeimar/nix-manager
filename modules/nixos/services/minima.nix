{ config, lib, pkgs, ... }:
let
  minima = builtins.fetchGit {
    url = "https://github.com/JustinMeimar/minima";
    ref = "HEAD";
  };
  port = 8000;
in {
  services.beefarm.sites.minima = {
    enable = true;

    # systemd service config
    service = {
      description = "Minimal Personal Site";
      exec = "${pkgs.python3}/bin/python3 -m http.server " + 
             "${builtins.toString(port)} --directory ${minima}";
    };

    # network config for nginx
    network = {
      port = port;
      subdomain = "minima";
      public = true;
    }; 
  };  
}

