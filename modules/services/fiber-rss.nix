{ config, lib, pkgs, ... }:
let
  port = 7373;
  appDir = "/home/justin/projects/fiber-rss";
  dataDir = "/home/justin/.local/share/fiber-rss";
in {
  systemd.services.fiber-rss = {
    description = "fiber — minimal RSS reader for blogs and youtube";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    environment = {
      PORT = toString port;
      HOST = "127.0.0.1";
      ORIGIN = "http://127.0.0.1:${toString port}";
      FIBER_RSS_DATA = "${dataDir}/feeds.json";
      NODE_ENV = "production";
    };
    serviceConfig = {
      Type = "simple";
      User = "justin";
      Group = "users";
      WorkingDirectory = appDir;
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${dataDir}";
      ExecStart = "${pkgs.nodejs}/bin/node ${appDir}/build/index.js";
      Restart = "always";
      RestartSec = 3;
    };
  };
}
