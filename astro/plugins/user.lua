return {
	-- You can also add new plugins here as well:
	-- Add plugins, the lazy syntax
	-- "andweeb/presence.nvim",
	-- {
	--   "ray-x/lsp_signature.nvim",
	--   event = "BufRead",
	--   config = function()
	--     require("lsp_signature").setup()
	--   end,
	-- },
	{
		"github/copilot.vim",
		event = "VimEnter",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_tab_fallback = ""
			vim.g.copilot_filetypes = {
				["*"] = false,
				python = true,
				lua = true,
				go = true,
				rust = true,
				html = true,
				c = true,
				cpp = true,
				java = true,
				javascript = true,
				typescript = true,
				javascriptreact = true,
				typescriptreact = true,
				terraform = true,
			}
		end,
	},
	{
		"alpertuna/vim-header",
		event = "VimEnter",
	},
}
