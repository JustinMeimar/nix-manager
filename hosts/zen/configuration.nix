{ config, lib, pkgs, modulesPath, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "zen";
  time.timeZone = "America/Denver";
  system.stateVersion = "25.05";

  # Boot — UEFI with systemd-boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel — latest for best AMD support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # AMD GPU
  hardware.graphics.enable = true;
  hardware.amdgpu.initrd.enable = true;

  # Networking
  networking.networkmanager.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Sound — pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # GNOME desktop
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Touchpad
  services.libinput.enable = true;

  # Power management — Framework laptop
  services.power-profiles-daemon.enable = true;
  services.fwupd.enable = true;

  # Users
  users.users.justin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "docker" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # SSH
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    neovim
    wget
    firefox
    alacritty
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-emoji
  ];
}
