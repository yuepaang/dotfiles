local g = vim.g

g.mapleader = " "

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
