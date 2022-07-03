local py = {}
local conf = require "doodleVim.modules.py.config"

py["wakatime/vim-wakatime"] = {}

py["github/copilot.vim"] = {}

py["max397574/better-escape.nvim"] = {
  event = { "InsertEnter" },
  config = conf.better_escape,
}

py["ggandor/leap.nvim"] = {
  requires = { "tpope/vim-repeat" },
  keys = { "s", "S", "f", "F", "t", "T" },
  config = conf.leap,
  event = "BufRead",
}

py["simrat39/rust-tools.nvim"] = {
  after = { "nvim-lspconfig" },
}

py["Saecki/crates.nvim"] = {
  after = "null-ls.nvim",
  config = conf.crates,
  requires = { "nvim-lua/plenary.nvim" },
}

py["christianchiarulli/nvim-gps"] = {
  after = "nvim-treesitter",
  branch = "text_hl",
  config = conf.gps,
}

py["abecodes/tabout.nvim"] = {
  after = "nvim-treesitter",
  config = conf.tabout,
}

py["stevearc/aerial.nvim"] = {}

py["j-hui/fidget.nvim"] = {
  config = conf.fidget,
}

py["drybalka/tree-climber.nvim"] = {
  config = conf.tree_climber,
}

return py
