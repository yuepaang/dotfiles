return {
  settings = {
    rust_analyzer = {
      lens = {
        enable = true,
      },
      checkOnSave = {
        enable = true,
        command = "clippy",
      },
    },
  },
}
