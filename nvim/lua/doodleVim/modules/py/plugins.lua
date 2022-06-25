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

py["zbirenbaum/copilot.lua"] = {

  event = { "VimEnter" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup({
        cmp = {
          enabled = true,
          method = "getPanelCompletions",
        },
        panel = { -- no config options yet
          enabled = true,
        },
        ft_disable = { "markdown" },
        -- plugin_manager_path = vim.fn.stdpath "data" .. "/site/pack/packer",
        -- server_opts_overrides = {},
      })
    end, 100)
  end,
}
py["zbirenbaum/copilot-cmp"] = {

  module = "copilot_cmp",
}

return py
