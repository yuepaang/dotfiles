-- Copilot
vim.cmd([[
    imap <silent><script><expr> <C-e> copilot#Accept("\<CR>")
    let g:copilot_no_tab_map = v:true
]])
vim.api.nvim_create_user_command("GruvboxDump", "lua require('doodleVim.extend.gruvbox').dump()", {})
vim.api.nvim_create_user_command("ReloadConfig", "lua require('doodleVim.extend.misc').reload()", {})
vim.api.nvim_create_user_command("OpenTree", "lua require('doodleVim.extend.tree').toggle()", {})
vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})
