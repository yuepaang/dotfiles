local M = {}

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    -- arrow_open = " ",
    -- arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

function M.setup()
  require("nvim-tree").setup({
    renderer = {
      indent_markers = {
        enable = true,
      },
    },
    filters = {
      dotfiles = false,
    },
    disable_netrw = false,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
      "startify",
      "dashboard",
      "alpha",
    },
    open_on_tab = false,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },

    view = {
      side = "left",
      width = 30,
      hide_root_folder = true,
      number = true,
      relativenumber = true,
    },
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
      ignore_list = {},
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    trash = {
      cmd = "trash",
      require_confirm = true,
    },
  })

  vim.g.nvim_tree_respect_buf_cwd = 1
end

return M
