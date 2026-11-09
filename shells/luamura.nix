{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "luamura";

  buildInputs = with pkgs; [
    cmake
    gnumake
    gcc
    llvmPackages_21.clang
    bear

    llvmPackages.llvm
    llvmPackages.libllvm
    llvmPackages.libllvm.dev

    lua5_5
  ];
}
