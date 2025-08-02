{ config, lib, pkgs, modulesPath, ... }:
{ 
  # Basic system settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "bee";
  time.timeZone = "America/Denver";
  system.stateVersion = "25.05";

  networking.networkmanager.enable = true;

  # Users
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };

  users.users.justin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # SSH service
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
    settings.PermitRootLogin = "yes";
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # Essential packages
  environment.systemPackages = with pkgs; [ vim git neovim ];

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
    fallbackToPassword = true;  # Safety net
  };
}

