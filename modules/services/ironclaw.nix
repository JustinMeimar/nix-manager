{ config, lib, pkgs, ... }:
let
  cfg = config.services.ironclaw;
in
{
  options.services.ironclaw = {
    enable = lib.mkEnableOption "ironclaw AI agent daemon";

    user = lib.mkOption {
      type = lib.types.str;
      default = "justin";
      description = "User to run the ironclaw daemon as";
    };

    workingDirectory = lib.mkOption {
      type = lib.types.str;
      default = "/home/${cfg.user}";
      description = "Working directory for ironclaw";
    };

    signalEndpoint = lib.mkOption {
      type = lib.types.str;
      default = "127.0.0.1:8080";
      description = "Signal-cli HTTP endpoint";
    };
  };

  config = lib.mkIf cfg.enable {
    # Automatically enable signal-cli-daemon as a dependency
    services.signal-cli-daemon = {
      enable = true;
      endpoint = cfg.signalEndpoint;
      user = cfg.user;
    };

    systemd.services.ironclaw = {
      description = "IronClaw AI Agent Daemon";
      after = [ "network.target" "postgresql.service" "signal-cli.service" ];
      wants = [ "signal-cli.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        WorkingDirectory = cfg.workingDirectory;
        ExecStart = "/home/${cfg.user}/.cargo/bin/ironclaw";
        Restart = "on-failure";
        RestartSec = "10s";
        Environment = [
          "HOME=/home/${cfg.user}"
        ];
      };
    };
  };
}
