## Home Manager

This configuration is used to set up my home on any machine.

### Hosts

Applying a configuration referenced in `./hosts`

* Zen (Ubuntu Laptop): `home-manager switch --flake .#justin@zen`
* Bee (NixOS Home Server): `home-manager switch --flake .#justin@bee` 

### Secrets
Some hosts configure `sops` which is used to manage secrets, for which some additional work post switch needs to be done.

```bash
sops --encrypt -a $(cat {AGE_PUBLIC_KEY}) {SECRETS_YAML} > {SECRETS_YAML_ENC}
```

Where: 
* `AGE_PUBLIC_KEY`: path to AGE public key (hidden locally)
* `SECRETS_YAML`: path to `.yaml` containing secrets (hidden locally)
* `SECRETS_YAML_ENC`: encrypted version of secrets (can be stored publicly)

While `sops-nix` should automatically handle decryption based on the parameters in `sops.nix`,
secrets may be decrypted manually using:

```bash
sops --decrypt --input-type yaml --output-type yaml  <SECRETS_YAML_ENC>
```

On NixOS secrets go to `/run/secrets`. With home-manager they go to `~/.config/sops-nix/secrets`

## Bee web services

`hosts/bee/configuration.nix` declares the sites in `services.beefarm.sites`. Each
enabled entry creates a route on the existing `bee-hole` Cloudflare tunnel:
`<site>.justinmeimar.com` goes to `127.0.0.1:<port>`. The current `bee`,
`fossil`, and `dashboards` entries serve placeholder HTML pages.

Cloudflare DNS needs a proxied wildcard CNAME for `*.justinmeimar.com` pointing
to the existing tunnel's `<tunnel-id>.cfargotunnel.com` address. DNS is managed
outside this repository. Unconfigured hostnames receive a tunnel 404.

To add a service already managed by NixOS, declare its loopback port:

```nix
services.beefarm.sites.example = {
  port = 8010;
};
```

For a simple command, also set `service.description` and `service.exec` to have
bee-farm create its systemd unit. The command must listen on `127.0.0.1` at the
declared port. Set `subdomain` if it should differ from the site attribute name.
Ports and hostnames must be unique. Set `enable = false` to keep a declaration
without publishing or starting its bee-farm unit.
