{
  programs.nixvim = {
    
    plugins.treesitter = {
      enable = true;

      settings = {
        ensureInstalled = [
          "bash"
          "c"
	  "cpp"
	  "css"
          "diff"
          "html"
	  "javascript"
          "lua"
          "luadoc"
          "markdown"
          "markdown_inline"
          "query"
	  "typescript"
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

