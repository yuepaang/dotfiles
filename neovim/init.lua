local vim = vim
vim.g.mapleader = " "

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

vim.g.python3_host_skip_check = 1
vim.g.python3_host_prog = "$HOME/.pyenv/versions/nvim-py3/bin/python"

require("config")
require("utils")
require("plugins").setup()
