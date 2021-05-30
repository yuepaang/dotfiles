-- vim: ts=2 sw=2 et:
local api = vim.api
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

local custom_attach = function(client, bufnr)
    -- test --
    local basics = require('lsp_basics')
    basics.make_lsp_commands(client, bufnr)
    basics.make_lsp_mappings(client, bufnr)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- test --

    nmap('gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    nmap('gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    nmap('K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    nmap('gi', ':lua vim.lsp.buf.implementation()<CR>')
    nmap('gr', ':lua vim.lsp.buf.references()<CR>')
    nmap('gt', ':lua vim.lsp.buf.type_definition()<CR>')
    nmap('<leader>af', ':lua vim.lsp.buf.code_action()<CR>')
    nmap('<leader>rn', ':lua vim.lsp.buf.rename()<CR>')

    nmap('<Leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>')
end

local function get_lua_runtime()
    local result = {}
    for _, path in pairs(api.nvim_list_runtime_paths()) do
        local lua_path = path .. '/lua/';
        if vim.fn.isdirectory(lua_path) then
            result[lua_path] = true
        end
    end
    result[vim.fn.expand('$VIMRUNTIME/lua')] = true
    return result;
end

local system_name = 'Linux'
local sumneko_root_path = vim.fn.expand('$HOME/common/lua-language-server')
local sumneko_binary = sumneko_root_path .. '/bin/' .. system_name .. '/lua-language-server'

local servers = {
    bashls = {},
    cssls = {},
    gopls = {},
    html = {},
    jsonls = {},
    vimls = {},
    yamlls = {},

    sumneko_lua = {
        cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = vim.split(package.path, ';')
                },
                diagnostics = {
                    enable = true,
                    globals = {'vim', 'use'}
                },
                workspace = {
                    library = get_lua_runtime(),
                    maxPreload = 2000,
                    preloadFileSize = 50000
                },
                telemetry = {
                    enable = false
                }
            }
        }
    },

    tsserver = {
        filetypes = {'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact',
                     'typescript.tsx'},
        root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')
    },

    pyright = {},
    rust_analyzer = {}
}

for server, config in pairs(servers) do
    config.on_attach = custom_attach
    lspconfig[server].setup(config)
end

