local M = {}

local py_logo = {
  [[                                          ]],
  [[                                          ]],
  [[                                          ]],
  [[                                          ]],
  [[                                          ]],
  [[             ███████ ██    ██             ]],
  [[             ██   ██  ██  ██              ]],
  [[             ███████   ████               ]],
  [[             ██         ██                ]],
  [[             ██         ██                ]],
  [[                                          ]],
  [[         ██    ██ ██ ███    ███           ]],
  [[         ██    ██ ██ ████  ████           ]],
  [[         ██    ██ ██ ██ ████ ██           ]],
  [[          ██  ██  ██ ██  ██  ██           ]],
  [[           ████   ██ ██      ██           ]],
  [[                                          ]],
  [[                                          ]],
  [[                                          ]],
}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local dashboard = require "alpha.themes.dashboard"
  -- local function header()
  --   return {
  --     [[                                                  ]],
  --     [[   ppppppppppppppp    yyyyyyy            yyyyyyy  ]],
  --     [[   p::::::::::::::pp   y:::::y          y:::::y   ]],
  --     [[   p::::::::::::::::p   y:::::y        y:::::y    ]],
  --     [[   pp::::::::::::::::p   y:::::y      y:::::y     ]],
  --     [[     p:::::pppppp:::::p    y:::::y   y:::::y      ]],
  --     [[     p::::p     p:::::p     y:::::y y:::::y       ]],
  --     [[     p::::p     p:::::p      y:::::y:::::y        ]],
  --     [[     p::::p     p:::::p       y:::::::::y         ]],
  --     [[     p::::p   p:::::p          y:::::::y          ]],
  --     [[     p::::pppp::::p             y:::::y           ]],
  --     [[     p:::::::::::p               y:::y            ]],
  --     [[     p:::::::::p                 y:::y            ]],
  --     [[     p::::p                      y:::y            ]],
  --     [[     p::::p                      y:::y            ]],
  --     [[     p::::p                      y:::y            ]],
  --     [[     p::::p                      y:::y            ]],
  --     [[     p::::p                      y:::y            ]],
  --     [[     p::::p                      y:::y            ]],
  --     [[     p::::p                      y:::y            ]],
  --     [[     pppppp                       yyy             ]],
  --   }
  -- end
  local function header()
    return require("utils.logos")["random"]
  end

  dashboard.section.header.val = header()
  -- dashboard.section.header.val = py_logo

  dashboard.section.buttons.val = {
    dashboard.button("f", "  Find files", ":Telescope find_files <CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("r", " Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
  }

  local function footer()
    -- Number of plugins
    local total_plugins = #vim.tbl_keys(packer_plugins)
    local datetime = os.date "%d-%m-%Y %H:%M:%S"
    local plugins_text = "   "
      .. total_plugins
      .. " plugins"
      .. "   v"
      .. vim.version().major
      .. "."
      .. vim.version().minor
      .. "."
      .. vim.version().patch
      .. "   "
      .. datetime

    -- Quote
    local fortune = require "alpha.fortune"
    local quote = table.concat(fortune(), "\n")

    return plugins_text .. "\n" .. quote
  end

  dashboard.section.footer.val = footer()

  dashboard.section.footer.opts.hl = "Constant"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Function"
  dashboard.section.buttons.opts.hl_shortcut = "Type"

  dashboard.opts.opts.noautocmd = true

  alpha.setup(dashboard.opts)
end

return M
