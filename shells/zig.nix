{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "zig";

  buildInputs = with pkgs; [
    zig
  ];
}
