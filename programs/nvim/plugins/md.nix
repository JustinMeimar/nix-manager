{ coinfigs, pkgs, ...}:

{
  programs.nixvim = {
    plugins = {
      markdown-preview = {
	enable = true; 
      };
    };
  };
}

