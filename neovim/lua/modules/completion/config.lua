local config = {}

function config.nvim_lsp_installer()

    if not packer_plugins['cmp-nvim-lsp'].loaded then
        vim.cmd [[PackerLoad cmp-nvim-lsp]]
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local on_attach = function(client, bufnr)
        -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        -- Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        require"lsp_signature".on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = false,
            floating_window_above_cur_line = true,
            handler_opts = {
                border = "none"
            }
        })

        -- local opts = { noremap=true, silent=true }
        -- buf_set_keymap('n', '==', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        -- buf_set_keymap('v', '=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        require("illuminate").on_attach(client)

    end

    local lsp_installer = require("nvim-lsp-installer")

    local default_opt = {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150
        }
    }

    local lspconfig = require('lspconfig')
    local format_config = require 'modules.completion.format'

    local servers = {
        tsserver = {
            root_dir = lspconfig.util.root_pattern("tsconfig.json", "package.json", ".git")
        },
        pyright = {
            filetypes = {"python"},
            init_options = {
                formatters = {
                    black = {
                        command = "black",
                        args = {"--quiet", "-"},
                        rootPatterns = {"pyproject.toml"}
                    },
                    formatFiletypes = {
                        python = {"black"}
                    }
                }
            }
        },
        efm = {
            filetypes = vim.tbl_keys(format_config),
            init_options = {
                documentFormatting = true
            },
            root_dir = lspconfig.util.root_pattern {'.git/', '.'},
            settings = {
                languages = format_config
            }
        }
    }

    servers.sumneko_lua = require('lua-dev').setup(default_opt)

    lsp_installer.on_server_ready(function(server)
        local opt = servers[server.name] or {}
        opt = vim.tbl_deep_extend('force', {}, default_opt, opt)

        -- (optional) Customize the options passed to the server
        -- if server.name == "tsserver" then
        --     opts.root_dir = function() ... end
        -- end
        if server.name == "sumneko_lua" then
            opt.settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim'}
                    }
                }
            }
        end

        -- This setup() function is exactly the same as lspconfig's setup function.
        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        server:setup(opt)
    end)
end

function config.nvim_cmp()
    if not packer_plugins['LuaSnip'].loaded then
        vim.cmd [[PackerLoad LuaSnip]]
    end

    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local g = vim.g
    g.copilot_no_tab_map = true
    g.copilot_assume_mapped = true
    g.copilot_tab_fallback = ""
    local tab_complete_copilot_first = true

    local function replace_termcodes(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    local function check_backspace()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local tab_complete = function(fallback)
        local copilot_keys = vim.fn["copilot#Accept"]()
        if tab_complete_copilot_first then
            if copilot_keys ~= "" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(replace_termcodes("<Plug>luasnip-expand-or-jump"), "")
            elseif check_backspace() then
                vim.fn.feedkeys(replace_termcodes("<Tab>"), "n")
            else
                fallback()
            end
        else
            if cmp.visible() then
                cmp.select_next_item()
            elseif copilot_keys ~= "" then
                vim.api.nvim_feedkeys(copilot_keys, "i", true)
            elseif luasnip.expand_or_jumpable() then
                vim.fn.feedkeys(replace_termcodes("<Plug>luasnip-expand-or-jump"), "")
            elseif check_backspace() then
                vim.fn.feedkeys(replace_termcodes("<Tab>"), "n")
            else
                fallback()
            end
        end
    end

    cmp.setup({
        preselect = cmp.PreselectMode.None,
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
                vim.fn["UltiSnips#Anon"](args.body)
            end
        },
        sources = cmp.config.sources({{
            name = 'nvim_lsp'
        }, {
            name = 'buffer'
        }, {
            name = 'path'
        }, {
            name = 'cmp_tabnine'
        }, {
            name = 'luasnip'
        }, {
            name = 'ultisnips'
        }, {
            name = "look",
            keyword_length = 2,
            option = {
                convert_case = true,
                loud = true
            }
        }}),
        mapping = {
            ['<TAB>'] = tab_complete,
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ['<C-f>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close()
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
            end, {"i", "s"})
        },
        formatting = {
            fields = {cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu},
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
                    look = "[LOOK]"
                })[entry.source.name]

                return vim_item
            end
        }
    })
end

function config.luasnip()
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {"~/.local/share/nvim/site/pack/packer/opt/friendly-snippets"}
    })
end

function config.illuminate()
    require('illuminate').setup {
        enable = true
    }
end

return config
