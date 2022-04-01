local g = vim.g

g.mapleader = " "

g.copilot_no_tab_map = true
g.copilot_assume_mapped = true
g.copilot_tab_fallback = ""
g.copilot_filetypes = {
    ["*"] = false,
    ["javascript"] = true,
    ["typescript"] = true,
    ["lua"] = false,
    ["rust"] = true,
    ["c"] = true,
    ["c#"] = true,
    ["c++"] = true,
    ["go"] = true,
    ["python"] = true,
  }

g.python3_host_skip_check = 1
g.python3_host_prog = "$HOME/.pyenv/versions/nvim-py3/bin/python"

-- add clipboard-provider
g.clipboard = {
  name = "myProvider",
  copy = {
    ["+"] = "clipboard-provider copy",
    ["*"] = "clipboard-provider copy",
  },
  paste = {
    ["+"] = "clipboard-provider paste",
    ["*"] = "clipboard-provider paste",
  },
  cache_enabled = 0,
}

-- Plugin configuration
PLUGINS = {
  coq = {
    enabled = false,
  },
  nvim_cmp = {
    enabled = true,
  },
  fzf_lua = {
    enabled = false,
  },
  telescope = {
    enabled = true,
  },
  nvim_dap = {
    enabled = true,
  },
  vimspector = {
    enabled = false,
  },
}

-- Disable some builtin vim plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  "matchit",
  "matchparen",
  "tar",
  "tarPlugin",
  "rrhelper",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
