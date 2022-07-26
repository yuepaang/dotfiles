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

function config.gps()
  local status_ok, gps = pcall(require, "nvim-gps")
  if not status_ok then
    return
  end
  local icons = require "doodleVim.modules.py.icons"
  local space = ""
  -- Customized config
  gps.setup {

    disable_icons = false, -- Setting it to true will disable all icons

    icons = {
      ["class-name"] = "%#CmpItemKindClass#" .. icons.kind.Class .. "%*" .. space, -- Classes and class-like objects
      ["function-name"] = "%#CmpItemKindFunction#" .. icons.kind.Function .. "%*" .. space, -- Functions
      ["method-name"] = "%#CmpItemKindMethod#" .. icons.kind.Method .. "%*" .. space, -- Methods (functions inside class-like objects)
      ["container-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space, -- Containers (example: lua tables)
      ["tag-name"] = "%#CmpItemKindKeyword#" .. icons.misc.Tag .. "%*" .. " ", -- Tags (example: html tags)
      ["mapping-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space,
      ["sequence-name"] = "%#CmpItemKindProperty#" .. icons.type.Array .. "%*" .. space,
      ["null-name"] = "%#CmpItemKindField#" .. icons.kind.Field .. "%*" .. space,
      ["boolean-name"] = "%#CmpItemKindValue#" .. icons.type.Boolean .. "%*" .. space,
      ["integer-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
      ["float-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
      ["string-name"] = "%#CmpItemKindValue#" .. icons.type.String .. "%*" .. space,
      ["array-name"] = "%#CmpItemKindProperty#" .. icons.type.Array .. "%*" .. space,
      ["object-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space,
      ["number-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
      ["table-name"] = "%#CmpItemKindProperty#" .. icons.ui.Table .. "%*" .. space,
      ["date-name"] = "%#CmpItemKindValue#" .. icons.ui.Calendar .. "%*" .. space,
      ["date-time-name"] = "%#CmpItemKindValue#" .. icons.ui.Table .. "%*" .. space,
      ["inline-table-name"] = "%#CmpItemKindProperty#" .. icons.ui.Calendar .. "%*" .. space,
      ["time-name"] = "%#CmpItemKindValue#" .. icons.misc.Watch .. "%*" .. space,
      ["module-name"] = "%#CmpItemKindModule#" .. icons.kind.Module .. "%*" .. space,
    },

    -- Add custom configuration per language or
    -- Disable the plugin for a language
    -- Any language not disabled here is enabled by default
    -- languages = {
    -- 	-- Some languages have custom icons
    -- 	["json"] = {
    -- 		icons = {
    -- 		}
    -- 	},
    -- 	["toml"] = {
    -- 		icons = {
    -- 		}
    -- 	},
    -- 	["verilog"] = {
    -- 		icons = {
    -- 		}
    -- 	},
    -- 	["yaml"] = {
    -- 		icons = {
    -- 		}
    -- 	},

    -- Disable for particular languages
    -- ["bash"] = false, -- disables nvim-gps for bash
    -- ["go"] = false,   -- disables nvim-gps for golang

    -- Override default setting for particular languages
    -- ["ruby"] = {
    --	separator = '|', -- Overrides default separator with '|'
    --	icons = {
    --		-- Default icons not specified in the lang config
    --		-- will fallback to the default value
    --		-- "container-name" will fallback to default because it's not set
    --		["function-name"] = '',    -- to ensure empty values, set an empty string
    --		["tag-name"] = ''
    --		["class-name"] = '::',
    --		["method-name"] = '#',
    --	}
    --}
    -- },

    separator = " " .. icons.ui.ChevronRight .. " ",

    -- limit for amount of context shown
    -- 0 means no limit
    -- Note: to make use of depth feature properly, make sure your separator isn't something that can appear
    -- in context names (eg: function names, class names, etc)
    depth = 0,

    -- indicator used when context is hits depth limit
    depth_limit_indicator = "..",
    text_hl = "LineNr",
  }
end

function config.tabout()
  local status_ok, tabout = pcall(require, "tabout")
  if not status_ok then
    return
  end

  tabout.setup {
    tabkey = "<tab>", -- key to trigger tabout, set to an empty string to disable
    backwards_tabkey = "<s-tab>", -- key to trigger backwards tabout, set to an empty string to disable
    act_as_tab = true, -- shift content if tab out is not possible
    act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
    default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
    default_shift_tab = "<C-d>", -- reverse shift default action,
    enable_backwards = false, -- well ...
    completion = true, -- if the tabkey is used in a completion pum
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = "`", close = "`" },
      { open = "(", close = ")" },
      { open = "[", close = "]" },
      { open = "{", close = "}" },
    },
    ignore_beginning = false, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
    exclude = {}, -- tabout will ignore these filetypes
  }
end

function config.fidget()
  local status_ok, fidget = pcall(require, "fidget")
  if not status_ok then
    return
  end

  fidget.setup()
end

function config.header()
  vim.g.header_field_author = "Yue Peng"
  vim.g.header_field_author_email = "yuepaang@gmail.com"
end

return config
