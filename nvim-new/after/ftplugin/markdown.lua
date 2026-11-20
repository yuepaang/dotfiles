vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.conceallevel = 2
vim.opt_local.autoread = true

local markdown = require("render-markdown")
vim.keymap.set("n", "<leader>um", markdown.buf_toggle, { buffer = true, desc = "Toggle Markdown rendering" })

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
  .. " | setlocal wrap< linebreak< breakindent< conceallevel< autoread<"
  .. " | silent! nunmap <buffer> <leader>um"
