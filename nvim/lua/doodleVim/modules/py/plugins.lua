local py = {}
local conf = require("doodleVim.modules.py.config")

py["wakatime/vim-wakatime"] = {}

py["github/copilot.vim"] = {}

py["alpertuna/vim-header"] = {
    config = conf.header,
}

return py
