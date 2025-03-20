{ config, pkgs, lib, ... }:
{
  options.llvm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable llvm packages";
    };
    version = lib.mkOption {
      type = lib.types.enum [ "16" "17" "18" "19" ];
      default = "19";
      description = "Which major version of LLVM to install";
    };
  };

  config = lib.mkIf config.llvm.enable {
    home.packages = let
      llvmPkgs = {
        "19" = [
          pkgs.llvmPackages_19.libllvm
          pkgs.llvmPackages_19.mlir
          pkgs.llvmPackages_19.libcxxClang
          pkgs.llvmPackages_19.clang-tools
        ];
        "18" = [
          pkgs.llvmPackages_18.libllvm
          pkgs.llvmPackages_17.mlir # no lib mlir 18
        ];
        "17" = [
          pkgs.llvmPackages_17.libllvm
          pkgs.llvmPackages_17.mlir
          pkgs.llvmPackages_17.clang-tools
        ];
        "16" = [
          pkgs.llvmPackages_16.libllvm
        ];
      };    
    in
      # will concatenate to existig definition of home.packages
      llvmPkgs.${config.llvm.version};
  };
}

