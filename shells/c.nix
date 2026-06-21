{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "c";
  buildInputs = with pkgs; [
    gcc
    gnumake
    bear
  ];
}
