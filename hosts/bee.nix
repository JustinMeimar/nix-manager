{ config, pkgs, ... }:

{
  imports = [
    ../modules/nixos/base.nix
    ../programs/sops/sops.nix
  ];
  
  # services.cloudflare-dyndns = {
  #   enable = true;
  #   domains = [ "justinmeimar.com"];
  #   apiTokenFile = config.sops.secrets.cloudflare-dydns-token.path;
  #   proxied = false;
  # }; 

}

