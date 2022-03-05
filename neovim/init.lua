local bind = require('utils.bind')
local map_cmd = bind.map_cmd

local plug_map = {
  -- ["n|<CR>"] = map_cmd(":nohlsearch<CR><CR>"):with_noremap(),
  ["n|<C-s>"] = map_cmd(":w<CR>"):with_noremap(),
  ["n|<C-q>"] = map_cmd(":q<CR>"):with_noremap(),
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

require "config"
require "utils"
require("plugins").setup()

