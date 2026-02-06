-- There is a bug in generated lua configuration. The
-- nix option `initializationOptions` which
-- is used to set the typscript library path astro relies
-- upon should map to `init_options`, but it generates
-- `astro.initializationOptions`.

local function fix_astro_lsp_option()
  -- Copy the astro config. 
  local astro_config = vim.lsp.config.astro or {}
  local init_opts = astro_config.initializationOptions or {}
  
  -- Patch in the correct option.
  astro_config.init_options = init_opts
  vim.lsp.config.astro = astro_config
end

fix_astro_lsp_option()
