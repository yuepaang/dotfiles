local lsp_installer_servers = require "nvim-lsp-installer.servers"
local utils = require "utils"

local M = {}

function M.setup(servers, options)
  for server_name, _ in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)

    if server_available then
      server:on_ready(function()
        local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})

        if server.name == "sumneko_lua" then
          opts = require("lua-dev").setup { lspconfig = opts }
        end

        if PLUGINS.coq.enabled then
          local coq = require "coq"
          opts = coq.lsp_ensure_capabilities(opts)
        end

        -- https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
        if server.name == "rust_analyzer" then
          require("rust-tools").setup {
            server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
            -- rust-tools options
            tools = {
              autoSetHints = true,
              hover_with_actions = true,
              inlay_hints = {
                show_parameter_hints = false,
                parameter_hints_prefix = "",
                other_hints_prefix = "",
              },
            },
            settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
              ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
              },
            },
          }
          server:attach_buffers()
        else
          server:setup(opts)
        end
      end)

      if not server:is_installed() then
        utils.info("Installing " .. server.name, "LSP")
        server:install()
      end
    else
      utils.error(server)
    end
  end
end

return M
