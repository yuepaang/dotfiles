local global = require "doodleVim.core.global"
local defer = require "doodleVim.utils.defer"
local pack = require "doodleVim.core.pack"
local event = require "doodleVim.core.event"
local options = require "doodleVim.core.options"

-- Create cache dir and subs dir
local createdir = function()
  local data_dir = {
    global.cache_dir .. "backup",
    global.cache_dir .. "session",
    global.cache_dir .. "swap",
    global.cache_dir .. "tags",
    global.cache_dir .. "undo",
  }
  -- There only check once that If cache_dir exists
  -- Then I don't want to check subs dir exists
  if vim.fn.isdirectory(global.cache_dir) == 0 then
    os.execute("mkdir -p " .. global.cache_dir)
    for _, v in pairs(data_dir) do
      if vim.fn.isdirectory(v) == 0 then
        os.execute("mkdir -p " .. v)
      end
    end
  end
end

local disable_distribution_plugins = function()
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_tutor_mode_plugin = 1
  vim.g.loaded_remote_plugins = 1
  vim.g.loaded_spellfile_plugin = 1
  vim.g.loaded_shada_plugin = 1
end

local setup_copilot = function()
  vim.cmd [[
    imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true
    let g:copilot_assume_mapped = v:true
    let g:copilot_tab_fallback = ""
  ]]
end

local set_leader_map = function()
  vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
  vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
  vim.api.nvim_set_keymap("i", "<C-c>", "<esc>", { noremap = true })
  vim.api.nvim_set_keymap("n", "<C-c>", "<esc>", { noremap = true })
  vim.api.nvim_set_keymap("v", "<C-c>", "<esc>", { noremap = true })
  vim.g.mapleader = " "
end

local set_colorscheme = function()
  vim.cmd [[colorscheme gruvbox]]
end

local setup_others_autocommands = function()
  vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" }, {
    callback = function()
      require("doodleVim.modules.py.winbar").get_winbar()
    end,
  })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })
end

local function load_nvim_config()
  disable_distribution_plugins()
  set_leader_map()
  options.load_options()
  event.load_autocmds()
  pack.ensure_plugins()
  pack.load_compile()
  require "doodleVim.core.command"
  set_colorscheme()
  defer.load(50)
  createdir()
  setup_copilot()
  setup_others_autocommands()
end

load_nvim_config()
