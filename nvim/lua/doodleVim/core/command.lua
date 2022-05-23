vim.api.nvim_create_user_command("GruvboxDump", "lua require('doodleVim.extend.gruvbox').dump()", {})
vim.api.nvim_create_user_command("ReloadConfig", "lua require('doodleVim.extend.misc').reload()", {})
vim.api.nvim_create_user_command("OpenTree", "lua require('doodleVim.extend.tree').toggle()", {})

-- show cursor line only in active window
local cursorGrp = vim.api.nvim_create_augroup("CursorLine", { clear = true })
vim.api.nvim_create_autocmd(
    { "InsertLeave", "WinEnter" },
    { pattern = "*", command = "set cursorline", group = cursorGrp }
)
vim.api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd("FocusGained", { command = [[:checktime]] })

vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

-- Copilot
vim.cmd([[
    imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true
]])
