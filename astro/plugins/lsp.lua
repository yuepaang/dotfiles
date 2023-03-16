return {
	{ "lvimuser/lsp-inlayhints.nvim", config = true },
	{
		"Maan2003/lsp_lines.nvim",
		event = "User AstroFile",
		config = function()
			require("lsp_lines").setup()
		end,
	},
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
}
