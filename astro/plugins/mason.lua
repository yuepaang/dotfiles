return {
	{
		{ "williamboman/mason.nvim", opts = { PATH = "append" } },
		{
			"williamboman/mason-lspconfig.nvim",
			opts = {
				ensure_installed = {
					-- "clangd",
					-- "cssls",
					"gopls",
					-- "html",
					-- "intelephense",
					"marksman",
					"neocmake",
					"jsonls",
					-- "julials",
					"pyright",
					"sqls",
					"lua_ls",
					"taplo",
					"texlab",
					"tsserver",
					"yamlls",
					"rust_analyzer",
				},
			},
		},
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				"shellcheck",
				"stylua",
				"black",
				"isort",
				"prettierd",
				"shfmt",
			},
		},
		config = function(_, opts)
			local mason_null_ls = require("mason-null-ls")
			local null_ls = require("null-ls")
			mason_null_ls.setup(opts)
			mason_null_ls.setup_handlers({
				taplo = function() end, -- disable taplo in null-ls, it's taken care of by lspconfig
				prettierd = function()
					null_ls.register(
						null_ls.builtins.formatting.prettierd.with({ extra_filetypes = { "markdown", "rmd", "qmd" } })
					)
				end,
				shfmt = function()
					null_ls.register(null_ls.builtins.formatting.shfmt)
				end,
			})
		end,
	},
}
