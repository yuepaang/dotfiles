local utils = require("user.utils")
local astro_utils = require("astronvim.utils")

-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local mappings = {
	-- first key is the mode
	n = {
		["<F4>"] = { ":AddHeader<cr>" },
		["Q"] = {
			function()
				require("astronvim.utils.buffer").close()
			end,
			desc = "Close buffer",
		},
		["<leader>c"] = {
			function()
				require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
			end,
			desc = "Comment line",
		},
		-- better buffer navigation
		["]b"] = false,
		["[b"] = false,
		["<S-l>"] = {
			function()
				require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
			end,
			desc = "Next buffer",
		},
		["<S-h>"] = {
			function()
				require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
			end,
			desc = "Previous buffer",
		},
		-- better search
		n = { utils.better_search("n"), desc = "Next search" },
		N = { utils.better_search("N"), desc = "Previous search" },
		-- buffer switching
		["<Tab>"] = {
			function()
				if #vim.t.bufs > 1 then
					require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
				else
					astro_utils.notify("No other buffers open")
				end
			end,
			desc = "Switch Buffers",
		},
		-- neogen
		["<leader>a"] = { desc = "󰏫 Annotate" },
		["<leader>a<cr>"] = {
			function()
				require("neogen").generate()
			end,
			desc = "Current",
		},
		["<leader>ac"] = {
			function()
				require("neogen").generate({ type = "class" })
			end,
			desc = "Class",
		},
		["<leader>af"] = {
			function()
				require("neogen").generate({ type = "func" })
			end,
			desc = "Function",
		},
		["<leader>at"] = {
			function()
				require("neogen").generate({ type = "type" })
			end,
			desc = "Type",
		},
		["<leader>aF"] = {
			function()
				require("neogen").generate({ type = "file" })
			end,
			desc = "File",
		},
	},
	i = {
		-- type template string
		["<C-CR>"] = { "<++>", desc = "Insert template string" },
		["<S-Tab>"] = { "<C-V><Tab>", desc = "Tab character" },
		-- date/time input
		["<c-t>"] = { desc = "󰃰 Date/Time" },
		["<c-t>n"] = { "<c-r>=strftime('%Y-%m-%d')<cr>", desc = "Y-m-d" },
		["<c-t>x"] = { "<c-r>=strftime('%m/%d/%y')<cr>", desc = "m/d/y" },
		["<c-t>f"] = { "<c-r>=strftime('%B %d, %Y')<cr>", desc = "B d, Y" },
		["<c-t>X"] = { "<c-r>=strftime('%H:%M')<cr>", desc = "H:M" },
		["<c-t>F"] = { "<c-r>=strftime('%H:%M:%S')<cr>", desc = "H:M:S" },
		["<c-t>d"] = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", desc = "Y/m/d H:M:S -" },
	},
	t = {
		-- setting a mapping to false will disable it
		-- ["<esc>"] = false,
	},
	x = {
		-- better increment/decrement
		["+"] = { "g<C-a>", desc = "Increment number" },
		["-"] = { "g<C-x>", desc = "Descrement number" },
		-- line text-objects
		["il"] = { "g_o^", desc = "Inside line text object" },
		["al"] = { "$o^", desc = "Around line text object" },
		-- Easy-Align
		ga = { "<Plug>(EasyAlign)", desc = "Easy Align" },
		-- vim-sandwich
		["s"] = "<Nop>",
	},
	o = {
		-- line text-objects
		["il"] = { ":normal vil<cr>", desc = "Inside line text object" },
		["al"] = { ":normal val<cr>", desc = "Around line text object" },
	},
}

-- add more text objects for "in" and "around"
for _, char in ipairs({ "_", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" }) do
	for _, mode in ipairs({ "x", "o" }) do
		mappings[mode]["i" .. char] =
			{ string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char), desc = "between " .. char }
		mappings[mode]["a" .. char] =
			{ string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char), desc = "around " .. char }
	end
end

return mappings
