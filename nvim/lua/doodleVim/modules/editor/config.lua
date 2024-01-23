local config = {}

function config.comment()
  vim.g.skip_ts_context_commentstring_module = true
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })
  require("Comment").setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = "gcc",
      ---Block-comment toggle keymap
      block = "gbc",
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = "gc",
      ---Block-comment keymap
      block = "gb",
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = "gcO",
      ---Add comment on the line below
      below = "gco",
      ---Add comment at the end of line
      eol = "gcA",
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    ---Function to call after (un)comment
    -- post_hook = nil,
  })
end

function config.neoscroll()
  require("neoscroll").setup({
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = { "<C-f>", "<C-b>" },
    hide_cursor = false, -- Hide cursor while scrolling
    stop_eof = true, -- Stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil, -- Default easing function
    pre_hook = nil, -- Function to run before the scrolling animation starts
    post_hook = nil, -- Function to run after the scrolling animation ends
    performance_mode = false,
  })
end

function config.hop()
  require("hop").setup()
end

function config.nvim_surround()
  -- require("nvim-surround").setup({
  --   keymaps = {
  --     insert = "<C-y>s",
  --     insert_line = "<C-y>l",
  --     normal = "ys",
  --     normal_cur = "yss",
  --     normal_line = "yl",
  --     normal_cur_line = "yll",
  --     visual = "s",
  --     visual_line = "gl",
  --     delete = "ds",
  --     change = "cs",
  --   },
  -- })

  require("nvim-surround").setup({
    keymaps = { -- vim-surround style keymaps
      insert = "<C-g>s",
      insert_line = "<C-g>S",
      normal = "s",
      normal_cur = "ss",
      normal_line = "S",
      normal_cur_line = "SS",
      visual = "s",
      visual_line = "gS",
      delete = "ds",
      change = "cs",
    },
  })

  vim.cmd([[nmap <leader>' siw']])
end

function config.codewindow(plugin)
  require("codewindow").setup({
    active_in_terminals = false, -- Should the minimap activate for terminal buffers
    auto_enable = false, -- Automatically open the minimap when entering a (non-excluded) buffer (accepts a table of filetypes)
    exclude_filetypes = {
      "NvimTree",
      "Outline",
    }, -- Choose certain filetypes to not show minimap on
    max_minimap_height = nil, -- The maximum height the minimap can take (including borders)
    max_lines = nil, -- If auto_enable is true, don't open the minimap for buffers which have more than this many lines.
    minimap_width = 20, -- The width of the text part of the minimap
    use_lsp = true, -- Use the builtin LSP to show errors and warnings
    use_treesitter = true, -- Use nvim-treesitter to highlight the code
    use_git = true, -- Show small dots to indicate git additions and deletions
    width_multiplier = 4, -- How many characters one dot represents
    z_index = 1, -- The z-index the floating window will be on
    show_cursor = true, -- Show the cursor position in the minimap
    window_border = "single", -- The border style of the floating window (accepts all usual options)
  })
end

function config.bufdelete()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }
  -- keymap("n", "Q", "<cmd>Bdelete!<CR>", opts)
  keymap("n", "Q", ":lua require('bufdelete').bufdelete(0, false)<cr>", opts)
end

function config.matchup()
  vim.g.matchup_matchparen_offscreen = { method = nil }
  vim.g.matchup_matchpref = { html = { nolists = 1 } }
end

return config
