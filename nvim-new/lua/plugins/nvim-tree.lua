return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in explorer" },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    local tree = require("nvim-tree.api").tree
    vim.api.nvim_create_autocmd("QuitPre", {
      group = vim.api.nvim_create_augroup("NvimTreeQuit", { clear = true }),
      callback = function(event)
        local tree_win = tree.winid()
        if not tree_win then
          return
        end

        local editing_win
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          if win ~= tree_win and vim.api.nvim_win_get_config(win).relative == "" then
            if editing_win then
              return
            end
            editing_win = win
          end
        end

        if editing_win and vim.api.nvim_win_get_buf(editing_win) == event.buf then
          tree.close_in_this_tab()
        end
      end,
    })
  end,
  opts = {
    view = {
      width = function()
        return math.min(30, math.max(16, math.floor(vim.o.columns * 0.24)))
      end,
      side = "left",
    },
    renderer = {
      group_empty = true,
      indent_markers = { enable = true },
      icons = {
        git_placement = "after",
      },
    },
    filters = {
      dotfiles = false,
      custom = { "^.git$" },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    update_focused_file = {
      enable = true,
    },
    git = {
      enable = true,
      ignore = false,
    },
  },
}
