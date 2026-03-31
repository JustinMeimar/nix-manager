{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "python";

  buildInputs = with pkgs; [
    uv
  ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ]);
}
