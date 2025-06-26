{
  programs.nixvim = { 
    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          cpp = [ "clang-format "];
          c = [ "clang-format" ];
        };
      };
    }; 
  };
}

