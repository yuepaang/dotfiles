local config = {}

function config.treesitter(plugin, opts)
  require("nvim-treesitter.configs").setup({
    sync_install = true,
    auto_install = false,
    highlight = {
      enable = true,
      disable = { "lua", "help" },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ab"] = "@block.outer",
          ["ib"] = "@block.inner",
          ["as"] = "@statement.outer",
          ["ah"] = "@call.outer",
          ["ih"] = "@call.inner",
        },
      },
    },
  })
end

function config.alpha()
  require("doodleVim.modules.ui.alpha")
end

function config.lualine()
  require("doodleVim.modules.ui.lualine")
end

function config.todo()
  local codicons = require("codicons")
  require("todo-comments").setup({
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = codicons.get("tools"), -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE", "ERROR" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = {
        icon = codicons.get("checklist"),
        color = "info",
      },
      HACK = {
        icon = codicons.get("flame"),
        color = "warning",
      },
      WARN = {
        icon = codicons.get("warning"),
        color = "warning",
        alt = { "WARNING", "XXX" },
      },
      PERF = {
        icon = codicons.get("clock"),
        color = "default",
        alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
      },
      NOTE = {
        icon = codicons.get("note"),
        color = "hint",
        alt = { "INFO" },
      },
      TEST = { icon = "󰙨 ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    gui_style = {
      fg = "NONE", -- The gui style to use for the fg highlight group.
      bg = "BOLD", -- The gui style to use for the bg highlight group.
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      multiline = true, -- enable multine todo comments
      multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
      before = "", -- "fg" or "bg" or empty
      keyword = "bg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = "fg", -- "fg" or "bg" or empty
      -- pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
      pattern = [[.*<(KEYWORDS)\v(\s?\(.*\)|:)+]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
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
      args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      -- pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      pattern = [[\b(KEYWORDS)(\s?\(.*\)|:)+]], -- ripgrep regex
    },
  })
end

function config.gitsigns()
  require("gitsigns").setup({
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "rounded",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
  })
end

function config.blankline()
  local icons = require("doodleVim.modules.ui.icons")

  require("ibl").setup({
    exclude = {
      buftypes = { "terminal", "nofile" },
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
      },
    },
    scope = {
      enabled = true,
      char = icons.ui.LineMiddle,
      show_start = true,
    },
    indent = {
      char = icons.ui.LineMiddle,
    },
    whitespace = {
      remove_blankline_trail = true,
    },
  })
end

function config.barbar(plugin, opts)
  -- Set barbar's options
  require("barbar").setup({
    -- Enable/disable animations
    animation = true,

    -- Enable/disable auto-hiding the tab bar when there is a single buffer
    auto_hide = false,

    -- Enable/disable current/total tabpages indicator (top right corner)
    tabpages = true,

    -- Enables/disable clickable tabs
    --  - left-click: go to buffer
    --  - middle-click: delete buffer
    clickable = true,

    -- Excludes buffers from the tabline
    exclude_ft = { "alpha", "dap-repl" },
    exclude_name = { "alpha" },

    -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
    -- Valid options are 'left' (the default) and 'right'
    focus_on_close = "left",

    -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
    hide = {
      extensions = true,
      inactive = false,
    },

    -- Disable highlighting alternate buffers
    highlight_alternate = false,

    -- Disable highlighting file icons in inactive buffers
    highlight_inactive_file_icons = false,

    -- Enable highlighting visible buffers
    highlight_visible = true,

    icons = {
      -- Configure the base icons on the bufferline.
      buffer_index = true,
      buffer_number = false,
      button = "×",
      -- Enables / disables diagnostic symbols
      diagnostics = {
        [vim.diagnostic.severity.ERROR] = {
          enabled = false,
          icon = " ",
        },
        [vim.diagnostic.severity.WARN] = {
          enabled = false,
        },
        [vim.diagnostic.severity.INFO] = {
          enabled = false,
        },
        [vim.diagnostic.severity.HINT] = {
          enabled = false,
        },
      },
      filetype = {
        -- Sets the icon's highlight group.
        -- If false, will use nvim-web-devicons colors
        custom_colors = false,
        -- Requires `nvim-web-devicons` if `true`
        enabled = true,
      },
      separator = {
        left = "│",
        right = "",
      },
      separator_at_end = true,
      -- Configure the icons on the bufferline when modified or pinned.
      -- Supports all the base icon options.
      modified = {
        button = "●",
      },
      pinned = {
        button = "車",
      },
      -- Configure the icons on the bufferline based on the visibility of a buffer.
      -- Supports all the base icon options, plus `modified` and `pinned`.
      alternate = {
        filetype = {
          enabled = false,
        },
      },
      current = {
        buffer_index = true,
      },
      inactive = {
        button = "×",
        buffer_index = true,
      },
      visible = {
        modified = {
          buffer_number = false,
        },
      },
    },

    -- If true, new buffers will be inserted at the start/end of the list.
    -- Default is to insert after current buffer.
    insert_at_end = true,
    insert_at_start = false,

    -- Sets the maximum padding width with which to surround each tab
    maximum_padding = 1,

    -- Sets the minimum padding width with which to surround each tab
    minimum_padding = 1,

    -- Sets the maximum buffer name length.
    maximum_length = 30,

    -- If set, the letters for each buffer in buffer-pick mode will be
    -- assigned based on their name. Otherwise or in case all letters are
    -- already assigned, the behavior is to assign letters in order of
    -- usability (see order below)
    semantic_letters = true,

    -- New buffer letters are assigned in this order. This order is
    -- optimal for the qwerty keyboard layout but might need adjustement
    -- for other layouts.
    letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",

    -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
    -- where X is the buffer number. But only a static string is accepted here.
    no_name_title = nil,
  })
end

function config.fidget()
  require("fidget").setup({
    integration = {
      ["nvim-tree"] = {
        enable = true,
      },
    },

    notification = {
      window = {
        normal_hl = "CursorLineNr", -- Base highlight group in the notification window
        winblend = 100, -- Background color opacity in the notification window
        border = "none", -- Border around the notification window
        zindex = 45, -- Stacking priority of the notification window
        max_width = 0, -- Maximum width of the notification window
        max_height = 0, -- Maximum height of the notification window
        x_padding = 1, -- Padding from right edge of window boundary
        y_padding = 0, -- Padding from bottom edge of window boundary
        align = "bottom", -- How to align the notification window
        relative = "editor", -- What the notification window position is relative to
      },
    },
  })
end

return config
