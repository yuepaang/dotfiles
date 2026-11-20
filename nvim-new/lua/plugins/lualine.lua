local function wide()
  return vim.o.columns >= 100
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      theme = "auto",
      globalstatus = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { statusline = { "snacks_dashboard" } },
    },
    sections = {
      lualine_a = { {
        "mode",
        fmt = function(mode)
          return wide() and mode or mode:sub(1, 1)
        end,
      } },
      lualine_b = { { "branch", cond = wide } },
      lualine_c = {
        { "diagnostics" },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 0 },
      },
      lualine_x = {
        { "diff", cond = wide },
      },
      lualine_y = { { "progress", cond = wide } },
      lualine_z = { "location" },
    },
    extensions = { "lazy", "nvim-tree" },
  },
}
