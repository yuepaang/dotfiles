local config = {}

function config.nvim_lsp_installer()
	require("utils.defer").load_immediately("cmp-nvim-lsp")

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	local lsp_installer = require("nvim-lsp-installer")
	lsp_installer.on_server_ready(function(server)
		local opts = {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
				require("lsp_signature").on_attach({
					bind = true, -- This is mandatory, otherwise border config won't get registered.
					hint_enable = false,
					floating_window_above_cur_line = true,
					handler_opts = { border = "rounded" },
				}, bufnr)
			end,
		}
		-- (optional) Customize the options passed to the server
		-- if server.name == "tsserver" then
		--     opts.root_dir = function() ... end
		-- end
		if server.name == "sumneko_lua" then
			opts.settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "PLUGINS" },
					},
				},
			}
		end

		-- This setup() function is exactly the same as lspconfig's setup function.
		-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
		server:setup(opts)
	end)

	local icons = require("utils.icons")

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	vim.diagnostic.config({
		underline = true,
		signs = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = "rounded",
			focusable = false,
			header = { icons.diag.debug_sign .. " Diagnostics:" },
			source = "always",
		},
		virtual_text = {
			spacing = 4,
			source = "always",
			severity = {
				min = vim.diagnostic.severity.HINT,
			},
		},
	})

	local diag_icon = icons.diag
	require("extend.diagnostics").setup({
		error_sign = diag_icon.error_sign,
		warn_sign = diag_icon.warn_sign,
		hint_sign = diag_icon.hint_sign,
		infor_sign = diag_icon.infor_sign,
		debug_sign = diag_icon.debug_sign,
		use_diagnostic_virtual_text = false,
	})
end

function config.nvim_cmp()
	vim.g.copilot_no_tab_map = true
	vim.g.copilot_assume_mapped = true
	vim.g.copilot_tab_fallback = ""
	require("utils.defer").load_immediately({ "LuaSnip", "neogen" })

	local cmp = require("cmp")
	local types = require("cmp.types")
	local luasnip = require("luasnip")
	-- local neogen = require("neogen")
	local check_backspace = function()
		local col = vim.fn.col "." - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},

		mapping = cmp.mapping.preset.insert {
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			-- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			-- ["<C-e>"] = cmp.mapping {
			--   i = cmp.mapping.abort(),
			--   c = cmp.mapping.close(),
			-- },
			["<C-e>"] = cmp.mapping({
				i = function(fallback)
					local copilot_keys = vim.fn["copilot#Accept"]()
					if copilot_keys ~= "" then
						vim.api.nvim_feedkeys(copilot_keys, "i", true)
					else
						cmp.mapping.abort()(fallback)
					end
				end,
				c = cmp.mapping.close(),
			}),
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm { select = true },
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, {
				"i",
				"s",
			}),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "cmp_tabnine" },
			{ name = "path" },
			{ name = "emoji" },
			{
				name = "look",
				keyword_length = 2,
				option = {
					convert_case = true,
					loud = true,
					-- dict = '/usr/share/dict/words'
				},
			},
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		-- documentation = true,
		window = {
			-- documentation = "native",
			documentation = {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			},
		},
		-- documentation = {
		-- 	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		-- },
		experimental = {
			ghost_text = true,
			-- native_menu = false,
		},

		formatting = {
			fields = {
				cmp.ItemField.Abbr,
				cmp.ItemField.Kind,
				cmp.ItemField.Menu,
			},
			format = function(entry, vim_item)
				local word = vim_item.abbr
				if string.sub(word, -1, -1) == "~" then
					vim_item.abbr = string.sub(word, 0, -2)
				end

				local icons = require("utils.icons")
				vim_item.kind = string.format("%s %s", icons.cmp[vim_item.kind], vim_item.kind)
				if entry.source.name == "cmp_tabnine" then
					-- if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
					-- menu = entry.completion_item.data.detail .. " " .. menu
					-- end
					vim_item.kind = icons.cmp.Robot
				end

				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					buffer = "[BUF]",
					cmp_tabnine = "[TAB]",
					luasnip = "[SNP]",
					path = "[PATH]",
					look = "[LOOK]",
				})[entry.source.name]

				return vim_item
			end,
		},
	})
	cmp.setup.filetype("TelescopePrompt", {
		sources = cmp.config.sources({ { name = "path" } }),
	})

	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

function config.luasnip()
	-- local snippets_folder = vim.fn.stdpath("config") .. "/lua/snippets/"
	-- local ls = require("luasnip")

	require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/python" } })
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/rust" } })
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/typescript" } })

	require("luasnip.loaders.from_vscode").lazy_load({
		paths = {
			"~/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
		},
	})
end

function config.null_ls()
	local null_ls = require("null-ls")

	null_ls.setup({
		cmd = { "nvim" },
		debounce = 250,
		debug = false,
		default_timeout = 5000,
		diagnostics_format = "#{m}",
		fallback_severity = vim.diagnostic.severity.ERROR,
		log = {
			enable = true,
			level = "warn",
			use_console = "async",
		},
		on_attach = nil,
		on_init = nil,
		on_exit = nil,
		sources = {
			null_ls.builtins.formatting.prettier,
			null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
			null_ls.builtins.formatting.isort,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.fixjson,
			null_ls.builtins.formatting.stylua,
			-- diagnostics
			null_ls.builtins.diagnostics.write_good,
			null_ls.builtins.diagnostics.tsc,
			-- null_ls.builtins.diagnostics.selene,
			null_ls.builtins.hover.dictionary,
		},
		update_in_insert = false,
	})
end

function config.neogen()
	require("neogen").setup({ snippet_engine = "luasnip" })
end

function config.cosmicui()
	require("cosmic-ui").setup({
		-- default border to use
		-- 'single', 'double', 'rounded', 'solid', 'shadow'
		border_style = "rounded",

		-- rename popup settings
		rename = {
			border = {
				highlight = "FloatBorder",
				style = "single",
				title = " Rename ",
				title_align = "left",
				title_hl = "FloatBorder",
			},
			prompt = "➤ ",
			prompt_hl = "Comment",
		},

		code_actions = {
			min_width = nil,
			border = {
				bottom_hl = "FloatBorder",
				highlight = "FloatBorder",
				style = "single",
				title = "Code Actions",
				title_align = "center",
				title_hl = "FloatBorder",
			},
		},
	})
end

return config
