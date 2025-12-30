{ config, pkgs, ... }: {
  sops = {
    age.keyFile = "/home/justin/.secrets/nix.age";
    defaultSopsFile = ./secrets.yaml.enc;
    secrets = {
      cloudflare-bee-hole-tunnel-token = {
        mode = "0600";
      };
      cloudflare-dydns-token = {
        mode = "0600";
      };
      github-zen = {
        path = "/home/justin/.ssh/github-zen";
        mode = "0600";
      };
    };
  };
}

