{ config, lib, pkgs, ...}:
let
  port = 8001;
in {
  services.beefarm.sites.habits = {
    enable = true;
    
    # systemd service 
    service = {
      description = "Todo... add a localhost habit tracker!";
      exec = "${pkgs.python3}/bin/python3 -m http.server ${builtins.toString(port)}";
    };

    # nginx reverse proxy for service
    network = {
      port = port;
      subdomain = "habits";
      public = true;
    }; 
  };
}

