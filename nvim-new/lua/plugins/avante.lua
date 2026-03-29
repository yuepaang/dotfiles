return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false,
  build = "make",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    provider = "gemini",
    providers = {
      gemini = {
        model = "gemini-2.5-flash",
        extra_request_body = {
          temperature = 0.75,
          max_tokens = 8192,
        },
      },
    },
    hints = { enabled = true },
  },
}
