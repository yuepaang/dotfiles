return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    flavour = "latte",
    color_overrides = {
      latte = {
        base = "#F7E7CE", mantle = "#F7E7CE", crust = "#E6D5B8",
        text = "#4A3C31", subtext1 = "#5B4A3D", subtext0 = "#8B7663",
        overlay2 = "#8B7663", overlay1 = "#A39279", overlay0 = "#C4B39A",
        surface2 = "#C4B39A", surface1 = "#E6D5B8", surface0 = "#EEDDC3",
        blue = "#6B9BC8", lavender = "#8BB8E0", sapphire = "#7FB8C0",
        sky = "#9FD8E0", teal = "#7FB8C0", green = "#8B9A4D",
        yellow = "#C4A050", peach = "#E0C078", red = "#D85C6C",
        maroon = "#E87C8C", mauve = "#A67C92", pink = "#C89CAC",
        flamingo = "#E87C8C", rosewater = "#C89CAC",
      },
    },
    custom_highlights = function(colors)
      return {
        NormalFloat = { bg = colors.base },
        FloatBorder = { fg = colors.overlay0, bg = colors.base },
        Visual = { bg = "#FFFFFF" },
        Cursor = { fg = colors.text, bg = "#FFFFFF" },
      }
    end,
    integrations = {
      blink_cmp = true,
      flash = true,
      gitsigns = true,
      mason = true,
      nvimtree = true,
      telescope = { enabled = true },
      treesitter = true,
      bufferline = true,
      which_key = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-latte")
    -- Preserve the terminal profile's distinct normal and bright ANSI colors.
    local ansi = {
      "#E6D5B8", "#D85C6C", "#8B9A4D", "#C4A050",
      "#6B9BC8", "#A67C92", "#7FB8C0", "#8B7663",
      "#C4B39A", "#E87C8C", "#A8B868", "#E0C078",
      "#8BB8E0", "#C89CAC", "#9FD8E0", "#5B4A3D",
    }
    for index, color in ipairs(ansi) do
      vim.g["terminal_color_" .. (index - 1)] = color
    end
  end,
}
