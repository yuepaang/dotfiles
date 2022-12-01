local M = {}

M.disabled = false

M.enhanced_buffer_close = function()
  require("doodleVim.utils.defer").immediate_load("barbar.nvim")

  if M.disabled then
    return
  end

  local win_num = vim.api.nvim_win_get_number(0)
  local filetype = vim.bo.filetype
  if filetype == "TelescopePrompt" then
    return
  end

  if win_num > 2 then
    vim.cmd([[bdelete!]])
  else
    vim.cmd([[BufferClose]])
  end
end

M.enhanced_bufferline = function(cmd)
  require("doodleVim.utils.defer").immediate_load("barbar.nvim")
  if M.disabled then
    return
  end
  cmd = ":" .. cmd
  vim.cmd(cmd)
end

M.disable = function()
  require("doodleVim.utils.defer").immediate_load("barbar.nvim")
  require("bufferline.render").disable()
  M.disabled = true
end

M.enable = function()
  require("doodleVim.utils.defer").immediate_load("barbar.nvim")
  require("bufferline.render").enable()
  M.disabled = false
end

return M
