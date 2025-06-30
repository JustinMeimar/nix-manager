{ config, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      github.vscode-pull-request-github
      github.github-vscode-theme
      vscodevim.vim
    ];
    userSettings = builtins.fromJSON (builtins.readFile ./vscode.json);
  };
}	
