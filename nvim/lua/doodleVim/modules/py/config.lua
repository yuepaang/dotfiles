local config = {}

function config.better_escape()
  require("better_escape").setup {
    mapping = { "ii", "jj", "jk", "kj" },
    timeout = vim.o.timeoutlen,
    keys = "<ESC>",
  }
end

function config.leap()
  local leap = require "leap"
  leap.set_default_keymaps()
end

function config.crates()
  require("crates").setup {
    popup = {
      -- autofocus = true,
      style = "minimal",
      border = "rounded",
      show_version_date = false,
      show_dependency_version = true,
      max_height = 30,
      min_width = 20,
      padding = 1,
    },
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  }
end

return config
