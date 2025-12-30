{ configs, pkgs, ... }: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "vim-tidal";
        src = pkgs.fetchFromGitHub {
          owner = "tidalcycles";
          repo = "vim-tidal";
          rev = "master";
          sha256 = "sha256-8gyk17YLeKpLpz3LRtxiwbpsIbZka9bb63nK5/9IUoA=";
        };
      })
    ];
    extraConfigLua = ''
      vim.g.tidal_target = "terminal"
    '';
  };
}

