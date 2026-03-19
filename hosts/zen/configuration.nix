{ config, lib, pkgs, modulesPath, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "zen";
  time.timeZone = "America/Edmonton";
  i18n.defaultLocale = "en_CA.UTF-8";
  system.stateVersion = "25.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.graphics.enable = true;
  hardware.amdgpu.initrd.enable = true;
  hardware.bluetooth.enable = true;

  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.3" "1.0.0.3" ];

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.xserver.xkb.layout = "us";
  services.libinput.enable = true;
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];
  services.power-profiles-daemon.enable = true;
  services.fwupd.enable = true;

  environment.sessionVariables = {
    TERMINAL = "alacritty";
    EDITOR = "vim";
  };


  users.users.justin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "docker" "lp" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  virtualisation.docker.enable = true;


  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    neovim
    wget
    curl
    firefox
    alacritty
    claude-code
    google-chrome
    obsidian
    zotero
    bitwarden-desktop
    brave
    discord
    htop
    psmisc
    usbutils
  ];


  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];
}
