local ui = {}
local conf = require("doodleVim.modules.ui.config")


ui['nvim-treesitter/nvim-treesitter'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("nvim-treesitter", 100) end,
    config = conf.treesitter,
    requires = { 'nvim-treesitter/nvim-treesitter-textobjects', opt = true },
    run = ':TSUpdate'
}

ui['norcalli/nvim-colorizer.lua'] = {
    ft = { "lua", "vim", "markdown" },
    config = function() require('colorizer').setup() end
}

ui['nvim-lualine/lualine.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("lualine.nvim", 90) end,
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = conf.lualine,
}

ui['cinuor/gruvbox.nvim'] = {
    opt = true
}

ui['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    setup = function() require("doodleVim.utils.defer").add("indent-blankline.nvim", 90) end,
    config = conf.blankline,
}

ui['lewis6991/gitsigns.nvim'] = {
    opt = true,
    config = conf.gitsigns,
    requires = { 'nvim-lua/plenary.nvim' },
    setup = function() require("doodleVim.utils.defer").add("gitsigns.nvim", 90) end,
}

ui['MunifTanjim/nui.nvim'] = {
    opt = true,
    after = "nvim-lspconfig",
}

ui['goolord/alpha-nvim'] = {
    config = conf.alpha
}

return ui
