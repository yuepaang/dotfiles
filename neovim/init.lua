local vim = vim
vim.g.mapleader = " "

-- auto commands
vim.cmd([[
  augroup number_toggle
    set number
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * set norelativenumber
  augroup END

  augroup _git
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup vimrc-remember-cursor-position
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  augroup END

]])

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

vim.g.python3_host_skip_check = 1
vim.g.python3_host_prog = "$HOME/.pyenv/versions/nvim-py3/bin/python"

require("config")
require("utils")
require("plugins").setup()
