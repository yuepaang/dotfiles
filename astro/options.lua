-- set vim options here (vim.<first_key>.<second_key> = value)
return {
	opt = {
		-- set to true or false etc.
		relativenumber = true, -- sets vim.opt.relativenumber
		number = true, -- sets vim.opt.number
		spell = false, -- sets vim.opt.spell
		signcolumn = "auto", -- sets vim.opt.signcolumn to auto
		wrap = false, -- sets vim.opt.wrap
		conceallevel = 2, -- enable conceal
		foldenable = false,
		foldexpr = "nvim_treesitter#foldexpr()", -- set Treesitter based folding
		foldmethod = "expr",
		linebreak = true, -- linebreak soft wrap at words
		list = true, -- show whitespace characters
		-- listchars = { tab = " ", extends = "⟩", precedes = "⟨", trail = "·", eol = "﬋" },
		showbreak = "﬌ ",
    showtabline = 1,
    spellfile = vim.fn.expand "~/dotfiles/astro/spell/en.utf-8.add",
    swapfile = false,
	},
	g = {
		mapleader = " ", -- sets vim.g.mapleader
		autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
		cmp_enabled = true, -- enable completion at start
		autopairs_enabled = true, -- enable autopairs at start
		diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
		icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
		ui_notifications_enabled = true, -- disable notifications when toggling UI elements
		header_field_author = "Yue Peng",
		header_field_author_email = "yuepaang@gmail.com",
	},
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end
