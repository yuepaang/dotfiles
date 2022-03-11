local config = {}

function config.lualine()
    require("modules.ui.lualine_config")
end

function config.treesitter()
    if not packer_plugins["nvim-treesitter-textobjects"].loaded then
        vim.cmd([[PackerLoad nvim-treesitter-textobjects]])
    end

    vim.api.nvim_command("set foldmethod=expr")
    vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

    require("nvim-treesitter.configs").setup({
        ensure_installed = "maintained",
        sync_install = false,
        ignore_install = {""},
        highlight = {
            enable = true,
            disable = {"css"},
            additional_vim_regex_highlighting = false
        },
        autopairs = {
            enable = true
        },
        indent = {
            enable = true,
            disable = {"yaml", "css"}
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil
        },
        endwise = {
            enable = true
        },
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
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
                    ["ih"] = "@call.inner"
                }
            }
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false
        }
    })
end

function config.blankline()
    vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
    vim.g.indent_blankline_filetype_exclude = {"help", "startify", "dashboard", "packer", "neogitstatus", "NvimTree",
                                               "Trouble"}
    vim.g.indentLine_enabled = 1
    -- vim.g.indent_blankline_char = "│"
    vim.g.indent_blankline_char = "▏"
    -- vim.g.indent_blankline_char = "▎"
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = true
    vim.g.indent_blankline_use_treesitter = true
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_context_patterns = {"class", "return", "function", "method", "^if", "^while", "jsx_element",
                                               "^for", "^object", "^table", "block", "arguments", "if_statement",
                                               "else_clause", "jsx_element", "jsx_self_closing_element",
                                               "try_statement", "catch_clause", "import_statement", "operation_type"}
    require("indent_blankline").setup({
        -- char = "▏",
        -- show_end_of_line = true,
        -- disable_with_nolist = true,
        -- buftype_exclude = {"terminal"},
        -- filetype_exclude = {"help", "git", "markdown", "snippets", "text", "gitconfig", "alpha"},
        show_current_context = true
    })
    vim.cmd([[
        function! Should_activate_indentblankline() abort
            if index(g:indent_blankline_filetype_exclude, &filetype) == -1
                IndentBlanklineEnable
            endif
        endfunction

        augroup indent_blankline
            autocmd!
            autocmd InsertEnter * IndentBlanklineDisable
            autocmd InsertLeave * call Should_activate_indentblankline()
        augroup END
    ]])
end

function config.lspsaga()
    local lspsaga = require("lspsaga")
    lspsaga.setup({ -- defaults ...
        debug = false,
        use_saga_diagnostic_sign = true,
        use_diagnostic_virtual_text = false,
        -- diagnostic sign
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        -- code action title icon
        code_action_icon = " ",
        code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 40,
            virtual_text = false
        },
        -- finder_definition_icon = "  ",
        -- finder_reference_icon = "  ",
        -- max_preview_lines = 10,
        -- finder_action_keys = {
        --   open = "o",
        --   vsplit = "s",
        --   split = "i",
        --   quit = "q",
        --   scroll_down = "<C-f>",
        --   scroll_up = "<C-b>",
        -- },
        code_action_keys = {
            quit = "<C-c>",
            exec = "<CR>"
        },
        rename_action_keys = {
            quit = "<C-c>",
            exec = "<CR>"
        },
        -- definition_preview_icon = "  ",
        border_style = "round",
        rename_prompt_prefix = "➤",
        rename_output_qflist = {
            enable = false,
            auto_open_qflist = false
        },
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
        diagnostic_message_format = "%m %c",
        highlight_prefix = true
    })
end

function config.gitsigns()
    require("gitsigns").setup {
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = "▎",
                numhl = "GitSignsAddNr",
                linehl = "GitSignsAddLn"
            },
            change = {
                hl = "GitSignsChange",
                text = "▎",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn"
            },
            delete = {
                hl = "GitSignsDelete",
                text = "契",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn"
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "契",
                numhl = "GitSignsDeleteNr",
                linehl = "GitSignsDeleteLn"
            },
            changedelete = {
                hl = "GitSignsChange",
                text = "▎",
                numhl = "GitSignsChangeNr",
                linehl = "GitSignsChangeLn"
            }
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false
        },
        current_line_blame_formatter_opts = {
            relative_time = false
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
            -- Options passed to nvim_open_win
            border = "rounded",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1
        },
        yadm = {
            enable = false
        }
    }
end

function config.hlslens()
    require("hlslens").setup({})
end

function config.gps()
    require("nvim-gps").setup({})
end

function config.doom_one()
    require("doom-one").setup({
        cursor_coloring = true,
        terminal_colors = true,
        italic_comments = true,
        enable_treesitter = true,
        transparent_background = true,
        pumblend = {
            enable = true,
            transparency_amount = 20
        },
        plugins_integrations = {
            neorg = true,
            barbar = true,
            bufferline = true,
            gitgutter = true,
            gitsigns = true,
            telescope = true,
            neogit = true,
            nvim_tree = true,
            dashboard = true,
            startify = true,
            whichkey = true,
            indent_blankline = true,
            vim_illuminate = true,
            lspsaga = true
        }
    })
end

function config.alpha()
    local dashboard = require("alpha.themes.dashboard")
    local function header()
        return {[[                                               ]],
                [[ppppppppppppppp    yyyyyyy            yyyyyyy  ]],
                [[p::::::::::::::pp   y:::::y          y:::::y   ]],
                [[p::::::::::::::::p   y:::::y        y:::::y    ]],
                [[pp::::::::::::::::p   y:::::y      y:::::y     ]],
                [[  p:::::pppppp:::::p    y:::::y   y:::::y      ]],
                [[  p::::p     p:::::p     y:::::y y:::::y       ]],
                [[  p::::p     p:::::p      y:::::y:::::y        ]],
                [[  p::::p     p:::::p       y:::::::::y         ]],
                [[  p::::p   p:::::p          y:::::::y          ]],
                [[  p::::pppp::::p             y:::::y           ]],
                [[  p:::::::::::p               y:::y            ]],
                [[  p:::::::::p                 y:::y            ]],
                [[  p::::p                      y:::y            ]],
                [[  p::::p                      y:::y            ]],
                [[  p::::p                      y:::y            ]],
                [[  p::::p                      y:::y            ]],
                [[  p::::p                      y:::y            ]],
                [[  p::::p                      y:::y            ]],
                [[  p::::p                      y:::y            ]], [[  pppppp                       yyy             ]]}
    end
    dashboard.section.header.val = header()

    dashboard.section.buttons.val = {dashboard.button("f", "  Find files", ":Telescope find_files <CR>"),
                                     dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                                     dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
                                     dashboard.button("r", " Recent files", ":Telescope oldfiles <CR>"),
                                     dashboard.button("q", "  Quit Neovim", ":qa<CR>")}

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

    dashboard.opts.opts.noautocmd = true
    require("alpha").setup(dashboard.opts)
end

return config
