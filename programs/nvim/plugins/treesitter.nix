{
  programs.nixvim = {
    
    plugins.treesitter = {
      enable = true;

      settings = {
        ensureInstalled = [
          "bash"
          "c"
	  "cpp"
          "diff"
          "html"
          "lua"
          "luadoc"
          "markdown"
          "markdown_inline"
          "query"
          "vim"
          "vimdoc"
        ];

        highlight = {
          enable = true;
        };
      };
    };
  };
}

