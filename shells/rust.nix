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
    clang
    pkg-config
    openssl
  ];

  RUST_BACKTRACE = 1;
  RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
}
