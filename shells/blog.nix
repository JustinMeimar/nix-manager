{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "blog";

  buildInputs = with pkgs; [
    bun
    nodejs_22
    typst
  ];
}
