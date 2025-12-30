{ ... }: {
  programs.nixvim.plugins.lualine = {
    enable = false;
    settings.sections = {
      # todo: debug noticable performance regression
      lualine_c = [
        {
          __unkeyed-1 = "filename";
          # 0=filename, 1=relative, 2=absolute, 3=absolute, 4=filename+parent
          path = 1;
        }
      ];
    };
  }; 
}
