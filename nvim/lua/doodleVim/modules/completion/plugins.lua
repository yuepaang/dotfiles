local completion = {}
local conf = require("doodleVim.modules.completion.config")

completion["hrsh7th/nvim-cmp"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("nvim-cmp", 50)
  end,
  requires = {
    { "hrsh7th/cmp-nvim-lsp", opt = true },
    { "saadparwaiz1/cmp_luasnip", opt = true },
    { "hrsh7th/cmp-buffer", opt = true },
    { "hrsh7th/cmp-path", opt = true },
    { "octaltree/cmp-look", opt = true },
    { "hrsh7th/cmp-cmdline", opt = true },
    { "ray-x/cmp-treesitter", opt = true },
    { "lukas-reineke/cmp-under-comparator", opt = true },
    { "windwp/nvim-autopairs", opt = true },
    { "L3MON4D3/LuaSnip", opt = true, config = conf.luasnip },
    { "danymat/neogen", opt = true, config = conf.neogen },
  },
  config = conf.nvim_cmp,
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

completion["kylechui/nvim-surround"] = {
  after = "nvim-cmp",
  config = conf.nvim_surround,
}

completion["williamboman/mason-lspconfig.nvim"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("mason-lspconfig.nvim", 60)
  end,
  requires = {
    { "neovim/nvim-lspconfig", opt = true },
    { "ray-x/lsp_signature.nvim", opt = true },
    { "tamago324/nlsp-settings.nvim", opt = true, config = conf.nlsp_settings },
    {
      "williamboman/mason.nvim",
      opt = true,
      setup = function()
        require("doodleVim.extend.packer").add("mason", function()
          require("doodleVim.utils.defer").immediate_load("mason.nvim")
          local binaries = {
            "gopls",
            "json-lsp",
            "lua-language-server",
            "python-lsp-server",
            "debugpy",
            "ruff",
            "gotests",
            "gomodifytags",
            "clangd",
            "impl",
          }
          local register = require("mason-registry")
          local bins = ""
          for _, bin in ipairs(binaries) do
            if not register.is_installed(bin) then
              bins = bins .. " " .. bin
            end
          end
          if #bins > 0 then
            vim.cmd("MasonInstall" .. bins)
          end
        end)
      end,
      config = conf.mason,
    },
  },
  config = conf.mason_lspconfig,
}

completion["jose-elias-alvarez/null-ls.nvim"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("null-ls.nvim", 50)
  end,
  requires = {
    { "doodleEsc/gotools.nvim", opt = true, config = conf.gotools },
  },
  config = conf.null_ls,
}

completion["doodleEsc/lightbulb.nvim"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("lightbulb.nvim", 40)
  end,
  config = conf.lightbulb,
}

completion["doodleEsc/rename.nvim"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("rename.nvim", 40)
  end,
}

completion["doodleEsc/friendly-snippets"] = {
  opt = true,
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

return completion
