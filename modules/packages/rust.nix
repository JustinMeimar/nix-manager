{ config, pkgs, lib, ... }: {

  options.rust = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Rust toolchain";
    };
  };

  config = lib.mkIf config.rust.enable {
    home.packages = with pkgs; [
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer
      pkg-config
      openssl
    ];
  };
}

