local api = vim.api

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yankGrp,
})

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursorGrp,
})
api.nvim_create_autocmd(
  { "InsertEnter", "WinLeave" },
  { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- Check if we need to reload the file when it changed
api.nvim_create_autocmd("FocusGained", { command = [[:checktime]] })

-- windows to close with "q"
api.nvim_create_autocmd(
  "FileType",
  { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
)
api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- Fix highlight issue
-- api.nvim_create_autocmd("VimEnter", { command = [[syntax enable]] })

api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.cmd [[
      set laststatus=0 | autocmd BufUnload <buffer> set laststatus=3
    ]]
  end,
})

-- winbar
-- api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
--   callback = function()
--     local winbar_filetype_exclude = {
--       "help",
--       "startify",
--       "dashboard",
--       "packer",
--       "neogitstatus",
--       "NvimTree",
--       "Trouble",
--       "alpha",
--       "lir",
--       "Outline",
--       "spectre_panel",
--       "toggleterm",
--     }
--
--     if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
--       vim.opt_local.winbar = nil
--       return
--     end
--
--     local value = require("config.winbar").gps()
--
--     if value == nil then
--       value = require("config.winbar").filename()
--     end
--
--     vim.opt_local.winbar = value
--   end,
-- })
