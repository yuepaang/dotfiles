local config = {}

function config.lualine()
    require('modules.ui.lualine_config')
end

function config.treesitter()
    if not packer_plugins['nvim-treesitter-textobjects'].loaded then
        vim.cmd [[PackerLoad nvim-treesitter-textobjects]]
    end

    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')

    require('nvim-treesitter.configs').setup {
        ensure_installed = {"bash", "cmake", "comment", "c", "cpp", "dot", "dockerfile", "go", "gomod", "gowork",
                            "hjson", "html", "lua", "make", "python", "regex", "rust", "toml", "vim", "yaml"},
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false
        },
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		},
		textsubjects = {
			enable = true,
			prev_selection = ',', -- (Optional) keymap to select the previous selection
			keymaps = {
			  ['.'] = 'textsubjects-smart',
			  -- [';'] = 'textsubjects-container-outer',
			},
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
		autotag = {
			enable = true,
		},
		context_commentstring = {
			enable = true
		},
    }
end

function config.blankline()
    require("indent_blankline").setup {
        show_end_of_line = true
    }
end

function config.lspsaga()
    local lspsaga = require 'lspsaga'
    lspsaga.setup { -- defaults ...
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
    }
end

function config.gitsigns()
    require('gitsigns').setup{
        keymaps = {},
        watch_gitdir = {
            interval = 2000,
            follow_files = true
        },
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 100,
            ignore_whitespace = false
        },
        current_line_blame_formatter_opts = {
            relative_time = false
        }
    }
end

function config.fidget()
	require('fidget').setup {}
end

function config.hlslens()
	require('hlslens').setup {}
end

function config.scrollbar()
	require('scrollbar').setup {
		require('scrollbar.handlers.search').setup()
	}
end

function config.spellsitter()
	require('spellsitter').setup {
		enable = true,
	}
end

function config.alpha()
	local dashboard = require "alpha.themes.dashboard"
	local function header()
		return {
		  [[                                               ]],
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
		  [[  p::::p                      y:::y            ]],
		  [[  pppppp                       yyy             ]],
		}
	end
	dashboard.section.header.val = header()

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
		local plugins_text =
		  "   "
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
	require('alpha').setup(dashboard.opts)
end

return config
