{ config, lib, pkgs, ... }:
let port = 8004;
in {
  services.beefarm.sites.habits = {
    enable = true;

    inherit port;
    service = {
      description = "Todo... add a localhost habit tracker!";
      exec = "${pkgs.python3}/bin/python3 -m http.server ${
          builtins.toString (port)
        } --bind 127.0.0.1";
    };
  };
}
