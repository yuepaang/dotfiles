local ui = {}
local conf = require("doodleVim.modules.ui.config")

ui["nvim-treesitter/nvim-treesitter"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("nvim-treesitter", 100)
  end,
  config = conf.treesitter,
  requires = { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
  run = ":TSUpdate bash cmake comment c cpp dot dockerfile go gomod gowork json html lua make python regex rust toml vim yaml norg solidity",
}

ui["norcalli/nvim-colorizer.lua"] = {
  ft = { "lua", "vim", "markdown" },
  config = function()
    require("colorizer").setup()
  end,
}

ui["kyazdani42/nvim-web-devicons"] = {}

ui["nvim-lualine/lualine.nvim"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("lualine.nvim", 99)
  end,
  requires = { "kyazdani42/nvim-web-devicons" },
  config = conf.lualine,
}

ui["doodleEsc/gruvbox.nvim"] = {
  opt = true,
}

ui["MunifTanjim/nui.nvim"] = {
  opt = true,
  setup = function()
    require("doodleVim.utils.defer").add("nui.nvim", 99)
  end,
  config = conf.nui,
}

ui["goolord/alpha-nvim"] = {
  config = conf.alpha,
}

return ui
