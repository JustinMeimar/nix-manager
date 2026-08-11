{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "zig";

  packages = with pkgs; [
    zig
    zls
  ];
}
