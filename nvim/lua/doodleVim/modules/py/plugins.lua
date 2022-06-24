local py = {}
local conf = require("doodleVim.modules.py.config")

py["wakatime/vim-wakatime"] = {}

py["max397574/better-escape.nvim"] = {
  event = { "InsertEnter" },
  config = function()
    require("better_escape").setup({
      mapping = { "ii", "jj", "jk", "kj" },
      timeout = vim.o.timeoutlen,
      keys = "<ESC>",
    })
  end,
}

py["ggandor/leap.nvim"] = {
  requires = { "tpope/vim-repeat" },
  keys = { "s", "S", "f", "F", "t", "T" },
  config = conf.leap,
  event = "BufRead",
}

return py
