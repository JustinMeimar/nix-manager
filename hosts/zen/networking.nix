{ config, lib, pkgs, ... }: {

  networking.hostName = "zen";
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [ "1.1.1.3" "1.0.0.3" ];
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
  };
 
  services.mullvad-vpn.enable = true;
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  environment.etc."resolv.conf" = lib.mkIf
    (!config.services.mullvad-vpn.enable) {
    text = ''
      nameserver 1.1.1.3
      nameserver 1.0.0.3
    '';
  };
  
  programs.firefox = {
    enable = true;
    policies = {
      DNSOverHTTPS = {
        Enabled = false;
        Locked = true;
      };
    };
  };
  programs.chromium = {
    enable = true;
    extraOpts = {
      DnsOverHttpsMode = "off";
    };
  };
 
}
