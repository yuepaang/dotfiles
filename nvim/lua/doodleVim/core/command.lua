-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
  { "InsertLeave", "WinEnter" },
  { pattern = "*", command = "set cursorline", group = cursorGrp }
)
vim.api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = [[:checktime]] })

vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd("hi link illuminatedWord LspReferenceText")
  end,
})

-- Copilot
vim.cmd([[
    imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true
]])

local vim = vim
local gruvbox = require("doodleVim.extend.gruvbox")
local misc = require("doodleVim.extend.misc")
local floaterm = require("doodleVim.extend.floaterm")
local tree = require("doodleVim.extend.tree")

local M = {}

local function create_command(commands)
  for _, cmd in ipairs(commands) do
    if #cmd == 2 then
      vim.api.nvim_create_user_command(cmd[1], cmd[2], {})
    elseif #cmd == 3 then
      vim.api.nvim_create_user_command(cmd[1], cmd[2], cmd[3])
    end
  end
end

function M.load_user_command()
  local commands = {
    { "GruvboxDump", gruvbox.dump },
    { "ReloadConfig", misc.reload },
    { "OpenTree", tree.toggle },
    {
      "Lazygit",
      function()
        floaterm.run("lazygit", { title = "lazygit", name = "lazygit" })
      end,
    },
  }
  create_command(commands)
end

return M
