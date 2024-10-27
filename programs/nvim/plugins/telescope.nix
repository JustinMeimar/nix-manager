# plugins/telescope.nix

{
  programs.nixvim = {
    plugins = {
      
      web-devicons.enable = true;
      
      telescope = {
        enable = true;
        extensions.fzf-native = {
          enable = true;
          settings = {
            case_mode = "smart_case";
            fuzzy = true;
          };
        };
        
        settings.defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^node_modules/"
            "^build/"
            "^dist/"
            "^__pycache__/"
            "^venv/"
            "^env/"
          ];
          layout_strategy = "horizontal";
          layout_config = {
            horizontal = {
              preview_width = 0.55;
              prompt_position = "top";
            };
            vertical = {
              mirror = false;
            };
            width = 0.87;
            height = 0.80;
            preview_cutoff = 120;
          };

          vimgrep_arguments = [
            "rg"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
          ];

          mappings = {
            i = {
              "<C-n>" = "move_selection_next";
              "<C-p>" = "move_selection_previous";
              "<C-c>" = "close";
              "<C-j>" = "cycle_history_next";
              "<C-k>" = "cycle_history_prev";
              "<C-q>" = "smart_send_to_qflist";
            };
          };
        };
        
	keymaps = {
          "<leader>ff" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fp" = "git_files";
          "<leader>fs" = "grep_string";
          "<leader>fd" = "diagnostics";
          "<leader>fi" = "lsp_implementations";
          "<leader>fr" = "lsp_references";
        };
      };
    };
  };
}

