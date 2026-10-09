
switch-zen:
    sudo nixos-rebuild switch --flake path:.#zen

switch-pi:
    sudo nixos-rebuild switch --flake .#pi

switch-bee:
    home-manager switch --flake .#justin@bee

rebuild-bee:
    sudo nixos-rebuild switch --flake .#bee
