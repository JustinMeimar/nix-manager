{ config, pkgs, lib, ...}: {
  imports = [
    ./cli.nix
    ./dev.nix
    ./media.nix
    ./rust.nix
    ./llvm.nix
  ];
}
