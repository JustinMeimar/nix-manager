local map = vim.keymap.set

-- Basic Maps

map("n", "<leader>d", '"_d', { desc = "Delete without copying" })
map("n", "<leader>dd", '"_dd', { desc = "Delete line without copying" })
map("n", "<leader>el", '$', { desc = "Jump to end of line" })
map("n", "<leader>nh", ":set hlsearch!<CR>", { desc = "Toggle search highlights" })
map("n", "<leader>ep", ":Explore<CR>", { desc = "Open Netrw" })
map("n", "<leader>sa", ":wall<CR>", { desc = "Open Netrw" })
map("v", "<leader>d", '"_d', { desc = "Delete selection without copying" })

-- Diagnositcs

map("n", "<leader>tt", function()
 if vim.diagnostic.is_enabled() then
   vim.diagnostic.disable(0)
   print("Diagnostics disabled")
 else
   vim.diagnostic.enable(0)
   print("Diagnostics enabled")
 end
end, { desc = "Toggle diagnostics" })

map("n", "<leader>te", function()
  vim.diagnostic.config(
    { virtual_text = { severity = vim.diagnostic.severity.ERROR } }
  )
end, { desc = "Show only errors" })

map("n", "<leader>tw", function()
  vim.diagnostic.config(
    { virtual_text = { severity = { min = vim.diagnostic.severity.WARN } } }
  )
end, { desc = "Show warnings and errors" })

