local py = {}
local conf = require("doodleVim.modules.py.config")

py["wakatime/vim-wakatime"] = {}

py["github/copilot.vim"] = { event = "InsertEnter" }

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

py["ghillb/cybu.nvim"] = {
  config = function()
    local ok, cybu = pcall(require, "cybu")
    if not ok then
      return
    end
    cybu.setup({
      position = {
        relative_to = "win", -- win, editor, cursor
        anchor = "topright", -- topleft, topcenter, topright,
        -- centerleft, center, centerright,
        -- bottomleft, bottomcenter, bottomright
        -- vertical_offset = 10, -- vertical offset from anchor in lines
        -- horizontal_offset = 0, -- vertical offset from anchor in columns
        -- max_win_height = 5, -- height of cybu window in lines
        -- max_win_width = 0.5, -- integer for absolute in columns
        -- float for relative to win/editor width
      },
      display_time = 1750, -- time the cybu window is displayed
      style = {
        path = "relative", -- absolute, relative, tail (filename only)
        border = "rounded", -- single, double, rounded, none
        separator = " ", -- string used as separator
        prefix = "…", -- string used as prefix for truncated paths
        padding = 1, -- left & right padding in number of spaces
        devicons = {
          enabled = true, -- enable or disable web dev icons
          colored = true, -- enable color for web dev icons
        },
      },
    })
    vim.keymap.set("n", "H", "<Plug>(CybuPrev)")
    vim.keymap.set("n", "L", "<Plug>(CybuNext)")
  end,
}

py["matbme/JABS.nvim"] = {
  config = function()
    local status_ok, jabs = pcall(require, "jabs")
    if not status_ok then
      return
    end
    jabs.setup({
      position = "center", -- center, corner
      width = 50,
      height = 10,
      border = "rounded", -- none, single, double, rounded, solid, shadow, (or an array or chars)

      -- Options for preview window
      preview_position = "top", -- top, bottom, left, right
      preview = {
        width = 70,
        height = 20,
        border = "rounded", -- none, single, double, rounded, solid, shadow, (or an array or chars)
      },

      -- the options below are ignored when position = 'center'
      -- col = ui.width,  -- Window appears on the right
      -- row = ui.height/2, -- Window appears in the vertical middle
    })
  end,
}

return py
