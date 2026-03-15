return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    { "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in explorer" },
  },
  opts = {
    view = { width = 30, side = "left" },
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
