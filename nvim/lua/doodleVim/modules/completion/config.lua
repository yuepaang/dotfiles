local config = {}

function config.nvim_lsp_installer()
  local servers = { "gopls", "pyright", "sumneko_lua", "rust_analyzer", "bashls", "yamlls" }
  require("nvim-lsp-installer").setup({
    automatic_installation = false,
    ui = {
      border = "rounded",
    },
  })
  local handler = require("doodleVim.modules.completion.handler")
  handler.lsp_hover()
  handler.lsp_diagnostic()
  handler.null_ls_depress()

  require("doodleVim.utils.defer").immediate_load("cmp-nvim-lsp")

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local lspconfig = require("lspconfig")

  local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    require("doodleVim.modules.completion.handler").lsp_highlight_document(client)
    require("lsp_signature").on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      hint_enable = false,
      floating_window_above_cur_line = true,
      handler_opts = { border = "rounded" },
    }, bufnr)
  end

  lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
    capabilities = capabilities,
  })
  for _, lsp in ipairs(servers) do
    local server_available, server = require("nvim-lsp-installer.servers").get_server(lsp)
    if not server_available then
      server:install()
    end
    local default_opts = server:get_default_options()

    local settings = {}
    if lsp == "sumneko_lua" then
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = {
              "vim",
              "use",
              "describe",
              "it",
              "assert",
              "before_each",
              "after_each",
              "packer_plugins",
            },
          },
          disable = {
            "lowercase-global",
            "undefined-global",
            "unused-local",
            "unused-function",
            "unused-vararg",
            "trailing-space",
          },
        },
      }
    elseif lsp == "pyright" then
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "off",
          },
        },
      }
    elseif lsp == "rust_analyzer" then
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          checkOnSave = {
            command = "clippy",
            extraArgs = { "--no-deps" },
          },
        },
      }
    end

    lspconfig[lsp].setup({
      cmd_env = default_opts.cmd_env,
      on_attach = on_attach,
      capabilities = capabilities,
      settings = settings,
    })
  end
end

function config.nlsp_settings()
  local vim_path = require("doodleVim.core.global").vim_path
  require("nlspsettings").setup({
    config_home = vim_path .. "/nlsp-settings",
    local_settings_dir = ".nlsp-settings",
    local_settings_root_markers = { ".git" },
    append_default_schemas = true,
    loader = "json",
  })
end

function config.nvim_cmp()
  require("doodleVim.utils.defer").immediate_load({ "LuaSnip", "neogen" })

  local cmp = require("cmp")
  local types = require("cmp.types")
  -- local luasnip = require("luasnip")
  -- local neogen = require('neogen')

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
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }),
      documentation = cmp.config.window.bordered({
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }),
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "cmp_tabnine" },
      { name = "path" },
    }, {
      {
        name = "look",
        keyword_length = 2,
        option = { convert_case = true, loud = true },
      },
    }),
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = {
        i = cmp.mapping.confirm({ select = true }),
      },
      ["<C-e>"] = {
        i = cmp.mapping.abort(),
      },
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          require("doodleVim.utils.utils").feedkeys("<Up>", "i")
        end
      end),
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          require("doodleVim.utils.utils").feedkeys("<Down>", "i")
        end
      end),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        elseif require("neogen").jumpable(true) then
          require("neogen").jump_prev()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-j>"] = cmp.mapping(function(fallback)
        if require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        elseif require("neogen").jumpable() then
          require("neogen").jump_next()
        else
          fallback()
        end
      end, { "i", "s" }),
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
    }),
    view = {
      entries = { name = "custom", selection_order = "top_down" },
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

        local icons = require("doodleVim.utils.icons")
        vim_item.kind = string.format("%s %s", icons.cmp[vim_item.kind], vim_item.kind)

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
        c = cmp.mapping.select_prev_item({ behavior = types.cmp.SelectBehavior.Insert }),
      },
      ["<Down>"] = {
        c = cmp.mapping.select_next_item({ behavior = types.cmp.SelectBehavior.Insert }),
      },
    }),
    sources = cmp.config.sources({
      { name = "cmdline" },
    }, {
      { name = "path" },
    }),
  })
end

function config.luasnip()
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "./snippets/python" },
  })
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "./snippets/rust" },
  })
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { "./snippets/typescript" },
  })
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
      -- null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.prettier.with({
        extra_filetypes = { "toml", "solidity" },
        extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
      }),
      null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
      null_ls.builtins.formatting.isort,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "bash", "zsh" } }),

      null_ls.builtins.code_actions.gitsigns,
    },
    update_in_insert = false,
  })
end

function config.neogen()
  require("neogen").setup({ snippet_engine = "luasnip" })
end

function config.rename()
  require("rename").setup({
    rename = {
      border = {
        highlight = "FloatBorder",
        style = "rounded",
        title = " Rename ",
        title_align = "left",
        title_hl = "FloatBorder",
      },
      prompt = "➤ ",
      prompt_hl = "Comment",
    },
  })
end

function config.lightbulb()
  local icons = require("doodleVim.utils.icons")
  require("lightbulb").setup({
    -- LSP client names to ignore
    -- Example: {"sumneko_lua", "null-ls"}
    ignore = { "null-ls" },
    sign = {
      enabled = true,
      -- Priority of the gutter sign
      priority = 20,
      text = icons.diag.hint_sign,
    },
    float = {
      enabled = false,
      -- Text to show in the popup float
      text = icons.diag.hint_sign,
      -- Available keys for window options:
      -- - height     of floating window
      -- - width      of floating window
      -- - wrap_at    character to wrap at for computing height
      -- - max_width  maximal width of floating window
      -- - max_height maximal height of floating window
      -- - pad_left   number of columns to pad contents at left
      -- - pad_right  number of columns to pad contents at right
      -- - pad_top    number of lines to pad contents at top
      -- - pad_bottom number of lines to pad contents at bottom
      -- - offset_x   x-axis offset of the floating window
      -- - offset_y   y-axis offset of the floating window
      -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
      -- - winblend   transparency of the window (0-100)
      win_opts = {},
    },
    virtual_text = {
      enabled = false,
      -- Text to show at virtual text
      text = icons.diag.hint_sign,
      -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
      hl_mode = "replace",
    },
    status_text = {
      enabled = false,
      -- Text to provide when code actions are available
      text = icons.diag.hint_sign,
      -- Text to provide when no actions are available
      text_unavailable = "",
    },
  })

  vim.api.nvim_create_augroup("lightbulb", { clear = true })

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = "lightbulb",
    pattern = "*",
    command = "lua require'lightbulb'.check()",
  })
end

return config
