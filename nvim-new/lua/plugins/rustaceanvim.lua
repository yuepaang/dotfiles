return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" },
            inlayHints = {
              closingBraceHints = { enabled = true },
              parameterHints = { enabled = true },
              typeHints = { enabled = true },
            },
          },
        },
      },
    }
  end,
}
