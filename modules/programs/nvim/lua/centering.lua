-- :CenterBuffer      toggle centering at 76 text columns
-- :CenterBuffer 100  enable (or resize) at 100 text columns
-- no-neck-pain's width includes the gutter (sign/number cols), so add it.
vim.api.nvim_create_user_command("CenterBuffer", function(o)
  local win = vim.fn.getwininfo(vim.fn.win_getid())[1]
  local w = (tonumber(o.args) or 76) + win.textoff
  local on = NoNeckPain.state and NoNeckPain.state.enabled
  if on and o.args ~= "" then
    return require("no-neck-pain").resize(w)
  end
  NoNeckPain.config.width = w
  vim.cmd("NoNeckPain")
end, { nargs = "?", desc = "Toggle buffer centering (arg: text width)" })
