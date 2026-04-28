{ pkgs, ... }: {
  home.packages = with pkgs; [
    ffmpeg
    sox
    tinymist
    typst
    zathura
  ];
}
