local M = {}

function M.setup()
    local status_ok, alpha = pcall(require, "alpha")
    if not status_ok then
        return
    end

    local dashboard = require("alpha.themes.dashboard")
    local function header()
        return {[[                                          ]], [[                                          ]],
                [[                                          ]], [[                                          ]],
                [[                                          ]],
                [[            ███████ ██    ██              ]],
                [[            ██   ██  ██  ██               ]],
                [[            ███████   ████                ]],
                [[            ██         ██                 ]],
                [[            ██         ██                 ]], [[                                          ]],
                [[        ██    ██ ██ ███    ███            ]],
                [[        ██    ██ ██ ████  ████            ]],
                [[        ██    ██ ██ ██ ████ ██            ]],
                [[         ██  ██  ██ ██  ██  ██            ]],
                [[          ████   ██ ██      ██            ]],
                [[                                          ]], [[                                          ]],
                [[                                          ]]}
        -- return {
        -- 	[[                                                  ]],
        -- 	[[   ppppppppppppppp    yyyyyyy            yyyyyyy  ]],
        -- 	[[   p::::::::::::::pp   y:::::y          y:::::y   ]],
        -- 	[[   p::::::::::::::::p   y:::::y        y:::::y    ]],
        -- 	[[   pp::::::::::::::::p   y:::::y      y:::::y     ]],
        -- 	[[     p:::::pppppp:::::p    y:::::y   y:::::y      ]],
        -- 	[[     p::::p     p:::::p     y:::::y y:::::y       ]],
        -- 	[[     p::::p     p:::::p      y:::::y:::::y        ]],
        -- 	[[     p::::p     p:::::p       y:::::::::y         ]],
        -- 	[[     p::::p   p:::::p          y:::::::y          ]],
        -- 	[[     p::::pppp::::p             y:::::y           ]],
        -- 	[[     p:::::::::::p               y:::y            ]],
        -- 	[[     p:::::::::p                 y:::y            ]],
        -- 	[[     p::::p                      y:::y            ]],
        -- 	[[     p::::p                      y:::y            ]],
        -- 	[[     p::::p                      y:::y            ]],
        -- 	[[     p::::p                      y:::y            ]],
        -- 	[[     p::::p                      y:::y            ]],
        -- 	[[     p::::p                      y:::y            ]],
        -- 	[[     p::::p                      y:::y            ]],
        -- 	[[     pppppp                       yyy             ]],
        -- }
    end

    dashboard.section.header.val = header()

    dashboard.section.buttons.val = {dashboard.button("SPC f h", "  Recent Projects"),
                                     dashboard.button("SPC f o", "  Recent File"),
                                     dashboard.button("SPC f f", "  Find File"),
                                     dashboard.button("SPC f b", "  File Browser"),
                                     dashboard.button("SPC p u", "  Update Plugins"),
                                     dashboard.button("e", "  New file", "<cmd>ene <CR>"),
                                     dashboard.button("s", "  Configuration", "<cmd>e $MYVIMRC<CR>"),
                                     dashboard.button("q", "  Quit", "<cmd>qa<cr>")}

    local function footer()
        -- Number of plugins
        local total_plugins = #vim.tbl_keys(packer_plugins)
        local datetime = os.date("%d-%m-%Y %H:%M:%S")
        local plugins_text = "   " .. total_plugins .. " plugins" .. "   v" .. vim.version().major .. "." ..
                                 vim.version().minor .. "." .. vim.version().patch .. "   " .. datetime

        -- Quote
        local fortune = require("alpha.fortune")
        local quote = table.concat(fortune(), "\n")

        return plugins_text .. "\n" .. quote
    end

    dashboard.section.footer.val = footer()

    dashboard.section.footer.opts.hl = "Constant"
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Function"
    dashboard.section.buttons.opts.hl_shortcut = "Type"

    dashboard.opts = {
        layout = {{
            type = "padding",
            val = 4
        }, dashboard.section.header, {
            type = "padding",
            val = 4
        }, dashboard.section.buttons, {
            type = "padding",
            val = 2
        }, dashboard.section.footer},
        opts = {
            margin = 5
        }
    }

    dashboard.opts.opts.noautocmd = true

    alpha.setup(dashboard.opts)
    vim.api.nvim_create_augroup("alpha_tabline", {
        clear = true
    })

    vim.api.nvim_create_autocmd("FileType", {
        group = "alpha_tabline",
        pattern = "alpha",
        command = "set showtabline=0 laststatus=0 noruler"
    })

    vim.api.nvim_create_autocmd("FileType", {
        group = "alpha_tabline",
        pattern = "alpha",
        callback = function()
            vim.api.nvim_create_autocmd("BufUnload", {
                group = "alpha_tabline",
                buffer = 0,
                command = "set showtabline=2 ruler laststatus=3"
            })
        end
    })
end

return M
