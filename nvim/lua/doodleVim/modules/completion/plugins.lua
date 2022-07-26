local completion = {}
local conf = require("doodleVim.modules.completion.config")

-- COMPLETION
completion["hrsh7th/nvim-cmp"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("nvim-cmp", 50)
  end,
  config = conf.nvim_cmp,
}

completion["hrsh7th/cmp-nvim-lsp"] = {
  after = "nvim-cmp",
}

completion["hrsh7th/cmp-nvim-lua"] = {
  after = "nvim-cmp",
}

completion["saadparwaiz1/cmp_luasnip"] = {
  after = "nvim-cmp",
}

completion["hrsh7th/cmp-buffer"] = {
  after = "nvim-cmp",
}

completion["hrsh7th/cmp-path"] = {
  after = "nvim-cmp",
}

completion["tzachar/cmp-tabnine"] = {
  after = "nvim-cmp",
  config = function()
    local tabnine = require("cmp_tabnine.config")
    tabnine:setup({
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = { -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
      },
    })
  end,
  run = "./install.sh",
}

completion["hrsh7th/cmp-cmdline"] = {
  after = "nvim-cmp",
}

completion["L3MON4D3/LuaSnip"] = {
  after = "nvim-cmp",
  config = conf.luasnip,
}

completion["saadparwaiz1/cmp_luasnip"] = {
  after = "nvim-cmp",
}

completion["doodleEsc/friendly-snippets"] = {
  opt = true,
}

completion["neovim/nvim-lspconfig"] = {
  after = "cmp-nvim-lsp",
}

completion["ray-x/lsp_signature.nvim"] = {
  after = "nvim-lspconfig",
}

completion["tamago324/nlsp-settings.nvim"] = {
  after = "nvim-lspconfig",
  config = conf.nlsp_settings,
}

completion["williamboman/mason.nvim"] = {
  opt = true,
  after = "nvim-cmp",
  config = conf.mason,
}

completion["williamboman/mason-lspconfig.nvim"] = {
  opt = true,
  after = {
    "mason.nvim",
    "nvim-lspconfig",
    "nlsp-settings.nvim",
    "lsp_signature.nvim",
  },
  config = conf.mason_lspconfig,
}

completion["doodleEsc/lightbulb.nvim"] = {
  after = "mason-lspconfig.nvim",
  config = conf.lightbulb,
}

completion["doodleEsc/gotools.nvim"] = {
  after = { "mason-lspconfig.nvim", "nui.nvim" },
  config = conf.gotools,
}

completion["jose-elias-alvarez/null-ls.nvim"] = {
  after = { "mason-lspconfig.nvim", "gotools.nvim" },
  config = conf.null_ls,
}

completion["danymat/neogen"] = {
  after = { "nvim-cmp", "LuaSnip" },
  config = conf.neogen,
}

completion["doodleEsc/rename.nvim"] = {
  after = { "nvim-lspconfig", "nui.nvim" },
  config = conf.rename,
}

completion["b0o/SchemaStore.nvim"] = {
  after = { "nvim-lspconfig" },
}

completion["RRethy/vim-illuminate"] = {}

completion["christianchiarulli/lua-dev.nvim"] = {}

return completion
