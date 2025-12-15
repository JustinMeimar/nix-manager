{ config, lib, pkgs, ...} :
let config = builtins.readFile ./alacritty.toml;
in
{ 
  # todo: figure out why openGL breaks with nix install
  # of alacritty, but not with apt version.
  programs.alacritty = {
    enable = false;
    settings = {
      window = {
        title = "Terminal";
        dimensions = {
          columns = 120;
          lines = 40;
        };  
      };
    }; 
  };

  # manually place alacritty.toml for now
  home.file.".config/alacritty/alacritty.toml".text = config;
}

