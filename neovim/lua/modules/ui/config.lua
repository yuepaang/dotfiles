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


function config.blankline()
	require("indent_blankline").setup {
		show_end_of_line = true,
	}
end

function config.lspsaga()
	local lspsaga = require 'lspsaga'
	lspsaga.setup { -- defaults ...
	  debug = false,
	  use_saga_diagnostic_sign = true,
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
	    virtual_text = false,
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
	    exec = "<CR>",
	  },
	  rename_action_keys = {
	    quit = "<C-c>",
	    exec = "<CR>",
	  },
	  -- definition_preview_icon = "  ",
	  border_style = "round",
	  rename_prompt_prefix = "➤",
	  rename_output_qflist = {
	    enable = false,
	    auto_open_qflist = false,
	  },
	  server_filetype_map = {},
	  diagnostic_prefix_format = "%d. ",
	  diagnostic_message_format = "%m %c",
	  highlight_prefix = true,
	}
end

return config
