local M = {}

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

function M.setup()
  local nvim_tree = require "nvim-tree"
  nvim_tree.setup {
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = false,
      highlight_opened_files = "none",
      root_folder_modifier = ":t",
      indent_markers = {
        enable = false,
        icons = {
          corner = "└ ",
          edge = "│ ",
          none = "  ",
        },
      },
      icons = {
        glyphs = {

          default = "",
          symlink = "",
          folder = {
            -- arrow_open = " ",
            -- arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            deleted = "",
            untracked = "U",
            ignored = "◌",
          },
        },
      },
    },
    hijack_directories = {
      enable = false,
    },
    filters = {
      custom = { ".git" },
      exclude = { ".gitignore" },
    },
    respect_buf_cwd = true,
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
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = "left",
      -- auto_resize = true,
      mappings = {
        custom_only = false,
        list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", cb = tree_cb "close_node" },
          { key = "v", cb = tree_cb "vsplit" },
        },
      },
      number = false,
      relativenumber = false,
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
  }
end

return M
