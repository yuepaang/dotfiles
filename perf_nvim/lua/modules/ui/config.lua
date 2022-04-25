local config = {}

function config.lualine()
	require("modules.ui.lualine_config")
end

function config.treesitter()
	require("utils.defer").load_immediately("nvim-treesitter-textobjects")

	vim.api.nvim_command("set foldmethod=expr")
	vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		sync_install = false,
		ignore_install = { "phpdoc" },
		highlight = {
			enable = true,
			disable = { "css", "markdown" }, -- list of language that will be disabled
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
			disable = { "python", css },
		},
		rainbow = {
			enable = true,
			disable = { "html" },
			extended_mode = false,
			max_file_lines = nil,
		},
		autotag = {
			enable = true,
		},
		autopairs = {
			enable = true,
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
		},
	})
end

function config.blankline()
	vim.g.indentLine_enabled = 1
	vim.g.indent_blankline_show_trailing_blankline_indent = false
	vim.g.indent_blankline_show_first_indent_level = true
	vim.g.indent_blankline_use_treesitter = true
	vim.g.indent_blankline_show_current_context = true
	vim.g.indent_blankline_char = "▏"
	vim.g.indent_blankline_buftype_exclude = {
		"nofile",
		"terminal",
		"lsp-installer",
		"lspinfo",
	}
	vim.g.indent_blankline_filetype_exclude = {
		"help",
		"startify",
		"dashboard",
		"packer",
		"neogitstatus",
		"NvimTree",
		"neo-tree",
		"Trouble",
		"alpha",
	}
	vim.g.indent_blankline_context_patterns = {
		"class",
		"return",
		"function",
		"method",
		"^if",
		"^while",
		"jsx_element",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
		"if_statement",
		"else_clause",
		"jsx_element",
		"jsx_self_closing_element",
		"try_statement",
		"catch_clause",
		"import_statement",
		"operation_type",
	}

	vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
	require("indent_blankline").setup({
		show_end_of_line = true,
		show_current_context_start = false,
	})
end

function config.gitsigns()
	require("gitsigns").setup({
		signs = {
			add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
			change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
			delete = { hl = "GitSignsDelete", text = "▎", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
			topdelete = {
				hl = "GitSignsDelete",
				text = "契",
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = "▎",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		keymaps = {
			-- Default keymap options
			noremap = true,
			buffer = true,
			["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'" },
			["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter_opts = {
			relative_time = false,
		},
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil,
		max_file_length = 40000,
		preview_config = {
			border = "single",
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

return config
