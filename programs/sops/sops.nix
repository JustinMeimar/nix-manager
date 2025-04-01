{ config, pkgs, ... }:
{
  sops = {
    age.keyFile = "/home/justin/.nix.age";
    defaultSopsFile = ./secrets.yaml.enc;
    secrets = {
      key_cdol = {
        path = "/home/justin/.ssh/key_cdol"; 
      };
    };
  };
}

