local editor = {}
local conf = require("modules.editor.config")

editor["numToStr/Comment.nvim"] = {
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("Comment.nvim", 1000)
    end,
    config = conf.comment,
}

editor["phaazon/hop.nvim"] = {
    branch = "v1",
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("hop.nvim", 1000)
    end,
    config = conf.hop,
}

editor["andymass/vim-matchup"] = {
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("vim-matchup", 1000)
    end,
}

editor["junegunn/vim-easy-align"] = {
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("vim-easy-align", 1000)
    end,
}

editor["karb94/neoscroll.nvim"] = {
    opt = true,
    setup = function()
        require("utils.defer").add("neoscroll.nvim", 100)
    end,
    config = conf.neoscroll,
}

editor["folke/todo-comments.nvim"] = {
    opt = true,
    setup = function()
        require("utils.defer").add("todo-comments.nvim", 100)
    end,
    config = conf.todo,
}

editor["windwp/nvim-autopairs"] = {
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("nvim-autopairs", 1000)
    end,
    config = conf.autopairs,
}

editor["romgrk/barbar.nvim"] = {
    opt = true,
    setup = function()
        require("modules.editor.config").barbar()
        require("utils.defer").add("barbar.nvim", 90)
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
}

editor["ggandor/lightspeed.nvim"] = {
    key = { "s", "S", "f", "F", "t", "T" },
    requires = { "tpope/vim-repeat" },
    config = conf.lightspeed,
}

editor["rcarriga/nvim-notify"] = {
    event = "VimEnter",
    config = conf.notify,
}

-- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
editor["antoinemadec/FixCursorHold.nvim"] = {
    event = "BufReadPre",
    config = function()
        vim.g.cursorhold_updatetime = 100
    end,
}

editor["tpope/vim-surround"] = {
    event = "InsertEnter",
}

editor["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
        require("better_escape").setup({
            mapping = { "jk" },
            timeout = vim.o.timeoutlen,
            keys = "<ESC>",
        })
    end,
}

return editor