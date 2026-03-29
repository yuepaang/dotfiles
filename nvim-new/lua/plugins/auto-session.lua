return {
  "rmagatti/auto-session",
  lazy = false,
  opts = {
    suppressed_dirs = { "~/", "~/Downloads", "/tmp" },
    session_lens = {
      load_on_setup = true,
    },
  },
  keys = {
    { "<leader>qs", "<cmd>SessionSave<cr>", desc = "Save session" },
    { "<leader>qr", "<cmd>SessionRestore<cr>", desc = "Restore session" },
    { "<leader>qd", "<cmd>SessionDelete<cr>", desc = "Delete session" },
    { "<leader>qf", "<cmd>AutoSession search<cr>", desc = "Search sessions" },
  },
}
