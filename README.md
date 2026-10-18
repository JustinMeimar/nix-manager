# nix-manager

Personal NixOS and Home Manager configurations.

## Hosts

Run the appropriate command from this checkout on the target host:

| Host | Command |
| --- | --- |
| Ubik | `just switch-ubik` |
| Zen | `just switch-zen` |
| Pi | `just switch-pi` |
| Bee | `just rebuild-bee` |

Ubik, Zen, and Pi include Home Manager in their NixOS configurations. Bee's
Home Manager configuration is standalone and can be applied with
`just switch-bee`.

## Secrets

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix).
Encrypted secret files belong in the repository; private keys and plaintext do
not. NixOS services read decrypted secrets from `/run/secrets`.
