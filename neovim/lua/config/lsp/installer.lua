local M = {}

function M.setup(servers, options)
    local lspconfig = require "lspconfig"
    local icons = require "config.icons"

    local settings = {
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = false,
        ui = {
            icons = {
                server_installed = icons.server_installed,
                server_pending = icons.server_pending,
                server_uninstalled = icons.server_uninstalled,
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

    -- nvim-lsp-installer must be set up before nvim-lspconfig
    local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
    if not status_ok then
        return
    end
    lsp_installer.setup(settings)

    for server_name, _ in pairs(servers) do
        local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})

        if server_name == "sumneko_lua" then
            opts = require("lua-dev").setup { lspconfig = opts }
        end

        if server_name == "jdtls" then
            print "jdtls is handled by nvim-jdtls"
        elseif server_name == "rust_analyzer" then
            -- DAP settings - https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience
            local extension_path = vim.fn.glob(vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-*")
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
            require("rust-tools").setup {
                tools = {
                    on_initialized = function()
                        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                            pattern = { "*.rs" },
                            callback = function()
                                vim.lsp.codelens.refresh()
                            end,
                        })
                    end,
                },
                server = opts,
                dap = {
                    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
                },
            }
        elseif server_name == "tsserver" then
            require("typescript").setup {
                disable_commands = false,
                debug = false,
                server = opts,
            }
        else
            lspconfig[server_name].setup(opts)
        end
    end
end

return M
