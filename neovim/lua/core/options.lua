-- vim: ts=2 sw=2 et:
local o = vim.o
local g = vim.g
local wo = vim.wo
local bo = vim.bo
local cmd = vim.cmd
local api = vim.api

-- Global options {{{
o.updatetime = 800
o.termguicolors = true
o.mouse = 'n'
o.ignorecase = true
o.wrap = false

o.wildmenu = true
o.wildmode = 'full'
o.hlsearch = true

o.listchars = [[tab:→ ,space:·,eol:¶,trail:·,extends:↷,precedes:↶]]

o.clipboard = 'unnamedplus'

o.completeopt = 'menuone,noinsert'

o.backup = false -- true
o.undofile = true

o.colorcolumn = '80'
o.hidden = true
o.cursorline = true
o.expandtab = true
o.wrap = true
o.wrapmargin = 0
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true
o.signcolumn = 'yes'
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.laststatus = 2
o.syntax = 'on'
o.encoding = 'utf-8'
o.timeout = true
o.timeoutlen = 500
o.ttimeout = true
o.ttimeoutlen = 50
o.ttyfast = true
o.lazyredraw = true
o.scrolloff = 6

bo.autoindent = true
bo.smartindent = true

wo.number = true
wo.relativenumber = true

cmd 'colorscheme tokyonight'

api.nvim_command([[
    augroup number_toggle
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END

]])
api.nvim_command([[
    augroup highlight_yank
      autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=400}
    augroup END
]])
api.nvim_command([[
    augroup vimrc-remember-cursor-position
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    augroup END
]])

-- }}}
-- Window options {{{
wo.number = true
wo.list = true

wo.cursorline = true
wo.cursorcolumn = true
-- }}}

-- g.loaded_node_provider   = 0
-- g.loaded_ruby_provider   = 0
g.loaded_perl_provider = 0
g.loaded_python_provider = 0

