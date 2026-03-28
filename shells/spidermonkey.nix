{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "spidermonkey-dev";
  buildInputs = with pkgs; [
    python3
    python3Packages.pip
    rustc
    cargo
    rust-analyzer
    clang
    llvm
    llvmPackages.bintools
    autoconf
    m4
    yasm
    nodejs
    pkg-config
    sccache
    gnumake
    ninja
    gdb
    just
    zlib
    libffi
    which
    perl
    git
    rust-cbindgen
    bear
  ];

  shellHook = ''
    echo "SpiderMonkey development environment loaded"
    echo "  - python:          $(python3 --version)"
    echo "  - rustc:           $(rustc --version)"
    echo "  - cargo:           $(cargo --version)"
    echo "  - clang:           $(clang --version | head -n1)"
    echo "  - node:            $(node --version)"
    echo "  - just:            $(just --version)"
    echo "  - sccache:         $(sccache --version)"
    echo ""
    echo "Available commands:"
    echo "  just build-aot           - Build AOT debug shell"
    echo "  just build-aot-release   - Build AOT release shell"
    echo ""
  '';
}
