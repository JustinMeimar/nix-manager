{ pkgs, ... }:
{
  boot.loader.raspberry-pi.bootloader = "kernel";

  # The installer image is already installed on the Pi's internal SD card.
  fileSystems."/" = {
    device = "/dev/mmcblk0p2";
    fsType = "ext4";
    options = [ "noatime" ];
  };
  fileSystems."/boot/firmware" = {
    device = "/dev/mmcblk0p1";
    fsType = "vfat";
    options = [ "noatime" "noauto" "x-systemd.automount" "x-systemd.idle-timeout=1min" ];
  };

  networking.hostName = "pi";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Edmonton";

  users.users.justy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  services.openssh.enable = true;
  environment.systemPackages = with pkgs; [ git vim ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "26.05";
}
