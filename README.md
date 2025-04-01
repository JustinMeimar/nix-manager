## Home Manager

Applying the Configuration:

`home-manager switch --flake .#justin-home`

Encrypting Secrets

```
sops --encrypt --age <AGE_PUBLIC_KEY> <SECRETS_YAML> > <SECRETS_YAML_ENC>
```
where: 
* `AGE_PUBLIC_KEY`: path to AGE public key (hidden locally)
* `SECRETS_YAML`: path to `.yaml`containing secrets (hidden locally)
* `SECRETS_YAML_ENC`: encrypted version of secrets (can be stored publicly) 
