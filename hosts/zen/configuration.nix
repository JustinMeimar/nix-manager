{ config, lib, pkgs, modulesPath, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Edmonton";
  i18n.defaultLocale = "en_CA.UTF-8";
  system.stateVersion = "25.11";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" "amdgpu.abmlevel=0" ];

  hardware.graphics.enable = true;
  hardware.amdgpu.initrd.enable = true;
  hardware.bluetooth.enable = true;

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

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    android-tools
    alacritty
    google-chrome
    obsidian
    zotero
    bitwarden-desktop
    brave
    discord
    spotify
    vscode
    feh
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    orchis-theme
    colloid-gtk-theme
    colloid-icon-theme
    prismlauncher
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];
}
