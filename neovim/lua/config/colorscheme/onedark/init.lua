vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "onedark"

C = require("config.colorscheme.onedark.colors")

local util = require("config.colorscheme.onedark.util")
local base = require("config.colorscheme.onedark.base")
local treesitter = require("config.colorscheme.onedark.treesitter")
local lsp = require("config.colorscheme.onedark.lsp")
local others = require("config.colorscheme.onedark.others")

local onedark = {
  base,
  treesitter,
  lsp,
  others,
}

for _, file in ipairs(onedark) do
  for group, colors in pairs(file) do
    util.highlight(group, colors)
  end
end
