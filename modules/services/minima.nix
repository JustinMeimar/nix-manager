{ config, lib, pkgs, ... }:
let
  minima = builtins.fetchGit {  
    url = "https://github.com/JustinMeimar/minima";
    rev = "dfde5c696e3f0be8355d6b82c538f7bc069b7951";
  };
  port = 8001;
in {
  services.beefarm.sites.minima = {
    enable = true;

    # systemd service config
    service = {
      description = "Minimal Personal Site";
      exec = "${pkgs.python3}/bin/python3 -m http.server "
           + "${builtins.toString (port)} --directory ${minima}";
    };

    # network config for nginx
    network = {
      port = port;
      subdomain = "minima";
      public = true;
    };
  };
}

