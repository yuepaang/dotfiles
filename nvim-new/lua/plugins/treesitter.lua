return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup({})
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(event)
          local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
          if lang and pcall(vim.treesitter.start, event.buf, lang) then
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })
      local selections = {
        af = "@function.outer",
        ["if"] = "@function.inner",
        ac = "@class.outer",
        ic = "@class.inner",
        al = "@loop.outer",
        il = "@loop.inner",
        ab = "@block.outer",
        ib = "@block.inner",
        aa = "@parameter.outer",
        ia = "@parameter.inner",
      }
      for key, capture in pairs(selections) do
        vim.keymap.set({ "x", "o" }, key, function()
          require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
        end, { desc = "Select " .. capture })
      end
      local movements = {
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
      }
      for method, mappings in pairs(movements) do
        for key, capture in pairs(mappings) do
          vim.keymap.set({ "n", "x", "o" }, key, function()
            require("nvim-treesitter-textobjects.move")[method](capture, "textobjects")
          end, { desc = method .. " " .. capture })
        end
      end
      for key, method in pairs({ ["<leader>a"] = "swap_next", ["<leader>A"] = "swap_previous" }) do
        vim.keymap.set("n", key, function()
          require("nvim-treesitter-textobjects.swap")[method]("@parameter.inner")
        end, { desc = method .. " parameter" })
      end
    end,
  },
}
