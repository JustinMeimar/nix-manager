# plugins/comment.nix

{
  programs.nixvim = {
    plugins = { 

      comment = {
        enable = true; 
      };
    };
  };
}

