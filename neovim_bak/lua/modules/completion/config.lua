local config = {}

function config.nvim_lsp_installer()
    if not packer_plugins["cmp-nvim-lsp"].loaded then
        vim.cmd([[PackerLoad cmp-nvim-lsp]])
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
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
                    handler_opts = {
                        border = "none",
                    },
                })
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
                        globals = { "vim", "packer_plugins" },
                    },
                },
            }
        end

        -- This setup() function is exactly the same as lspconfig's setup function.
        -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        server:setup(opts)
    end)
end

function config.nvim_cmp()
    if not packer_plugins["LuaSnip"].loaded then
        vim.cmd([[PackerLoad LuaSnip]])
    end

    if not packer_plugins["neogen"].loaded then
        vim.cmd([[PackerLoad neogen]])
    end

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local neogen = require("neogen")
    -- local tab_complete_copilot_first = true

    -- local function replace_termcodes(str)
    --     return vim.api.nvim_replace_termcodes(str, true, true, true)
    -- end
    --
    -- local function check_backspace()
    --     local col = vim.fn.col(".") - 1
    --     return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    -- end
    --
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    -- local tab_complete = function(fallback)
    --     local copilot_keys = vim.fn["copilot#Accept"]()
    --     if tab_complete_copilot_first then
    --         if copilot_keys ~= "" then
    --             vim.api.nvim_feedkeys(copilot_keys, "i", true)
    --         elseif cmp.visible() then
    --             cmp.select_next_item()
    --         elseif luasnip.expand_or_jumpable() then
    --             -- luasnip.expand_or_jump()
    --             vim.fn.feedkeys(replace_termcodes("<Plug>luasnip-expand-or-jump"), "")
    --         elseif check_backspace() then
    --             vim.fn.feedkeys(replace_termcodes("<Tab>"), "n")
    --             -- elseif has_words_before() then
    --             --     cmp.complete()
    --         else
    --             fallback()
    --         end
    --     else
    --         if cmp.visible() then
    --             cmp.select_next_item()
    --         elseif copilot_keys ~= "" then
    --             vim.api.nvim_feedkeys(copilot_keys, "i", true)
    --         elseif luasnip.expand_or_jumpable() then
    --             vim.fn.feedkeys(replace_termcodes("<Plug>luasnip-expand-or-jump"), "")
    --         elseif check_backspace() then
    --             vim.fn.feedkeys(replace_termcodes("<Tab>"), "n")
    --         else
    --             fallback()
    --         end
    --     end
    -- end
    --
    -- local s_tab_complete = function(fallback)
    --     if cmp.visible() then
    --         cmp.select_prev_item()
    --     elseif luasnip.jumpable(-1) then
    --         vim.fn.feedkeys(replace_termcodes("<Plug>luasnip-jump-prev"), "")
    --     elseif has_words_before() then
    --         cmp.complete()
    --     else
    --         fallback()
    --     end
    -- end

    cmp.setup({
        -- preselect = cmp.PreselectMode.None,
        completion = { completeopt = "menu,menuone,noinsert", keyword_length = 1 },
        experimental = { native_menu = false, ghost_text = false },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
                vim.fn["UltiSnips#Anon"](args.body)
            end,
        },
        formatting = {
            fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
            format = function(entry, vim_item)
                local word = vim_item.abbr
                if string.sub(word, -1, -1) == "~" then
                    vim_item.abbr = string.sub(word, 0, -2)
                end

                local icons = require("utils.icons")
                vim_item.kind = string.format("%s %s", icons.cmp[vim_item.kind], vim_item.kind)

                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[SNIP]",
                    buffer = "[BUF]",
                    cmp_tabnine = "[TAB]",
                    ultisnips = "[US]",
                    path = "[PATH]",
                    look = "[LOOK]",
                    nvim_lsp_signature_help = "[SIGN]",
                })[entry.source.name]

                return vim_item
            end,
        },
        sources = cmp.config.sources({
            {
                name = "nvim_lsp",
            },
            {
                name = "buffer",
            },
            {
                name = "path",
            },
            {
                name = "cmp_tabnine",
            },
            {
                name = "luasnip",
            },
            {
                name = "ultisnips",
            },
            {
                name = "nvim_lsp_signature_help",
            },
            {
                name = "look",
                keyword_length = 2,
                option = {
                    convert_case = true,
                    loud = true,
                },
            },
        }),
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:TelescopeBorder",
        },
        mapping = {
            -- ["<C-n>"] = cmp.mapping.select_next_item(),
            -- ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
            -- ["<Tab>"] = tab_complete,
            -- ["<S-Tab>"] = s_tab_complete,
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
                "c",
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
                "c",
            }),

            ["<C-f>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            ["<C-c>"] = cmp.mapping.abort(),

            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
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

            ["<C-d>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(2)
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<C-u>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(-2)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
    })
end

function config.luasnip()
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = { "~/.local/share/nvim/site/pack/packer/opt/friendly-snippets" },
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
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.isort,
        },
        update_in_insert = false,
    })
end

function config.neogen()
    require("neogen").setup({})
end

return config