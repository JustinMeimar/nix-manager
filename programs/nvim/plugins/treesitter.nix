{
  programs.nixvim = {
    
    plugins.treesitter = {
      enable = true;

      settings = {
        ensureInstalled = [
          "bash"
	  "bibtext" # latex support
          "c"
	  "cpp"
	  "css"
          "diff"
          "html"
	  "javascript"
	  "latex" # latex support
          "lua"
          "luadoc"
          "markdown"
          "markdown_inline"
	  "nix"
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

