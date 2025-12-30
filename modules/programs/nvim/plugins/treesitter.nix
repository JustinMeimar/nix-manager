{
  programs.nixvim = {

    plugins.treesitter = {
      enable = true;

      settings = {
        ensureInstalled = [
          "antlr"
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
          "typst"
          "vim"
          "vimdoc"
          "yaml"
        ];

        highlight = { enable = true; };
      };
    };
  };
}

