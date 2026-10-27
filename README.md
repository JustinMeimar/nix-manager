# nix-manager

Personal NixOS and Home Manager configurations.

## Hosts

Run the appropriate command from this checkout on the target host:

| Host | Command |
| --- | --- |
| Ubik | `sudo nixos-rebuild switch --flake .#ubik` |
| Zen | `sudo nixos-rebuild switch --flake .#zen` |
| Pi | `sudo nixos-rebuild switch --flake .#pi` |
| Bee | `sudo nixos-rebuild switch --flake .#bee` |

Ubik, Zen, and Pi include Home Manager in their NixOS configurations. Bee uses
NixOS alone, including Justin's packages, shell, Git/SSH configuration, tmux,
Vim, and Nixvim. Home Manager inputs remain for the other hosts.

Bee's user configuration lives in `hosts/bee/user-environment.nix`. NixOS
activation links the managed files from `/etc/nix-manager/justin`, archiving
existing Home Manager links in `~/.local/state/bee-nixos`. Handwritten files
are preserved and reported as conflicts. Put local shell additions in
`~/.zshrc.local`.

## Secrets

Secrets are managed with [sops-nix](https://github.com/Mic92/sops-nix).
Encrypted secret files belong in the repository; private keys and plaintext do
not. NixOS services read decrypted secrets from `/run/secrets`.
