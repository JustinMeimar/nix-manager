
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

vim.keymap.set("n", "<leader>sc", function()
    vim.opt_local.spell = not vim.wo.spell
end, { desc = "Toggle spell check"})

vim.opt.spelloptions:append("camel")
