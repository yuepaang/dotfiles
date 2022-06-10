local lsp_installer_servers = require "nvim-lsp-installer.servers"
local utils = require "utils"

local M = {}

function M.setup(servers, options)
  local settings = {
    ensure_installed = servers,
    -- automatic_installation = false,
    ui = {
      icons = {
        -- server_installed = "◍",
        -- server_pending = "◍",
        -- server_uninstalled = "◍",
        -- server_installed = "✓",
        -- server_pending = "➜",
        -- server_uninstalled = "✗",
      },
      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
      },
    },

    log_level = vim.log.levels.INFO,
    -- max_concurrent_installers = 4,
    -- install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" },
  }
  local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
  if not status_ok then
    return
  end
  lsp_installer.setup(settings)

  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
    return
  end

  for server_name, _ in pairs(servers) do
    local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})

    if server_name == "sumneko_lua" then
      opts = require("lua-dev").setup { lspconfig = opts }
    end

    -- https://github.com/williamboman/nvim-lsp-installer/wiki/Rust
    if server_name == "rust_analyzer" then
      local _, server = lsp_installer_servers.get_server(server_name)
      require("rust-tools").setup {
        server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
      }
      server:attach_buffers()
    elseif server_name == "tsserver" then
      require("typescript").setup { server = opts }
    elseif server_name == "jdtls" then
      -- Do nothing, jdtls is handled by nvim-jdtls
      -- print "jdtls is handled by nvim-jdtls"
    elseif server_name == "dartls" then
      -- Do nothing, jdtls is handled by flutter-tools
      -- print "dartls is handled by flutter-tools"
    else
      lspconfig[server_name].setup(opts)
    end
  end
end

return M
