{ config, lib, pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultOptions =
      [ "--height 40%" "--layout reverse" "--border" "--tmux bottom,40%" ];

    historyWidgetOptions = [
      "--preview 'echo {}'"
      "--preview-window down:3:wrap"
      "--color header:italic"
    ];
  };
}
