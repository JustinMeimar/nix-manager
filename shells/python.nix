{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "python";

  buildInputs = with pkgs; [
    python3
    uv
    ruff
  ];

  LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ]);
}
