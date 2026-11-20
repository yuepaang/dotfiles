local servers = {
  "gopls",
  "pyright",
  "ruff",
  "lua_ls",
  "dockerls",
  "docker_compose_language_service",
  "jsonls",
  "yamlls",
  "taplo",
  "ts_ls",
  "bashls",
  "clangd",
  "html",
  "cssls",
}

return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall" },
    ft = {
      "go", "gomod", "gowork", "gotmpl", "python", "lua", "dockerfile", "json", "jsonc",
      "yaml", "yaml.docker-compose", "toml", "javascript", "javascriptreact", "typescript",
      "typescriptreact", "rust", "sh", "bash", "c", "cpp", "objc", "objcpp", "cuda", "html", "css", "scss", "less",
    },
    config = function()
      require("mason").setup({ ui = { border = "rounded" } })
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Diagnostics
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true },
      })

      -- LSP keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local buf = event.buf
          local map = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gr", vim.lsp.buf.references, "Go to references")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
          map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover documentation")
          map("n", "gK", vim.lsp.buf.signature_help, "Signature help")
          map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>cf", function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end, "Format")

          -- Document highlight
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method("textDocument/documentHighlight") then
            local hl_group = vim.api.nvim_create_augroup("lsp-highlight-" .. buf, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = buf,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = buf,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      vim.lsp.config("*", { capabilities = capabilities })
      for _, server in ipairs(servers) do
        local config = vim.lsp.config[server]
        if vim.fn.executable(config.cmd[1]) == 1 then
          vim.lsp.enable(server)
        end
      end
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = { "mason.nvim" },
    opts = { automatic_enable = servers },
  },
}
