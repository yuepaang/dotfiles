return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 900,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    picker = {
      enabled = true,
      sources = {
        files = { hidden = true },
      },
      win = {
        input = {
          keys = {
            ["<C-j>"] = { "list_down", mode = { "i", "n" } },
            ["<C-k>"] = { "list_up", mode = { "i", "n" } },
            ["<C-q>"] = { "qflist", mode = { "i", "n" } },
          },
        },
      },
      layout = {
        layout = {
          backdrop = false,
          row = 1,
          width = 0.8,
          min_width = 80,
          height = 0.8,
          border = "rounded",
          box = "vertical",
          { win = "input", height = 1, border = "bottom" },
          {
            box = "horizontal",
            { win = "list", border = "none" },
            { win = "preview", width = 0.55, border = "left" },
          },
        },
      },
    },
    statuscolumn = { enabled = true },
    terminal = { enabled = true },
    words = { enabled = true },
  },
  keys = {
    -- Picker (replaces telescope)
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Live grep" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help tags" },
    { "<leader>fc", function() Snacks.picker.command_history() end, desc = "Command history" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
    { "<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Find TODOs" },
    { "<leader><leader>", function() Snacks.picker.resume() end, desc = "Resume last search" },
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Fuzzy find in buffer" },
    -- Notifications
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss notifications" },
    -- Git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit log" },
    -- Word references
    { "]]", function() Snacks.words.jump(1, true) end, desc = "Next reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-1, true) end, desc = "Previous reference", mode = { "n", "t" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        vim.print = _G.dd
      end,
    })
  end,
}
