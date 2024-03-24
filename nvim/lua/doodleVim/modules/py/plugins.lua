local py = {}
local conf = require("doodleVim.modules.py.config")

py["wakatime/vim-wakatime"] = {}

py["github/copilot.vim"] = {}

py["alpertuna/vim-header"] = {
  config = conf.header,
}

py["akinsho/toggleterm.nvim"] = {
  config = conf.toggleterm,
}

py["saecki/crates.nvim"] = {
  config = conf.crates,
}

return py
