{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "blog";

  buildInputs = with pkgs; [
    nodejs_22
    nodePackages.npm
  ];
}
