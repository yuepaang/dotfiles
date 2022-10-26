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
  setup = function()
    require("doodleVim.extend.packer").add("mason", function()
      require("doodleVim.utils.defer").immediate_load("mason.nvim")
      vim.cmd(
        [[MasonInstall gopls json-lsp lua-language-server python-lsp-server rust_analyzer taplo debugpy delve gotests gomodifytags ]]
      )
    end)
  end,
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
}

completion["b0o/SchemaStore.nvim"] = {
  after = { "nvim-lspconfig" },
}

completion["RRethy/vim-illuminate"] = {
  config = function()
    require("illuminate").configure({
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      -- delay: delay in milliseconds
      delay = 120,
      -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
      filetypes_denylist = {
        "dirvish",
        "fugitive",
        "alpha",
        "NvimTree",
        "packer",
        "neogitstatus",
        "Trouble",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "DressingSelect",
        "TelescopePrompt",
      },
      -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
      filetypes_allowlist = {},
      -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
      modes_denylist = {},
      -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
      modes_allowlist = {},
      -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
      -- Only applies to the 'regex' provider
      -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
      providers_regex_syntax_denylist = {},
      -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
      -- Only applies to the 'regex' provider
      -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
      providers_regex_syntax_allowlist = {},
      -- under_cursor: whether or not to illuminate under the cursor
      under_cursor = true,
    })
  end,
}

completion["christianchiarulli/lua-dev.nvim"] = {}

completion["SmiteshP/nvim-navic"] = {
  after = "mason-lspconfig.nvim",
}

return completion
