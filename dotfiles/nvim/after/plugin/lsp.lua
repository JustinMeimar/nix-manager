-- after/plugin/lsp.lua

local lspconfig = require('lspconfig')
local cmp_nvim_lsp = require('cmp_nvim_lsp')
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Helper function for keybindings
local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts) 
    print(client.name .. " attached to buffer")
end

-- Configure clangd
lspconfig.clangd.setup{
    capabilities = capabilities,
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu"
    },
    on_attach = on_attach,
    filetypes = { "c", "objc", "objcpp" },  -- Specify filetypes
}

-- Configure pyright (Python LSP)
lspconfig.pyright.setup{
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "python" },  -- Specify filetypes
    settings = {
        python = {
            -- Your existing settings...
          analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                completionEnabled = true,
                indexing = true,
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                },
            },
            linting = {
                enabled = true,
                pylintEnabled = true,
            },
        },
    },
    flags = {
        debounce_text_changes = 150,
    },
    root_dir = function(fname)
        return lspconfig.util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
               lspconfig.util.path.dirname(fname)
    end,
}

-- Configure autocompletion
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    max_item_count = 8,
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
