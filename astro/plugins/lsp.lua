return {
	{ "lvimuser/lsp-inlayhints.nvim", config = true },
	-- {
	-- 	"Maan2003/lsp_lines.nvim",
	-- 	event = "User AstroFile",
	-- 	config = function()
	-- 		require("lsp_lines").setup()
	-- 	end,
	-- },
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
}
