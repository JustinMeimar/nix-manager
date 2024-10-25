# plugins/comment.nix

{
  programs.nixvim = {
    plugins = { 

      comment = {
        enable = true;
         extraConfig = {
           sticky = true;
           toggler = {
             line = "gcc";
             block = "gbc";
           };
           opleader = {
             line = "gc";
             block = "gb";
           };
         };
      };

    };
  };
}

