return {
	{
		"simrat39/rust-tools.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		ft = { "rs" },
		opts = function()
			return {
				server = astronvim.lsp.server_settings("rust_analyzer"),
			}
		end,
	},
	{
		"olexsmir/gopher.nvim",
		ft = { "go" },
		config = function()
			require("gopher").setup({
				commands = {
					go = "go",
					gomodifytags = "gomodifytags",
					gotests = "~/go/bin/gotests", -- also you can set custom command path
					impl = "impl",
					iferr = "iferr",
				},
			})
		end,
	},
	{
		"saecki/crates.nvim",
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	},
}
