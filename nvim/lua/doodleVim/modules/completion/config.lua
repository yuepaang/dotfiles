local config = {}

function config.mason()
  require("mason").setup({
    ui = {
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = "rounded",

      icons = {
        -- The list icon to use for installed packages.
        package_installed = "◍",
        -- The list icon to use for packages that are installing, or queued for installation.
        package_pending = "◍",
        -- The list icon to use for packages that are not installed.
        package_uninstalled = "◍",
      },

      keymaps = {
        -- Keymap to expand a package
        toggle_package_expand = "<CR>",
        -- Keymap to install the package under the current cursor position
        install_package = "i",
        -- Keymap to reinstall/update the package under the current cursor position
        update_package = "u",
        -- Keymap to check for new version for the package under the current cursor position
        check_package_version = "c",
        -- Keymap to update all installed packages
        update_all_packages = "U",
        -- Keymap to check which installed packages are outdated
        check_outdated_packages = "C",
        -- Keymap to uninstall a package
        uninstall_package = "X",
        -- Keymap to cancel a package installation
        cancel_installation = "<C-c>",
        -- Keymap to apply language filter
        apply_language_filter = "<C-f>",
      },
    },

    -- The directory in which to install packages.
    install_root_dir = require("mason-core.path").concat({ vim.fn.stdpath("data"), "mason" }),

    pip = {
      -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
      -- and is not recommended.
      --
      -- Example: { "--proxy", "https://proxyserver" }
      install_args = {},
    },

    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,

    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
    -- packages that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,

    github = {
      -- The template URL to use when downloading assets from GitHub.
      -- The placeholders are the following (in order):
      -- 1. The repository (e.g. "rust-lang/rust-analyzer")
      -- 2. The release version (e.g. "v0.3.0")
      -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
      download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
  })
end

function config.mason_lspconfig()
  require("doodleVim.utils.defer").immediate_load("mason.nvim")
  require("mason-lspconfig").setup({
    ensure_installed = {
      "gopls",
      "pylsp",
      "rust_analyzer",
      "sumneko_lua",
      "jsonls",
      "yamlls",
      "taplo",
      "marksman",
      "bashls",
    },
    automatic_installation = true,
  })

  local handler = require("doodleVim.modules.completion.handler")
  handler.lsp_hover()
  handler.lsp_diagnostic()
  handler.null_ls_depress()

  local function contains(tab, val)
    for _, value in ipairs(tab) do
      if value == val then
        return true
      end
    end
    return false
  end

  local lsp_servers = {}
  local installed_servers = require("mason-registry").get_installed_packages()
  local package_to_lspconfig = require("mason-lspconfig.mappings.server").package_to_lspconfig

  for _, item in ipairs(installed_servers) do
    if contains(item.spec.categories, "LSP") then
      local lsp_server = package_to_lspconfig[item.name]
      table.insert(lsp_servers, lsp_server)
    end
  end

  require("doodleVim.utils.defer").immediate_load("cmp-nvim-lsp")
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local lspconfig = require("lspconfig")

  local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    require("doodleVim.modules.completion.handler").lsp_highlight_document(client)

    local cfg = {
      debug = false, -- set to true to enable debug logging
      log_path = "debug_log_file_path", -- debug log path
      verbose = false, -- show debug line number

      bind = true, -- This is mandatory, otherwise border config won't get registered.
      -- If you want to hook lspsaga or other signature handler, pls set to false
      doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
      -- set to 0 if you DO NOT want any API comments be shown
      -- This setting only take effect in insert mode, it does not affect signature help in normal
      -- mode, 10 by default

      floating_window = false, -- show hint in a floating window, set to false for virtual text only mode

      floating_window_above_cur_line = false, -- try to place the floating above the current line when possible Note:
      -- will set to true when fully tested, set to false will use whichever side has more space
      -- this setting will be helpful if you do not want the PUM and floating win overlap
      fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
      hint_enable = true, -- virtual hint enable
      hint_prefix = " " .. " ", -- Panda for parameter
      hint_scheme = "Comment",
      use_lspsaga = false, -- set to true if you want to use lspsaga popup
      hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
      max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
      -- to view the hiding contents
      max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
      handler_opts = {
        border = "rounded", -- double, rounded, single, shadow, none
      },

      always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

      auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
      extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
      zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

      padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

      transparency = nil, -- disabled by default, allow floating win transparent value 1~100
      shadow_blend = 36, -- if you using shadow as border use this set the opacity
      shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
      toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    }

    local status_ok, signature = pcall(require, "lsp_signature")
    if not status_ok then
      return
    end

    -- recommanded:
    signature.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

    -- You can also do this inside lsp on_attach
    -- note: on_attach deprecated
    -- require("lsp_signature").on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
    signature.on_attach(cfg) -- no need to specify bufnr if you don't use toggle_key
  end

  lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
    capabilities = capabilities,
  })

  local opts = {}

  for _, lsp in ipairs(lsp_servers) do
    opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }

    if lsp == "sumneko_lua" then
      local l_status_ok, lua_dev = pcall(require, "lua-dev")
      if not l_status_ok then
        return
      end
      local luadev = lua_dev.setup({
        lspconfig = {
          on_attach = on_attach,
          capabilities = capabilities,
        },
      })
      lspconfig.sumneko_lua.setup(luadev)
      goto continue
      -- old configuration
      -- local settings = require("doodleVim.modules.completion.servers.sumneko")
      -- lspconfig[lsp].setup({
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   settings = settings,
      -- })
    end

    if lsp == "yamlls" then
      local yamlls_opts = require("doodleVim.modules.completion.servers.yamlls")
      opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    end

    if lsp == "jsonls" then
      local jsonls_opts = require("doodleVim.modules.completion.servers.jsonls")
      opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    end

    if lsp == "rust_analyzer" then
      local rust_opts = require("doodleVim.modules.completion.servers.rust").get_rust_opts(capabilities, on_attach)
      local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
      if not rust_tools_status_ok then
        return
      end
      rust_tools.setup(rust_opts)
      goto continue
    end

    lspconfig[lsp].setup(opts)
    ::continue::
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
      { name = "crates", group_index = 1 },
      { name = "nvim_lsp", group_index = 2 },
      { name = "nvim_lua", group_index = 2 },
      { name = "luasnip", group_index = 2 },
      { name = "buffer", group_index = 2 },
      { name = "cmp_tabnine", group_index = 2 },
      { name = "path", group_index = 2 },
    }),
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    mapping = cmp.mapping.preset.insert({
      ["<CR>"] = {
        i = cmp.mapping.confirm({ select = false }),
      },
      ["<C-c>"] = {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end),
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        elseif require("neogen").jumpable(true) then
          require("neogen").jump_prev()
        else
          require("doodleVim.utils.utils").feedkeys("<Up>", "i")
        end
      end, { "i", "s" }),
      ["<C-j>"] = cmp.mapping(function(fallback)
        if require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        elseif require("neogen").jumpable() then
          require("neogen").jump_next()
        else
          require("doodleVim.utils.utils").feedkeys("<Down>", "i")
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
          nvim_lua = "[LUA]",
          crates = "[CRATES]",
          buffer = "[BUF]",
          cmp_tabnine = "[TAB]",
          luasnip = "[SNIP]",
          path = "[PATH]",
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

function config.gotools()
  require("doodleVim.utils.defer").immediate_load("mason.nvim")
  require("gotools").setup({
    ui = {
      border = {
        style = "rounded",
      },
      win_options = {
        winhighlight = "Normal:GruvboxBlue,FloatBorder:FloatBorder",
      },
    },
    tools = {
      gotests = {
        bin = require("mason-core.path").bin_prefix() .. "/" .. "gotests",
      },
      gomodifytags = {
        bin = require("mason-core.path").bin_prefix() .. "/" .. "gomodifytags",
      },
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
      -- null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
      -- null_ls.builtins.formatting.isort,
      -- null_ls.builtins.formatting.gofmt,
      -- null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.shfmt.with({ filetypes = { "sh", "bash", "zsh" } }),

      null_ls.builtins.diagnostics.shellcheck,

      null_ls.builtins.code_actions.gitsigns,
      require("gotools").code_actions.gotests,
      require("gotools").code_actions.gomodifytags,
    },
    update_in_insert = false,
  })
  local unwrap = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "rust" },
    generator = {
      fn = function(params)
        local diagnostics = {}
        -- sources have access to a params object
        -- containing info about the current file and editor state
        for i, line in ipairs(params.content) do
          local col, end_col = line:find("unwrap()")
          if col and end_col then
            -- null-ls fills in undefined positions
            -- and converts source diagnostics into the required format
            table.insert(diagnostics, {
              row = i,
              col = col,
              end_col = end_col,
              source = "unwrap",
              message = "hey " .. os.getenv("USER") .. ", don't forget to handle this",
              severity = 2,
            })
          end
        end
        return diagnostics
      end,
    },
  }

  null_ls.register(unwrap)
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
      text = icons.diagnostics.hint_sign,
    },
    float = {
      enabled = false,
      -- Text to show in the popup float
      text = icons.diagnostics.hint_sign,
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
      text = icons.diagnostics.hint_sign,
      -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
      hl_mode = "replace",
    },
    status_text = {
      enabled = false,
      -- Text to provide when code actions are available
      text = icons.diagnostics.hint_sign,
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
