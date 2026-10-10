{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "ubik";
  networking.networkmanager.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/Edmonton";
  i18n.defaultLocale = "en_CA.UTF-8";
  # For a fresh installation; retain the original value on an existing system.
  system.stateVersion = "26.05";

  # Boot the installer in UEFI mode and mount the EFI partition at /mnt/boot.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  hardware.cpu.intel.updateMicrocode = true;

  hardware.amdgpu.initrd.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Adapted from the KDE/Dolphin setup in commit 15782d9.
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.libinput.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.justin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.steam.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [ git vim just ];
  environment.sessionVariables = {
    TERMINAL = "alacritty";
    EDITOR = "nvim";
  };
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
  ];
}
