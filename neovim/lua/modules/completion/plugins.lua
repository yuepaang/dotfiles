local completion = {}
local conf = require("modules.completion.config")

-- COMPLETION
completion["hrsh7th/nvim-cmp"] = {
    opt = true,
    setup = function()
        require("utils.defer").add("nvim-cmp", 50)
    end,
    config = conf.nvim_cmp,
}

completion["hrsh7th/cmp-nvim-lsp"] = {
    after = "nvim-cmp",
}

completion["saadparwaiz1/cmp_luasnip"] = {
    after = "nvim-cmp",
}

completion["hrsh7th/cmp-buffer"] = {
    after = "nvim-cmp",
}

completion["hrsh7th/cmp-path"] = {
    after = "nvim-cmp",
}

completion["tzachar/cmp-tabnine"] = {
    after = "nvim-cmp",
    run = "bash install.sh",
}

completion["github/copilot.vim"] = {
    after = "nvim-cmp",
}

completion["octaltree/cmp-look"] = {
    after = "nvim-cmp",
}

completion["SirVer/ultisnips"] = {
    after = "nvim-cmp",
}

completion["quangnguyen30192/cmp-nvim-ultisnips"] = {
    after = "nvim-cmp",
}

completion["L3MON4D3/LuaSnip"] = {
    after = "nvim-cmp",
    config = conf.luasnip,
}

completion["cinuor/friendly-snippets"] = {
    opt = true,
}

completion["neovim/nvim-lspconfig"] = {
    after = "nvim-cmp",
    wants = {
        "nvim-lsp-installer",
        "cmp-nvim-lsp",
        "lua-dev.nvim",
        "vim-illuminate",
        "null-ls.nvim",
        "schemastore.nvim",
    },
    requires = {
        "williamboman/nvim-lsp-installer",
        "folke/lua-dev.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        {
            "j-hui/fidget.nvim",
            config = function()
                require("fidget").setup({})
            end,
        },
        "b0o/schemastore.nvim",
        -- "ray-x/lsp_signature.nvim",
    },
    config = function()
        require("modules.completion.lsp").setup()
    end,
}

-- completion["ray-x/lsp_signature.nvim"] = {
--     after = "nvim-lspconfig",
-- }
--
-- completion["williamboman/nvim-lsp-installer"] = {
--     after = { "nvim-lspconfig", "lsp_signature.nvim" },
--     config = conf.nvim_lsp_installer,
-- }
--
-- completion["jose-elias-alvarez/null-ls.nvim"] = {
--     after = "nvim-lspconfig",
--     config = conf.null_ls,
-- }

completion["danymat/neogen"] = {
    after = "nvim-cmp",
    config = conf.neogen,
}

completion["RRethy/vim-illuminate"] = {}

completion["simrat39/rust-tools.nvim"] = {
    opt = true,
    require = "rust-lang/rust.vim",
    module = "rust-tools",
    ft = "rust",
    config = function()
        require("modules.completion.rust").setup()
    end,
}

return completion
