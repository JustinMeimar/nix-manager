# plugins/bar.nix
# bufferline.nvim — replacing barbar.nvim (unfree "json" license)
{ config, lib, ... }:
let
  inherit (lib) mkIf;
in {
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      settings.options = {
        mode = "buffers";
        always_show_bufferline = true;
        buffer_close_icon = "󰅖";
        close_icon = "";
        show_buffer_close_icons = true;
        show_buffer_icons = true;
        show_close_icon = true;
        show_tab_indicators = true;
        persist_buffer_sort = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<C-q>";
        action = "<cmd>bdelete<CR>";
        options.desc = "Close buffer";
      }
      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>BufferLineCycleNext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<C-p>";
        action = "<cmd>BufferLineCyclePrev<CR>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<leader>1";
        action = "<cmd>BufferLineGoToBuffer 1<CR>";
        options.desc = "Go to buffer 1";
      }
      {
        mode = "n";
        key = "<leader>2";
        action = "<cmd>BufferLineGoToBuffer 2<CR>";
        options.desc = "Go to buffer 2";
      }
      {
        mode = "n";
        key = "<leader>3";
        action = "<cmd>BufferLineGoToBuffer 3<CR>";
        options.desc = "Go to buffer 3";
      }
      {
        mode = "n";
        key = "<leader>4";
        action = "<cmd>BufferLineGoToBuffer 4<CR>";
        options.desc = "Go to buffer 4";
      }
      {
        mode = "n";
        key = "<leader>5";
        action = "<cmd>BufferLineGoToBuffer 5<CR>";
        options.desc = "Go to buffer 5";
      }
      {
        mode = "n";
        key = "<leader>6";
        action = "<cmd>BufferLineGoToBuffer 6<CR>";
        options.desc = "Go to buffer 6";
      }
      {
        mode = "n";
        key = "<leader>7";
        action = "<cmd>BufferLineGoToBuffer 7<CR>";
        options.desc = "Go to buffer 7";
      }
      {
        mode = "n";
        key = "<leader>8";
        action = "<cmd>BufferLineGoToBuffer 8<CR>";
        options.desc = "Go to buffer 8";
      }
    ];
  };
}