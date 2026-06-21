{ config, lib, pkgs, modulesPath, ... }: {

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/Edmonton";
  i18n.defaultLocale = "en_CA.UTF-8";
  system.stateVersion = "25.11";
  security.rtkit.enable = true;
  
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "amdgpu.dcdebugmask=0x10" "amdgpu.abmlevel=0" ];
  };
  
  hardware = {
    graphics.enable = true;
    amdgpu.initrd.enable = true;
    bluetooth.enable = true;
  };
 
  services = {
    pulseaudio.enable = false;
    xserver.enable = true;
    xserver.xkb.layout = "us";
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    libinput.enable = true;
    power-profiles-daemon.enable = true;
    fwupd.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
   
  services.printing = {
    enable = true;
    drivers = [ pkgs.brlaser ];
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  environment.sessionVariables = {
    TERMINAL = "alacritty";
    EDITOR = "nvim";
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
    calibre
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
