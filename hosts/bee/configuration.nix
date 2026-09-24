{ config, lib, pkgs, modulesPath, ... }: {
  
  imports = [
    ./hardware-configuration.nix
    ../../modules/services/default.nix
    # ../../modules/programs/default.nix
    # ../../modules/packages/default.nix
  ];
 
  sops = {
    age.keyFile = "/home/justin/.secrets/nix.age";
    defaultSopsFile = ./secrets.yaml.enc;
    secrets = {
      cloudflare-bee-hole-tunnel-token = {
        mode = "0600";
      };
      cloudflare-dydns-token = {
        mode = "0600";
      };
      github-zen = {
        path = "/home/justin/.ssh/github-zen";
        mode = "0666";
      };
      signal-number = {
        mode = "0600";
      };
      openrouter-api-key = {
        mode = "0600";
      };
    };
  };

  services.cloudflared-bee.enable = true;
  services.ironclaw.enable = false;

  # Basic system settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "bee";
  time.timeZone = "America/Denver";
  system.stateVersion = "25.05";

  networking.networkmanager.enable = true;

  # Essential packages
  environment.systemPackages = with pkgs; [
    vim
    git
    cloudflared
    python3
    git
    fastfetch
    signal-cli
  ];

  programs.nix-ld.enable = true;
  
  # Users
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };

  users.users.justin = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # SSH service
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

  services.beefarm = {
    enable = true;
    domain = "justinmeimar.com";

    sites = let
      placeholder = name: port: {
        inherit port;
        service = {
          description = "Placeholder page for ${name}.justinmeimar.com";
          exec = "${pkgs.python3}/bin/python3 -m http.server ${toString port} "
            + "--bind 127.0.0.1 --directory ${pkgs.writeTextDir "index.html" ''
              <!doctype html>
              <html lang="en">
                <head><meta charset="utf-8"><title>${name}</title></head>
                <body><h1>You've reached ${name}</h1></body>
              </html>
            ''}";
        };
      };
    in {
      bee = placeholder "bee" 8000;
      fossil = placeholder "fossil" 8001;
      dashboards = placeholder "dashboards" 8002;
    };
  };
  
  virtualisation.docker.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    extensions = ps: [ ps.pgvector ];
    settings.listen_addresses = "localhost";
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };
  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # LUKS auto-unlock
  boot.initrd.secrets = {
    "/etc/secrets/luks-keyfile" = "/etc/secrets/luks-keyfile";
  };
  boot.initrd.luks.devices."nixos-enc" = {
    device = "/dev/disk/by-uuid/0ea8a345-3261-40f1-8923-e8ca345f8a0b";
    keyFile = "/etc/secrets/luks-keyfile";
  };
}
