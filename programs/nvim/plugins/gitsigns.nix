{
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = { text = "+"; };
          change = { text = "~"; };
          delete = { text = "_"; };
        topdelete = { text = "‾"; };
        changedelete = { text = "~"; };
        };
        current_line_blame = true;
        current_line_blame_opts = {
          delay = 300;
          ignore_whitespace = false;
        };
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>";
        preview_config = {
          border = "single";
          style = "minimal";
          relative = "cursor";
          row = 0;
          col = 1;
        };
      };
    };
  };
}

