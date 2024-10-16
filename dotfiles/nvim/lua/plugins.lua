-- plugins.lua
-- each plugin has its configuration in /after/plugins/<plugin>.lua

return require('packer').startup(function(use)

    -- packer manages itself
    use 'wbthomason/packer.nvim'
    
    -- telescope for finding files
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    
  
    -- nvim-tree for file explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }
    

    -- LSP support
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'  
    use 'L3MON4D3/LuaSnip'
    
end)
