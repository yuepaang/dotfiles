reload "user.plugins"
reload "user.options"
reload "user.keymaps"
reload "user.autocommands"
reload "user.lsp"
reload "user.smoothie"
reload "user.harpoon"
reload "user.cybu"
reload "user.surround"
reload "user.bookmark"
reload "user.todo-comments"
reload "user.jaq"
reload "user.fidget"
reload "user.lab"
reload "user.git"
reload "user.zen-mode"
reload "user.inlay-hints"
reload "user.telescope"
reload "user.bqf"
reload "user.dial"
reload "user.numb"
-- reload "user.treesitter"
reload "user.neogit"
reload "user.colorizer"
reload "user.lualine"
reload "user.scrollbar"
-- reload "user.zk"
reload "user.chatgpt"
reload "user.whichkey"

-- Customization
-- =========================================
lvim.builtin.borderless_cmp = false
lvim.builtin.fancy_wild_menu = { active = false } -- enable/disable cmp-cmdline
lvim.builtin.sell_your_soul_to_devil = { active = true, prada = false } -- if you want microsoft to abuse your soul

-- Override Lunarvim defaults
-- =========================================
require("user.builtin").config()
