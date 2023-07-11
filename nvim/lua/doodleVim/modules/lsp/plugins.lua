local lsp = {}
local conf = require("doodleVim.modules.lsp.config")
local setup = require("doodleVim.modules.lsp.setup")

lsp["neovim/nvim-lspconfig"] = {
  lazy = true,
  event = "BufReadPost",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "tamago324/nlsp-settings.nvim",
    "mortepau/codicons.nvim",
    "utilyre/barbecue.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = {
    servers = {
      jdtls = {
        disabled = true,
      },
    },
  },
  config = conf.lspconfig,
}

lsp["hrsh7th/cmp-nvim-lsp"] = {
  lazy = true,
}

lsp["mfussenegger/nvim-jdtls"] = {
  lazy = true,
  ft = "java",
  config = conf.jdtls,
}

lsp["tamago324/nlsp-settings.nvim"] = {
  lazy = true,
  config = conf.nlsp_settings,
}

lsp["williamboman/mason.nvim"] = {
  lazy = true,
  init = setup.mason,
  cmd = { "Mason", "MasonInstall", "MasonUninstall" },
  config = conf.mason,
}

lsp["jose-elias-alvarez/null-ls.nvim"] = {
  lazy = true,
  event = "User DeferStartWithFile",
  -- dependencies = {
  --   "doodleEsc/gotools.nvim",
  -- },
  config = conf.null_ls,
}

lsp["VidocqH/lsp-lens.nvim"] = {
  lazy = true,
  event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
  config = conf.lsp_lens,
}

lsp["doodleEsc/rename.nvim"] = {
  lazy = true,
  dependencies = {
    "neovim/nvim-lspconfig",
    "stevearc/dressing.nvim",
  },
}

lsp["doodleEsc/gotools.nvim"] = {
  lazy = true,
  ft = "go",
  dependencies = {
    "stevearc/dressing.nvim",
  },
  config = conf.gotools,
}

lsp["kosayoda/nvim-lightbulb"] = {
  lazy = true,
  event = { "User DeferStartWithFile", "BufAdd", "BufNewFile" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "mortepau/codicons.nvim",
  },
  config = conf.lightbulb,
}

lsp["ray-x/lsp_signature.nvim"] = {
  lazy = true,
  init = setup.lsp_signature,
}

lsp["utilyre/barbecue.nvim"] = {
  lazy = true,
  version = "*",
  enabled = false,
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons", -- optional dependency
  },
  config = conf.barbecue,
}

-- lsp["LunarVim/bigfile.nvim"] = {
--
-- }

return lsp
