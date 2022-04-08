local editor = {}
local conf = require("modules.editor.config")

editor["numToStr/Comment.nvim"] = {
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("Comment.nvim", 200)
    end,
    config = conf.comment,
}

editor["phaazon/hop.nvim"] = {
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("hop.nvim", 500)
    end,
    config = conf.hop,
}

editor["andymass/vim-matchup"] = {
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("vim-matchup", 200)
    end,
}

editor["junegunn/vim-easy-align"] = {
    opt = true,
    setup = function()
        require("utils.defer").packer_defer_load("vim-easy-align", 500)
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
        require("utils.defer").packer_defer_load("nvim-autopairs", 200)
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

editor["max397574/better-escape.nvim"] = {
    event = { "InsertEnter" },
    config = function()
        require("better_escape").setup({
            mapping = { "ii", "jj", "jk", "kj" },
            timeout = vim.o.timeoutlen,
            keys = "<ESC>",
        })
    end,
}

editor["ggandor/lightspeed.nvim"] = {
    requires = { "tpope/vim-repeat" },
    config = conf.lightspeed,
    event = "BufRead",
}

return editor
