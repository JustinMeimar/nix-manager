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
          "dockerfile"
          "html"
	        "javascript"
          "lua"
          "luadoc"
          "markdown"
          "markdown_inline"
	        "nix"
          "query"
          "tablegen"
	        "typescript"
          "vim"
          "vimdoc"
          "yaml"
        ];

        highlight = {
          enable = true;
        };
      };
    };
  };
}

