{ pkgs, ... }: {
  home.packages = with pkgs; [ nixfmt-classic ];
  programs.nixvim = {
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          cpp = [ "clang-format" ];
          c = [ "clang-format" ];
          python = [ "black" "isort" ];
          html = [ "prettier" ];
          css = [ "prettier" ];
          javascript = [ "prettier" ];
          typescript = [ "prettier" ];
          json = [ "prettier" ];
          yaml = [ "prettier" ];
          markdown = [ "prettier" ];
          nix = [ "nixfmt" ];
        };
        formatters = {
          black = { prepend_args = [ "--line-length" "88" ]; };
          prettier = { prepend_args = [ "--tab-width" "2" ]; };
        };
      };
    };
    keymaps = [
      {
        key = "<leader>f";
        action = "<cmd>lua require('conform').format()<cr>";
        options = {
          desc = "Format with conform";
          silent = true;
        };
      }
      {
        key = "<leader>F";
        action = "<cmd>lua vim.lsp.buf.format()<cr>";
        options = {
          desc = "Format with LSP";
          silent = true;
        };
      }
    ];
  };
}

