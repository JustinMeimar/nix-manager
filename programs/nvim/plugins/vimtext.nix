{ coinfigs, pkgs, ...}:
{
  programs.nixvim = {
    plugins = {
      vimtex = {
	enable = true;
	settings = {
	  view_method = "zathura";
	  compiler_method = "latexmk";
          compiler_latexmk_engines = {
            "_" = "-pdf";
            "pdflatex" = "-pdf";
            "lualatex" = "-lualatex";
            "xelatex" = "-xelatex";
          };
	};
      };
    };
  };
}

