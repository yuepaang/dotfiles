local config = {}

-- local has_words_before = function()
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

function config.nvim_lsp_installer()

	if not packer_plugins['cmp-nvim-lsp'].loaded then
	  vim.cmd [[PackerLoad cmp-nvim-lsp]]
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local servers = {
      pyright = {
        filetypes = {"python"},
        init_options = {
          formatters = {
            black = {
              command = "black",
              args = {"--quiet", "-"},
              rootPatterns = {"pyproject.toml"},
            },
            formatFiletypes = {
              python = {"black"}
            }
          }
        },
      },
    }

	local lsp_installer = require("nvim-lsp-installer")

	lsp_installer.on_server_ready(function(server)
	    local opt = servers[server.name] or {}
		local opts = {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				require "lsp_signature".on_attach({
					bind = true, -- This is mandatory, otherwise border config won't get registered.
					hint_enable = false,
					floating_window_above_cur_line = true,
					handler_opts = {border = "none"}
				})
			end,
		}

		opts = vim.tbl_deep_extend('force', {}, opts, opt)
	  -- (optional) Customize the options passed to the server
	  -- if server.name == "tsserver" then
	  --     opts.root_dir = function() ... end
	  -- end

	  -- This setup() function is exactly the same as lspconfig's setup function.
	  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	  server:setup(opts)
	end)
end

function config.nvim_cmp()
	if not packer_plugins['LuaSnip'].loaded then
	  vim.cmd [[PackerLoad LuaSnip]]
	end

	local cmp = require('cmp')
	local luasnip = require('luasnip')
	cmp.setup({
		snippet = {
			expand = function(args)
				require('luasnip').lsp_expand(args.body)
				vim.fn["UltiSnips#Anon"](args.body)
			end,
		},
		sources =  cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'buffer' },
			{ name = 'path' },
			{ name = 'cmp_tabnine' },
			{ name = 'luasnip' },
			{ name = 'ultisnips' },
			{
				name = "look",
				keyword_length = 2,
				option = {
					convert_case = true,
					loud = true
				}
			}
		}),
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			['<C-f>'] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			['<C-c>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true
			}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

			['<C-d>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.scroll_docs(2)
				else
					fallback()
				end
			end, {"i", "s"}),

			['<C-u>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.scroll_docs(-2)
				else
					fallback()
				end
			end, {"i", "s"}),

			["<C-k>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
                else
                    fallback()
                end
            end, {"i", "s"}),
            ["<C-j>"] = cmp.mapping(function(fallback)
                if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, {"i", "s"}),
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

				local icons = require "utils.icons"
				vim_item.kind = string.format("%s %s", icons.cmp[vim_item.kind], vim_item.kind)

				vim_item.menu = ({
					nvim_lsp = "[LSP]",
					buffer = "[BUF]",
					cmp_tabnine = "[TAB]",
					luasnip = "[SNP]",
					ultisnips = "[US]",
					path = "[PATH]",
					look = "[LOOK]",
				})[entry.source.name]

				return vim_item
			end,
		}
	})
end

function config.luasnip()
	require("luasnip.loaders.from_vscode").lazy_load({
		paths = {
			"~/.local/share/nvim/site/pack/packer/opt/friendly-snippets"
		}
	})
end

return config
