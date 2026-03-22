{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "rust";

  buildInputs = with pkgs; [
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    gcc
    pkg-config
    openssl
  ];

  RUST_BACKTRACE = 1;
}
