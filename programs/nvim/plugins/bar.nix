# plugins/bar.nix

{
  programs.nixvim = {
    plugins = {
      barbar = {
        enable = true;
	keymaps = {
	  close.key = "<C-m>";
	  moveNext.key = "<Tab>";
	  movePrevious.key = "<S-Tab>";
	  goTo1.key = "<leader>1";
	  goTo2.key = "<leader>2";
	  goTo3.key = "<leader>3";
	  goTo4.key = "<leader>4";
	  goTo5.key = "<leader>5";
	  goTo6.key = "<leader>6";
	  goTo7.key = "<leader>7";
	  goTo8.key = "<leader>8";
	}; 
      };
    };

  };
}

