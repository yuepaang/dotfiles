local vim = vim
vim.g.mapleader = " "

local bind = require("utils.bind")
local map_cmd = bind.map_cmd

local plug_map = {
  ["n|<CR>"] = map_cmd(":nohlsearch<CR><CR>"):with_noremap(),
  ["n|<C-s>"] = map_cmd(":w<CR>"):with_noremap(),
  ["n|<C-q>"] = map_cmd(":q<CR>"):with_noremap(),
  ["n|<C-l>"] = map_cmd("<C-w>l"):with_noremap(),
  ["n|<C-h>"] = map_cmd("<C-w>h"):with_noremap(),
  ["n|<F3>"] = map_cmd("a<C-R>=strftime('%Y-%m-%d %H:%M:%S')<Esc>"):with_noremap(),
  ["i|<F3>"] = map_cmd("<C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>"):with_noremap(),
  ["i|<C-a>"] = map_cmd("<Home>"):with_noremap(),
  ["i|<C-e>"] = map_cmd("<End>"):with_noremap(),
  ["i|<C-h>"] = map_cmd("<BS>"):with_noremap(),
  ["i|<C-d>"] = map_cmd("<Del>"):with_noremap(),

  ["c|<C-a>"] = map_cmd("<Home>"):with_noremap(),
  ["c|<C-e>"] = map_cmd("<End>"):with_noremap(),
  ["c|<C-h>"] = map_cmd("<BS>"):with_noremap(),
  ["c|<C-d>"] = map_cmd("<Del>"):with_noremap(),
}

bind.nvim_load_mapping(plug_map)

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
