local M = {}

M.config = function()
  local kind = require "user.lsp_kind"
  -- Theme
  -- =========================================
  require("user.theme").tokyonight()
  lvim.builtin.theme.name = "tokyonight"

  -- CMP
  -- =========================================
  lvim.builtin.cmp.sources = {
    { name = "nvim_lsp" },
    { name = "cmp_tabnine", max_item_count = 3 },
    { name = "buffer", max_item_count = 5, keyword_length = 5 },
    { name = "path", max_item_count = 5 },
    { name = "luasnip", max_item_count = 3 },
    { name = "nvim_lua" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "latex_symbols" },
    { name = "crates" },
    { name = "orgmode" },
  }
  lvim.builtin.cmp.experimental = {
    ghost_text = false,
    native_menu = false,
    custom_menu = true,
  }
  local cmp_border = {
    { "╭", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╮", "CmpBorder" },
    { "│", "CmpBorder" },
    { "╯", "CmpBorder" },
    { "─", "CmpBorder" },
    { "╰", "CmpBorder" },
    { "│", "CmpBorder" },
  }
  local cmp_sources = {
    ["vim-dadbod-completion"] = "(DadBod)",
    buffer = "(Buffer)",
    cmp_tabnine = "(TabNine)",
    crates = "(Crates)",
    latex_symbols = "(LaTeX)",
    nvim_lua = "(NvLua)",
  }
  if lvim.builtin.borderless_cmp then
    vim.opt.pumblend = 4
    lvim.builtin.cmp.formatting.fields = { "abbr", "kind", "menu" }
    lvim.builtin.cmp.window = {
      completion = {
        border = cmp_border,
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
      documentation = {
        border = cmp_border,
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
      },
    }
    lvim.builtin.cmp.formatting.format = function(entry, vim_item)
      if entry.source.name == "cmdline" then
        vim_item.kind = ""
        vim_item.menu = ""
        return vim_item
      end
      vim_item.kind =
      string.format("%s %s", kind.cmp_kind[vim_item.kind] or " ", cmp_sources[entry.source.name] or vim_item.kind)

      return vim_item
    end
  else
    lvim.builtin.cmp.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        if entry.source.name == "cmdline" then
          vim_item.kind = "⌘"
          vim_item.menu = ""
          return vim_item
        end
        vim_item.menu = cmp_sources[entry.source.name] or vim_item.kind
        vim_item.kind = kind.cmp_kind[vim_item.kind] or vim_item.kind

        return vim_item
      end,
    }
  end
  local cmp_ok, cmp = pcall(require, "cmp")
  if not cmp_ok or cmp == nil then
    cmp = {
      mapping = function(...) end,
      setup = { filetype = function(...) end, cmdline = function(...) end },
      config = { sources = function(...) end },
    }
  end
  if lvim.builtin.fancy_wild_menu.active then
    local cmdline_opts = {
      mapping = cmp.mapping.preset.cmdline {},
      sources = {
        { name = "cmdline" },
        { name = "path" },
      },
    }
    if lvim.builtin.noice.active then
      cmdline_opts.window = {
        completion = {
          border = cmp_border,
          winhighlight = "Search:None",
        },
      }
    end
    cmp.setup.cmdline(":", cmdline_opts)
  end
  cmp.setup.filetype("toml", {
    sources = cmp.config.sources({
      { name = "nvim_lsp", max_item_count = 8 },
      { name = "crates" },
      { name = "luasnip", max_item_count = 5 },
    }, {
      { name = "buffer", max_item_count = 5, keyword_length = 5 },
    }),
  })
  cmp.setup.filetype("tex", {
    sources = cmp.config.sources({
      { name = "latex_symbols", max_item_count = 3, keyword_length = 3 },
      { name = "nvim_lsp", max_item_count = 8 },
      { name = "luasnip", max_item_count = 5 },
    }, {
      { name = "buffer", max_item_count = 5, keyword_length = 5 },
    }),
  })
  if lvim.builtin.sell_your_soul_to_devil.active then
    local function t(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    lvim.builtin.cmp.mapping["<c-h>"] = cmp.mapping(function()
      vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](t "<Tab>"), "n", true)
    end)
    lvim.keys.insert_mode["<M-]>"] = { "<Plug>(copilot-next)", { silent = true } }
    lvim.keys.insert_mode["<M-[>"] = { "<Plug>(copilot-previous)", { silent = true } }
    lvim.keys.insert_mode["<M-\\>"] = { "<Cmd>vertical Copilot panel<CR>", { silent = true } }
    lvim.builtin.cmp.mapping["<Tab>"] = cmp.mapping(M.tab, { "i", "c" })
    lvim.builtin.cmp.mapping["<S-Tab>"] = cmp.mapping(M.shift_tab, { "i", "c" })
  end

  -- Treesitter
  -- =========================================
  lvim.builtin.treesitter.context_commentstring.enable = true
  local languages = vim.tbl_flatten {
    { "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "d", "dart" },
    { "dockerfile", "elixir", "elm", "erlang", "fennel", "fish", "go", "gomod" },
    { "gomod", "graphql", "hcl", "help", "html", "java", "javascript", "jsdoc" },
    { "json", "jsonc", "julia", "kotlin", "latex", "ledger", "lua", "make" },
    { "markdown", "nix", "ocaml", "perl", "php", "python", "query", "r" },
    { "regex", "rego", "ruby", "rust", "scala", "scss", "solidity", "swift" },
    { "teal", "toml", "tsx", "typescript", "vim", "vue", "yaml", "zig" },
  }
  lvim.builtin.treesitter.ensure_installed = languages
  lvim.builtin.treesitter.highlight.disable = { "org" }
  lvim.builtin.treesitter.highlight.aditional_vim_regex_highlighting = { "org" }
  lvim.builtin.treesitter.ignore_install = { "haskell", "norg" }
  lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-r>",
    },
  }
  lvim.builtin.treesitter.matchup.enable = true
  -- lvim.treesitter.textsubjects.enable = true
  -- lvim.treesitter.playground.enable = true
  lvim.builtin.treesitter.query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  }
  lvim.builtin.treesitter.textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["aA"] = "@attribute.outer",
        ["iA"] = "@attribute.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["ac"] = "@call.outer",
        ["ic"] = "@call.inner",
        ["at"] = "@class.outer",
        ["it"] = "@class.inner",
        ["a/"] = "@comment.outer",
        ["i/"] = "@comment.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["aF"] = "@frame.outer",
        ["iF"] = "@frame.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["is"] = "@scopename.inner",
        ["as"] = "@statement.outer",
        ["av"] = "@variable.outer",
        ["iv"] = "@variable.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader><M-a>"] = "@parameter.inner",
        ["<leader><M-f>"] = "@function.outer",
        ["<leader><M-e>"] = "@element",
      },
      swap_previous = {
        ["<leader><M-A>"] = "@parameter.inner",
        ["<leader><M-F>"] = "@function.outer",
        ["<leader><M-E>"] = "@element",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]p"] = "@parameter.inner",
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[p"] = "@parameter.inner",
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  }
end

return M
