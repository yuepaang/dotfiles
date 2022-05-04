local config = {}

function config.nvim_lsp_installer()
    local servers = {"gopls", "pyright", "sumneko_lua"}
    require("nvim-lsp-installer").setup({
        automatic_installation = true
    })

    require("utils.defer").load_immediately("cmp-nvim-lsp")
    local icons = require("utils.icons")
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded"
    })
    vim.diagnostic.config({
        underline = true,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = "rounded",
            focusable = false,
            header = {icons.diag.debug_sign .. " Diagnostics:"},
            source = "always"
        },
        virtual_text = {
            spacing = 4,
            source = "always",
            severity = {
                min = vim.diagnostic.severity.HINT
            }
        }
    })

    local diag_icon = icons.diag
    require("extend.diagnostics").setup({
        error_sign = diag_icon.error_sign,
        warn_sign = diag_icon.warn_sign,
        hint_sign = diag_icon.hint_sign,
        infor_sign = diag_icon.infor_sign,
        debug_sign = diag_icon.debug_sign,
        use_diagnostic_virtual_text = false
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

    local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        require("lsp_signature").on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            hint_enable = false,
            floating_window_above_cur_line = true,
            handler_opts = {
                border = "rounded"
            }
        }, bufnr)
    end

    local lspconfig = require("lspconfig")
    for _, lsp in ipairs(servers) do
        local server_available, server = require("nvim-lsp-installer.servers").get_server(lsp)
        if not server_available then
            server:install()
        end
        local default_opts = server:get_default_options()
        if server.name == "sumneko_lua" then
            default_opts.settings = {
                Lua = {
                    diagnostics = {
                        globals = {"vim", "PLUGINS"}
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true
                        }
                    }
                }
            }
        end

        if server.name == "pyright" then
            default_opts.settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "off"
                    }
                }
            }
        end

        lspconfig[lsp].setup({
            cmd_env = default_opts.cmd_env,
            on_attach = on_attach,
            capabilities = capabilities
        })
    end
end

function config.nvim_cmp()
    require("utils.defer").load_immediately({"LuaSnip", "neogen"})

    local cmp = require("cmp")
    local types = require("cmp.types")
    -- local luasnip = require("luasnip")
    local neogen = require("neogen")

    cmp.setup({
        enabled = function()
            local disabled = false
            disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
            disabled = disabled or (vim.fn.reg_recording() ~= "")
            disabled = disabled or (vim.fn.reg_executing() ~= "")
            return not disabled
        end,
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end
        },
        window = {
            completion = cmp.config.window.bordered({
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None"
            }),
            documentation = cmp.config.window.bordered({
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None"
            })
        },
        sources = cmp.config.sources({{
            name = "luasnip",
            priority = 100
        }, {
            name = "nvim_lsp",
            priority = 99
        }, {
            name = "cmp_tabnine"
        }, {
            name = "copilot"
        }, {
            name = "buffer"
        }, {
            name = "path"
        }, {
            name = "look",
            keyword_length = 2,
            option = {
                convert_case = true,
                loud = true
            }
        }}),
        mapping = cmp.mapping.preset.insert({
            ["<Down>"] = {
                i = cmp.mapping.select_next_item({
                    behavior = types.cmp.SelectBehavior.Select
                })
            },
            ["<Up>"] = {
                i = cmp.mapping.select_prev_item({
                    behavior = types.cmp.SelectBehavior.Select
                })
            },
            ["<C-n>"] = {
                i = cmp.mapping.select_next_item({
                    behavior = types.cmp.SelectBehavior.Insert
                })
            },
            ["<C-p>"] = {
                i = cmp.mapping.select_prev_item({
                    behavior = types.cmp.SelectBehavior.Insert
                })
            },
            ["<CR>"] = {
                i = cmp.mapping.confirm({
                    select = true
                })
            },
            ["<C-e>"] = {
                i = cmp.mapping.abort()
            },
            ["<C-k>"] = cmp.mapping(function(fallback)
                if require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                elseif require("neogen").jumpable(true) then
                    require("neogen").jump_prev()
                else
                    fallback()
                end
            end, {"i", "s"}),
            ["<C-j>"] = cmp.mapping(function(fallback)
                if require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                elseif require("neogen").jumpable() then
                    require("neogen").jump_next()
                else
                    fallback()
                end
            end, {"i", "s"}),
            ["<C-d>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(2)
                else
                    fallback()
                end
            end, {"i", "s"}),
            ["<C-u>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(-2)
                else
                    fallback()
                end
            end, {"i", "s"})
        }),
        view = {
            entries = {
                name = "custom",
                selection_order = "top_down"
            }
        },
        formatting = {
            fields = {cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu},
            format = function(entry, vim_item)
                local word = vim_item.abbr
                if string.sub(word, -1, -1) == "~" then
                    vim_item.abbr = string.sub(word, 0, -2)
                end

                local icons = require("utils.icons")
                vim_item.kind = string.format("%s %s", icons.cmp[vim_item.kind], vim_item.kind)

                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    buffer = "[BUF]",
                    cmp_tabnine = "[TAB]",
                    luasnip = "[SNP]",
                    path = "[PATH]",
                    look = "[LOOK]",
                    copilot = "[AI]"
                })[entry.source.name]

                return vim_item
            end
        }
    })

    cmp.setup.filetype("TelescopePrompt", {
        sources = cmp.config.sources({{
            name = "path"
        }})
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {{
            name = "buffer"
        }}
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
            ['<Down>'] = {
                c = cmp.mapping.select_next_item({
                    behavior = types.cmp.SelectBehavior.Insert
                })
            }
        }),
        sources = cmp.config.sources({{
            name = "path"
        }}, {{
            name = "cmdline"
        }}, {{
            name = 'path'
        }})
    })
end

function config.luasnip()
    -- local snippets_folder = vim.fn.stdpath("config") .. "/lua/snippets/"
    -- local ls = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {"./snippets/python"}
    })
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {"./snippets/rust"}
    })
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {"./snippets/typescript"}
    })

    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {"~/.local/share/nvim/site/pack/packer/opt/friendly-snippets"}
    })
end

function config.null_ls()
    local null_ls = require("null-ls")

    null_ls.setup({
        cmd = {"nvim"},
        debounce = 250,
        debug = false,
        default_timeout = 5000,
        diagnostics_format = "#{m}",
        fallback_severity = vim.diagnostic.severity.ERROR,
        log = {
            enable = true,
            level = "warn",
            use_console = "async"
        },
        on_attach = nil,
        on_init = nil,
        on_exit = nil,
        sources = {null_ls.builtins.formatting.prettier, null_ls.builtins.formatting.black.with({
            extra_args = {"--fast"}
        }), null_ls.builtins.formatting.isort, null_ls.builtins.formatting.shfmt, null_ls.builtins.formatting.fixjson,
                   null_ls.builtins.formatting.stylua, -- diagnostics
        null_ls.builtins.diagnostics.write_good, null_ls.builtins.diagnostics.tsc,
        -- null_ls.builtins.diagnostics.selene,
                   null_ls.builtins.hover.dictionary},
        update_in_insert = false
    })
end

function config.neogen()
    require("neogen").setup({
        snippet_engine = "luasnip"
    })
end

function config.rename()
    require('rename').setup({
        rename = {
            border = {
                highlight = 'FloatBorder',
                style = 'rounded',
                title = ' Rename ',
                title_align = 'left',
                title_hl = 'FloatBorder'
            },
            prompt = '➤ ',
            prompt_hl = 'Comment'
        }
    })
end

function config.copilot()
    vim.defer_fn(function()
        require("copilot").setup()
    end, 200)
end

return config
