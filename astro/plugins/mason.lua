return {
	{
		-- { "williamboman/mason.nvim", opts = { PATH = "append" } },
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
		handlers = {
			taplo = function() end, -- disable taplo in null-ls, it's taken care of by lspconfig
		},
	},
}
