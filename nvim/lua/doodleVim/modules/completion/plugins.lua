local completion = {}
local conf = require "doodleVim.modules.completion.config"

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
    local tabnine = require "cmp_tabnine.config"
    tabnine:setup {
      max_lines = 1000,
      max_num_results = 20,
      sort = true,
      run_on_every_keystroke = true,
      snippet_placeholder = "..",
      ignored_file_types = { -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
      },
    }
  end,
  run = "./install.sh",
}

completion["octaltree/cmp-look"] = {
  after = "nvim-cmp",
}

completion["hrsh7th/cmp-cmdline"] = {
  after = "nvim-cmp",
}

-- completion["github/copilot.vim"] = {}

completion["zbirenbaum/copilot.lua"] = {
  event = { "VimEnter" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup {
        cmp = {
          enabled = true,
          method = "getPanelCompletions",
        },
        panel = { -- no config options yet
          enabled = true,
        },
        ft_disable = { "markdown" },
        -- plugin_manager_path = vim.fn.stdpath "data" .. "/site/pack/packer",
        -- server_opts_overrides = {},
      }
    end, 100)
  end,
}

completion["zbirenbaum/copilot-cmp"] = {
  module = "copilot_cmp",
}

completion["L3MON4D3/LuaSnip"] = {
  after = "nvim-cmp",
  config = conf.luasnip,
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

completion["williamboman/nvim-lsp-installer"] = {
  opt = true,
  after = { "nlsp-settings.nvim", "lsp_signature.nvim", "nvim-lspconfig" },
  config = conf.nvim_lsp_installer,
}

completion["doodleEsc/lightbulb.nvim"] = {
  after = "nvim-lsp-installer",
  config = conf.lightbulb,
}

completion["jose-elias-alvarez/null-ls.nvim"] = {
  after = "nvim-lsp-installer",
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

return completion
