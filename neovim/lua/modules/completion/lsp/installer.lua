local lsp_installer_servers = require "nvim-lsp-installer.servers"

local M = {}

local function info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local function error(msg, name)
  vim.notify(msg, vim.log.levels.ERROR, { title = name })
end

function M.setup(servers, options)
  for server_name, _ in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)

    if server_available then
      server:on_ready(function()
        local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})

        if server.name == "sumneko_lua" then
          opts = require("lua-dev").setup { lspconfig = opts }
        end

        -- https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
        if server.name == "rust_analyzer" then
          require("rust-tools").setup {
            server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
          }
          server:attach_buffers()
        else
          server:setup(opts)
        end
      end)

      if not server:is_installed() then
        info("Installing " .. server.name, "LSP")
        server:install()
      end
    else
      error(server)
    end
  end
end

return M
