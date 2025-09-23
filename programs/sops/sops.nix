{ config, pkgs, ... }: {
  sops = {
    age.keyFile = "/home/justin/.secrets/nix.age";
    defaultSopsFile = ./secrets.yaml.enc;
    secrets = {
      nix-github-token = {
        path = "/home/justin/.ssh/nix-github-token";
        mode = "0600";
      };
      nix-github-zen = {
        path = "/home/justin/.ssh/nix-github-zen";
        mode = "0600";
      };
    };
  };
}

