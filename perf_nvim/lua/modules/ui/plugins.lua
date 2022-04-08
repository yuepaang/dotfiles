local ui = {}
local conf = require("modules.ui.config")

ui["nvim-treesitter/nvim-treesitter"] = {
    opt = true,
    setup = function()
        require("utils.defer").add("nvim-treesitter", 100)
    end,
    config = conf.treesitter,
    requires = { "nvim-treesitter/nvim-treesitter-textobjects", opt = true },
    run = ":TSUpdate",
}
ui["p00f/nvim-ts-rainbow"] = {
    after = "nvim-treesitter",
}

ui["windwp/nvim-ts-autotag"] = {
    after = "nvim-treesitter",
}

ui["norcalli/nvim-colorizer.lua"] = {
    ft = { "lua", "vim", "markdown" },
    config = function()
        require("colorizer").setup()
    end,
}

ui["nvim-lualine/lualine.nvim"] = {
    opt = true,
    setup = function()
        require("utils.defer").add("lualine.nvim", 90)
    end,
    requires = { "kyazdani42/nvim-web-devicons" },
    config = conf.lualine,
}

ui["cinuor/gruvbox.nvim"] = {
    opt = true,
}

ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    setup = function()
        require("utils.defer").add("indent-blankline.nvim", 90)
    end,
    config = conf.blankline,
}

ui["lewis6991/gitsigns.nvim"] = {
    opt = true,
    config = conf.gitsigns,
    requires = { "nvim-lua/plenary.nvim", opt = true },
    setup = function()
        require("utils.defer").add("gitsigns.nvim", 90)
    end,
    event = { "BufRead", "BufNewFile" },
}

ui["MunifTanjim/nui.nvim"] = {
    opt = true,
    after = "nvim-lspconfig",
}

ui["goolord/alpha-nvim"] = {
    config = function()
        require("modules.ui.alpha").setup()
    end,
}

ui["j-hui/fidget.nvim"] = {
    config = function()
        require("fidget").setup({
            text = {
                spinner = "moon",
            },
        })
    end,
}

ui["antoinemadec/FixCursorHold.nvim"] = {
    event = "BufRead",
    config = function()
        vim.g.cursorhold_updatetime = 100
    end,
}

return ui
