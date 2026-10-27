{ options, ... }:
let
  historyOptions = [
    "--preview 'echo {}'"
    "--preview-window down:3:wrap"
    "--color header:italic"
  ];
in {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    defaultOptions =
      [ "--height 40%" "--layout reverse" "--border" "--tmux bottom,40%" ];

  } // (if options.programs.fzf ? historyWidget then {
    historyWidget.options = historyOptions;
  } else {
    historyWidgetOptions = historyOptions;
  });
}
