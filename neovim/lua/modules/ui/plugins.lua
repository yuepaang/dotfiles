local ui = {}
local conf = require("modules.ui.config")

ui['nvim-treesitter/nvim-treesitter'] = {
    opt = true,
    setup = function()
        require("utils.defer").add("nvim-treesitter", 100)
    end,
    config = conf.treesitter,
    requires = {{
        'nvim-treesitter/nvim-treesitter-textobjects',
        opt = true
    }, {'RRethy/nvim-treesitter-textsubjects'}, {
        'lewis6991/spellsitter.nvim',
        config = conf.spellsitter
    }, {'p00f/nvim-ts-rainbow'}, {
        'SmiteshP/nvim-gps',
        config = conf.gps
    }},
    run = ':TSUpdate'
}

ui['norcalli/nvim-colorizer.lua'] = {
    ft = {"lua", "vim", "markdown"},
    config = function()
        require('colorizer').setup()
    end
}

ui['nvim-lualine/lualine.nvim'] = {
    opt = true,
    setup = function()
        require("utils.defer").add("lualine.nvim", 90)
    end,
    requires = {'kyazdani42/nvim-web-devicons'},
    config = conf.lualine
}

ui['cinuor/gruvbox.nvim'] = {
    opt = true
}

ui['NTBBloodbath/doom-one.nvim'] = {}

ui['lukas-reineke/indent-blankline.nvim'] = {
    opt = true,
    setup = function()
        require("utils.defer").add("indent-blankline.nvim", 90)
    end,
    config = conf.blankline
}

ui['cinuor/lspsaga.nvim'] = {
    after = "nvim-lspconfig",
    config = conf.lspsaga
}

ui['lewis6991/gitsigns.nvim'] = {
    opt = true,
    config = conf.gitsigns,
    requires = {'nvim-lua/plenary.nvim'},
    setup = function()
        require("utils.defer").add("gitsigns.nvim", 90)
    end
}

ui['petertriho/nvim-scrollbar'] = {
    requires = {{
        'kevinhwang91/nvim-hlslens',
        config = conf.hlslens
    }},
    config = conf.scrollbar
}

ui['goolord/alpha-nvim'] = {
    config = conf.alpha
}

ui['j-hui/fidget.nvim'] = {
    requires = {'nvim-lualine/lualine.nvim'},
    config = conf.fidget
}

return ui