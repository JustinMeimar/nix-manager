{ pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg
    sox
    tinymist
    typst
  ];

  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
    };
  };
}
