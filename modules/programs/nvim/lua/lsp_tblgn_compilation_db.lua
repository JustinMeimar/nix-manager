vim.api.nvim_create_user_command("TblGenSetDB", function(opts)
  local db_path = opts.args
  if db_path == "" then
    print("Need path")
    return
  end
  if vim.fn.filereadable(db_path) ~= 1 then
    print("Can't read: " .. db_path)
    return
  end
  vim.cmd("LspStop tblgen_lsp_server")
  require('lspconfig').tblgen_lsp_server.setup({
    cmd = {
      vim.fn.exepath("tblgen-lsp-server"),
      "--tablegen-compilation-database=" .. db_path
    }
  })
  vim.cmd("LspStart tblgen_lsp_server")
  print("Set DB: " .. db_path)
end, {
  nargs = "?",
  complete = "file"
})

