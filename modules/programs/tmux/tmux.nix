{ config, lib, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    mouse = true;
    escapeTime = 0;
    baseIndex = 1;
    historyLimit = 10000;
    keyMode = "vi";
    extraConfig = builtins.readFile ./tmux.conf + ''
      # Reload the configuration at Home Manager's XDG path.
      bind-key r source-file "${config.xdg.configHome}/tmux/tmux.conf" \; display-message "tmux.conf reloaded."
    '';
  };
}
