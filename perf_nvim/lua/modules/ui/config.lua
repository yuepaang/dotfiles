local config = {}

function config.lualine()
	require('modules.ui.lualine_config')
end

function config.treesitter()
	require('utils.defer').load_immediately('nvim-treesitter-textobjects')

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
			},
		}
	}
end

function config.blankline()
	vim.g.indent_blankline_filetype_exclude = { "help", "packer" , "alpha" }
	vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
	require("indent_blankline").setup {
		show_end_of_line = true,
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
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter_opts = {
			relative_time = false
		},
	}
end

return config
