{ config, lib, pkgs, ... }: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultOptions =
      [ "--height 40%" "--layout reverse" "--border" "--tmux bottom,40%" ];

    historyWidgetOptions = [
      "--preview 'echo {}'"
      "--preview-window down:3:wrap"
      "--bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'"
      "--color header:italic"
      "--header 'Copy: <CTRL-Y> | Next: <CTRL-N> | Prev: <CTRL-P>'"
    ];
  };
}

