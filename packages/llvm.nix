{ config, pkgs, lib, ... }:
{
  options.llvm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable LLVM toolchain";
    };
    version = lib.mkOption {
      type = lib.types.enum [ "16" "17" "18" "19" ];
      default = "19";
      description = "LLVM version or 'latest' for HEAD";
    };
  };
  
  config = lib.mkIf config.llvm.enable {
    home.packages = let
      stablePackages = {
        "19" = with pkgs.llvmPackages_19; [ llvm clang clang-tools lld mlir ];
        "18" = with pkgs.llvmPackages_18; [ llvm clang lld ];
        "17" = with pkgs.llvmPackages_17; [ llvm clang clang-tools lld mlir ];
        "16" = with pkgs.llvmPackages_16; [ llvm clang ];
      }; 
    in 
      stablePackages.${config.llvm.version} ++ [ pkgs.lit ];
  };
}

