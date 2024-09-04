local config = {}

function config.nvim_cmp(plugin, opts)
    require("codicons.extensions.completion_item_kind").set({
        include_icon = true,
        include_label = true,
        monospaced = true,
        override = {},
    })

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local under_comparator = require("cmp-under-comparator").under
    local WIDE_HEIGHT = 40

    local check_back_space = function()
        local col = vim.fn.col(".") - 1
        if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
            return true
        else
            return false
        end
    end

    cmp.setup({
        enabled = function()
            local disabled = false
            disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
            -- disabled = disabled or (vim.api.nvim_buf_get_option(0, 'filetype') == 'TelescopePrompt')
            disabled = disabled or (vim.fn.reg_recording() ~= "")
            disabled = disabled or (vim.fn.reg_executing() ~= "")
            return not disabled
        end,
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered({
                border = "rounded",
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            }),
            documentation = {
                max_height = math.floor(WIDE_HEIGHT * (WIDE_HEIGHT / vim.o.lines)),
                max_width = math.floor((WIDE_HEIGHT * 2) * (vim.o.columns / (WIDE_HEIGHT * 2 * 16 / 9))),
                border = "rounded",
                winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
            },
        },
        sorting = {
            priority_weight = 2,
            comparators = {
                cmp.config.compare.offset,
                cmp.config.compare.exact,
                cmp.config.compare.score,
                under_comparator,
                -- require("cmp-under-comparator").under,
                cmp.config.compare.recently_used,
                cmp.config.compare.locality,
                cmp.config.compare.kind,
                cmp.config.compare.sort_text,
                cmp.config.compare.length,
                cmp.config.compare.order,
            },
        },
        preselect = cmp.PreselectMode.None,
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "treesitter" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "async_path" },
            {
                name = "look",
                keyword_length = 2,
                option = { convert_case = true, loud = true },
            },
            { name = "buffer" },
            { name = "async_path" },
            { name = "orgmode" },
        }, {}),
        mapping = {
            -- ["<CR>"] = {
            --     i = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
            -- },
            ["<CR>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({ select = true }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
            }),
            ["<C-x>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.abort()
                else
                    fallback()
                end
            end),
            ["<C-p>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    cmp.complete()
                end
            end, { "i", "s" }),
            ["<C-n>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    cmp.complete()
                end
            end, { "i", "s" }),
            -- when menu is visible, navigate to next item
            -- when line is empty, insert a tab character
            -- else, activate completion
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif check_back_space() then
                    fallback()
                else
                    cmp.complete()
                end
            end, { "i", "s" }),
            -- when menu is visible, navigate to previous item on list
            -- else, revert to default behavior
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-k>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-j>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-d>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({
                        behavior = cmp.SelectBehavior.Select,
                        count = 5,
                    })
                else
                    cmp.complete()
                end
            end, { "i", "s" }),
            ["<C-u>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({
                        behavior = cmp.SelectBehavior.Select,
                        count = 5,
                    })
                else
                    cmp.complete()
                end
            end, { "i", "s" }),
            ["<M-n>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(2)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<M-p>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.scroll_docs(-2)
                else
                    fallback()
                end
            end, { "i", "s" }),
        },
        view = {
            entries = { name = "custom", selection_order = "top_down" },
        },
        experimental = {
            ghost_text = {
                hl_group = "CmpGhostText",
            },
        },
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = {},
            before = function(entry, vim_item)
                local word = vim_item.abbr
                if string.sub(word, -1, -1) == "~" then
                    word = string.sub(word, 0, -2)
                end
                vim_item.abbr = word
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    buffer = "[BUF]",
                    luasnip = "[SNP]",
                    path = "[PATH]",
                    look = "[LOOK]",
                    treesitter = "[TS]",
                })[entry.source.name]
                return vim_item
            end,
        }),
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline({
            ["<Up>"] = {
                c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            },
            ["<Down>"] = {
                c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            },
        }),
        sources = cmp.config.sources({
            { name = "cmdline" },
        }, {
            { name = "path" },
        }),
    })

    require("nvim-autopairs").setup({
        -- no configuration
        map_char = {
            all = "(",
            tex = "{",
        },
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        disable_in_macro = false,
        enable_afterquote = true,
        map_bs = true,
        map_c_w = false,
        disable_in_visualblock = false,
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",
            highlight_grey = "Comment",
        },
    })
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

function config.luasnip()
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
            "~/dotfiles/nvim/snippets/rust",
        },
    })
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
            "~/dotfiles/nvim/snippets/python",
        },
    })
    require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
            "~/dotfiles/nvim/snippets/go",
        },
    })
end

function config.neogen()
    require("neogen").setup({ enabled = true, snippet_engine = "luasnip" })
end

return config
