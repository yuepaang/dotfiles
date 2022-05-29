local M = {}

local servers = {
  gopls = {},
  html = {},
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  },
  pyright = {
    filetypes = { "python" },
    init_options = {
      formatters = {
        black = {
          command = "black",
          args = { "--quiet", "-" },
          rootPatterns = { "pyproject.toml" },
        },
        formatFiletypes = {
          python = { "black" },
        },
      },
    },
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
        },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        procMacro = {
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
      },
    },
  },
  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim", "PLUGINS", "dump", "packer_plugins" },
          disable = { "lowercase-global" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          },
          maxPreload = 2000,
          preloadFileSize = 50000,
        },
        completion = { callSnippet = "Both", enable = true, showWord = "Disable" },
        telemetry = { enable = false },
      },
    },
  },
  tsserver = { disable_formatting = true },
  vimls = {},
  -- tailwindcss = {},
  -- solang = {},
  yamlls = {},
  taplo = {},
  jdtls = {},
  dockerls = {},
}

-- local lsp_signature = require "lsp_signature"
-- lsp_signature.setup {
--   bind = true,
--   handler_opts = {
--     border = "rounded",
--   },
-- }

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <C-X><C-O>
  -- See `:help omnifunc` and `:help ins-completion` for more information.
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Use LSP as the handler for formatexpr.
  -- See `:help formatexpr` for more information.
  vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")

  -- Configure key mappings
  require("config.lsp.keymaps").setup(client, bufnr)

  -- Configure highlighting
  require("config.lsp.highlighter").setup(client)

  -- Configure formatting
  require("config.lsp.null-ls.formatters").setup(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if PLUGINS.nvim_cmp.enabled then
  M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp
else
  M.capabilities = capabilities
end

local opts = {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 150,
  },
}

-- Setup LSP handlers
require("config.lsp.handlers").setup()

function M.setup()
  -- null-ls
  require("config.lsp.null-ls").setup(opts)

  -- Installer
  require("config.lsp.installer").setup(servers, opts)
end

local diagnostics_active = true

function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

function M.remove_unused_imports()
  vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
  vim.cmd "packadd cfilter"
  vim.cmd "Cfilter /main/"
  vim.cmd "Cfilter /The import/"
  vim.cmd "cdo normal dd"
  vim.cmd "cclose"
  vim.cmd "wa"
end

return M
