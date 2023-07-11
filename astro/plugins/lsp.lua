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
	{ "lvimuser/lsp-inlayhints.nvim", config = true },
	-- {
	-- 	"lvimuser/lsp-inlayhints.nvim",
	-- 	branch = "anticonceal",
	-- 	init = function()
	-- 		vim.api.nvim_create_autocmd("LspAttach", {
	-- 			group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
	-- 			callback = function(args)
	-- 				if not (args.data and args.data.client_id) then
	-- 					return
	-- 				end
	-- 				local client = vim.lsp.get_client_by_id(args.data.client_id)
	-- 				if client.server_capabilities.inlayHintProvider then
	-- 					local inlayhints = require("lsp-inlayhints")
	-- 					inlayhints.on_attach(client, args.buf)
	-- 					require("astronvim.utils").set_mappings({
	-- 						n = {
	-- 							["<leader>uH"] = { inlayhints.toggle, desc = "Toggle inlay hints" },
	-- 						},
	-- 					}, { buffer = args.buf })
	-- 				end
	-- 			end,
	-- 		})
	-- 	end,
	-- 	opts = {
	-- 		inlay_hints = { highlight = "Comment" },
	-- 	},
	-- },
}
