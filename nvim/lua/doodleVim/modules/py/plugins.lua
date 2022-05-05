local py = {}
local conf = require("doodleVim.modules.py.config")

py["wakatime/vim-wakatime"] = {}

py["j-hui/fidget.nvim"] = {
    config = function()
        require("fidget").setup({
            text = {
                spinner = "moon",
            },
        })
    end,
}

py["max397574/better-escape.nvim"] = {
    event = { "InsertEnter" },
    config = function()
        require("better_escape").setup({
            mapping = { "ii", "jj", "jk", "kj" },
            timeout = vim.o.timeoutlen,
            keys = "<ESC>",
        })
    end,
}

py["ggandor/lightspeed.nvim"] = {
    requires = { "tpope/vim-repeat" },
    keys = { "s", "S", "f", "F", "t", "T" },
    config = conf.lightspeed,
    event = "BufRead",
}

return py
