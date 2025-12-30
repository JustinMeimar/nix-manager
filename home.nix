{ config, lib, pkgs, ... }:
  let homeOpts = config.home; 
in
{   
  # options.home = {
  #   enable = lib.mkEnableOption "home";
  #   username = lib.mkOption {
  #     type = lib.types.str;
  #     description = "Username on system";
  #   };
  #   homeDirectory = lib.mkOption {
  #     type = lib.types.str;
  #     description = "Home directory on system";
  #   };
  #   stateVersion = lib.mkOption {
  #     type = lib.types.str;
  #     description = "Home manager version.";
  #   };
  #   packages = lib.mkOption {
  #     type = lib.types.listOf lib.types.package;
  #     description = "Basic packages to install";
  #     default = [ pkgs.vim ];
  #   };
  #   sessionVariables = lib.mkOption {
  #     type = lib.types.attrs;
  #     default = { EDITOR = "vim"; };
  #     description = "Session environment variables";
  #   };
  #   file = lib.mkOption {
  #     type = lib.types.attrs;
  #     default = {};
  #     description = "Files to link into home directory";
  #   };
  # };
  #
  #
  # home = lib.mkIf config.home.enable {
  #   username = homeOpts.username;
  #   homeDirectory = homeOpts.homeDirectory;
  #   stateVersion = homeOpts.stateVersion;
  #   
  #   # probably defaults
  #   packages = homeOpts.packages;
  #   sessionVariables = homeOpts.sessionVariables; 
  #   file = homeOpts.file;
  # };
  #
  # # Let home manager self-manage
  # programs.home-manager.enable = true;
}

