## NixOS and Home Manager

This flake configures the Zen, Pi, and Bee hosts and their user environments.

### Hosts

Run these commands on the corresponding host, from this checkout:

* Zen: `just switch-zen` rebuilds NixOS and activates Home Manager together.
* Pi: `just switch-pi` rebuilds NixOS and activates Home Manager together.
* Bee: `just rebuild-bee` rebuilds NixOS; `just switch-bee` activates its standalone Home Manager configuration.

Zen and Pi intentionally have no standalone Home Manager outputs. Their homes
are managed only by `nixos-rebuild switch --flake .#zen` or `.#pi`, respectively.
If either host previously used standalone Home Manager, after a successful
NixOS switch check `nix-env -q` for `home-manager-path`. If present, remove that
old user-profile package with `nix-env -e home-manager-path` to avoid stale
packages shadowing `/etc/profiles/per-user/justin/bin`. Log out and back in to
refresh the session environment.

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
