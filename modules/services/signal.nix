{ config, lib, pkgs, ... }:
let
  cfg = config.services.signal-cli-daemon;
  phoneNumberPath = config.sops.secrets.signal-number.path;
in
{
  options.services.signal-cli-daemon = {
    enable = lib.mkEnableOption "signal-cli daemon service";

    endpoint = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1:8080";
      description = "HTTP endpoint for the signal-cli daemon";
    };

    user = lib.mkOption {
      type = lib.types.str;
      default = "justin";
      description = "User to run the signal-cli daemon as";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.signal-cli = {
      description = "signal-cli daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        PHONE=$(cat "$CREDENTIALS_DIRECTORY/signal-number")
        exec ${pkgs.signal-cli}/bin/signal-cli -u "$PHONE" daemon --http ${cfg.endpoint}
      '';

      serviceConfig = {
        User = cfg.user;
        LoadCredential = "signal-number:${phoneNumberPath}";
        Restart = "on-failure";
        RestartSec = "10s";
      };
    };
  };
}

