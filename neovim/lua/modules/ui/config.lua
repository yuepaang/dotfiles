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
	ensure_installed = {
		"bash",
		"cmake",
		"comment",
		"c",
		"cpp",
		"dot",
		"dockerfile",
		"go",
		"gomod",
		"gowork",
		"hjson",
		"html",
		"lua",
		"make",
		"python",
		"regex",
		"rust",
		"toml",
		"vim",
		"yaml",
	},
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
	context_commentstring = {
        enable = true
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
			["ih"] = "@call.inner",
		  },
		  swap = {
			  enable = true,
			  swap_next = {
				["<leader>a"] = "@parameter.inner",
			  },
			  swap_previous = {
				["<leader>A"] = "@parameter.inner",
			  },
          },
          move = {
			  enable = true,
			  set_jumps = true, -- whether to set jumps in the jumplist
			  goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			  },
			  goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			  },
			  goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			  },
			  goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			  },
          },
          lsp_interop = {
			  enable = true,
			  border = 'none',
			  peek_definition_code = {
				["<leader>sd"] = "@function.outer",
				["<leader>sD"] = "@class.outer",
			  },
          },
		},
	}
  }
end

-- function config.barbar()
-- 	vim.g.bufferline = {
-- 		-- Enable/disable animations
-- 		animation = true,
--
-- 		-- Enable/disable auto-hiding the tab bar when there is a single buffer
-- 		auto_hide = true,
--
-- 		-- Enable/disable current/total tabpages indicator (top right corner)
-- 		tabpages = true,
--
-- 		-- Enable/disable close button
-- 		closable = true,
--
-- 		-- Enables/disable clickable tabs
-- 		--  - left-click: go to buffer
-- 		--  - middle-click: delete buffer
-- 		clickable = true,
--
-- 		-- Excludes buffers from the tabline
-- 		exclude_ft = {},
-- 		exclude_name = {},
--
-- 		-- Enable/disable icons
-- 		-- if set to 'numbers', will show buffer index in the tabline
-- 		-- if set to 'both', will show buffer index and icons in the tabline
-- 		icons = true,
--
-- 		-- If set, the icon color will follow its corresponding buffer
-- 		-- highlight group. By default, the Buffer*Icon group is linked to the
-- 		-- Buffer* group (see Highlighting below). Otherwise, it will take its
-- 		-- default value as defined by devicons.
-- 		icon_custom_colors = false,
--
-- 		-- Configure icons on the bufferline.
-- 		icon_separator_active = '│',
-- 		icon_separator_inactive = '│',
-- 		icon_close_tab = '',
-- 		icon_close_tab_modified = '●',
-- 		icon_pinned = '車',
--
-- 		-- If true, new buffers will be inserted at the end of the list.
-- 		-- Default is to insert after current buffer.
-- 		insert_at_end = false,
--
-- 		-- Sets the maximum padding width with which to surround each tab
-- 		maximum_padding = 1,
--
-- 		-- Sets the maximum buffer name length.
-- 		maximum_length = 30,
--
-- 		-- If set, the letters for each buffer in buffer-pick mode will be
-- 		-- assigned based on their name. Otherwise or in case all letters are
-- 		-- already assigned, the behavior is to assign letters in order of
-- 		-- usability (see order below)
-- 		semantic_letters = true,
--
-- 		-- New buffer letters are assigned in this order. This order is
-- 		-- optimal for the qwerty keyboard layout but might need adjustement
-- 		-- for other layouts.
-- 		letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
--
-- 		-- Sets the name of unnamed buffers. By default format is "[Buffer X]"
-- 		-- where X is the buffer number. But only a static string is accepted here.
-- 		no_name_title = nil,
-- 	}
-- end

function config.blankline()
	require("indent_blankline").setup {
		show_end_of_line = true,
	}
end

function config.lspsaga()
  local saga = require('lspsaga')
  saga.init_lsp_saga({
    code_action_keys = {
      quit = {"q", "<ESC>"},
    },
    rename_action_keys = {
      quit = {"q", "<ESC>"},
    },
  })
end

function config.lspaction()
	require("lspaction").setup({
		diagnostic_virtual_text = false
	})
end

return config
