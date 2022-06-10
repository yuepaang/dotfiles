local M = {}

local icons = require "config.icons"

local error_red = "#F44747"
local warning_orange = "#ff8800"
local info_yellow = "#FFCC66"
local hint_blue = "#4FC1FF"
local perf_purple = "#7C3AED"

function M.setup()
  require("todo-comments").setup {
    signs = true,
    keywords = {
      FIX = { icon = icons.ui.Bug, color = error_red },
      TODO = { icon = icons.ui.Check, color = hint_blue },
      HACK = { icon = icons.ui.Fire, color = warning_orange },
      WARN = { icon = icons.diagnostics.Warning, color = warning_orange },
      PERF = { icon = icons.ui.Dashboard, color = perf_purple },
      NOTE = { icon = icons.ui.Note, color = info_yellow },
    },
    -- newly add
    sign_priority = 8, -- sign priority
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    highlight = {
      before = "", -- "fg" or "bg" or empty
      keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\v(\s?\(.*\)|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
      -- pattern = [[.*<(KEYWORDS)\v(\s|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    colors = {
      error = { "#fb4934" },
      hack = { "#fe8019" },
      warning = { "#fabd2f" },
      info = { "#458588" },
      hint = { "#10B981" },
      default = { "#7C3AED" },
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS)(\s?\(.*\)|:)+]], -- ripgrep regex
    },
  }
end

return M
