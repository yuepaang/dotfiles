local vim = vim
vim.g.mapleader = " "

-- auto commands
vim.api.nvim_command([[
  augroup number_toggle
    set number
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * set norelativenumber
  augroup END

  augroup _git
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

]])

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

require("config")
require("utils")
require("plugins").setup()
