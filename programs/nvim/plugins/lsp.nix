{
  programs.nixvim = {
    
    # auto-completion for lua
    plugins.cmp-nvim-lsp = {
      enable = true;
    };

    # lsp
    plugins.lsp = {
      enable = true;

      servers = {	
	# lsp for c/c++
	clangd = {
	  enable = true;
	};

	# lsp for python
	pyright = {
	  enable = true;
	};

      };
    };
  };
}
