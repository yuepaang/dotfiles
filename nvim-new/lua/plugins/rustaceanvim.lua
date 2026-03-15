return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = "rust",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          checkOnSave = { command = "clippy" },
          inlayHints = {
            closingBraceHints = { enabled = true },
            parameterHints = { enabled = true },
            typeHints = { enabled = true },
          },
        },
      },
    },
  },
}
