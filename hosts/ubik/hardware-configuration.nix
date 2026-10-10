# Replace this file with hardware-configuration.nix generated on Ubik.
# On an installed system: nixos-generate-config --show-hardware-config
# From the installer, after mounting the target: nixos-generate-config --root /mnt
{ lib, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];

  # Root/EFI UUIDs and swap must come from the new installation.
  assertions = [
    {
      assertion = false;
      message = "Ubik needs its generated hosts/ubik/hardware-configuration.nix before installation or switching.";
    }
  ];
}
