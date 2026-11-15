
switch-ubik:
    sudo nixos-rebuild switch --flake path:.#ubik

switch-zen:
    sudo nixos-rebuild switch --flake path:.#zen

switch-pi:
    sudo nixos-rebuild switch --flake .#pi

switch-bee:
    sudo nixos-rebuild switch --flake path:.#bee

alias rebuild-bee := switch-bee
