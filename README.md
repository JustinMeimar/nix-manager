## Home Manager

This configuration is used to set up my home on any machine.

### Hosts

Applying a configuration referenced in `./hosts`

* Zen (Ubuntu Laptop): `home-manager switch --flake .#justin@zen`
* Bee (NixOS Home Server): `home-manager switch --flake .#justin@bee` 

### Secrets
Some hosts configure `sops` which is used to manage secrets, for which some additional work post switch needs to be done.

```
sops --encrypt --age <AGE_PUBLIC_KEY> <SECRETS_YAML> > <SECRETS_YAML_ENC>
```
Where: 
* `AGE_PUBLIC_KEY`: path to AGE public key (hidden locally)
* `SECRETS_YAML`: path to `.yaml` containing secrets (hidden locally)
* `SECRETS_YAML_ENC`: encrypted version of secrets (can be stored publicly)


