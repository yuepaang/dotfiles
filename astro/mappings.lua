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
		n = {
			utils.better_search("n"),
			desc = "Next search",
		},
		N = {
			utils.better_search("N"),
			desc = "Previous search",
		},
		-- buffer switching
		["<Tab>"] = {
			function()
				if #vim.t.bufs > 1 then
					require("telescope.builtin").buffers({
						sort_mru = true,
						ignore_current_buffer = true,
					})
				else
					astro_utils.notify("No other buffers open")
				end
			end,
			desc = "Switch Buffers",
		},
		-- neogen
		["<leader>a"] = {
			desc = "󰏫 Annotate",
		},
		["<leader>a<cr>"] = {
			function()
				require("neogen").generate()
			end,
			desc = "Current",
		},
		["<leader>ac"] = {
			function()
				require("neogen").generate({
					type = "class",
				})
			end,
			desc = "Class",
		},
		["<leader>af"] = {
			function()
				require("neogen").generate({
					type = "func",
				})
			end,
			desc = "Function",
		},
		["<leader>at"] = {
			function()
				require("neogen").generate({
					type = "type",
				})
			end,
			desc = "Type",
		},
		["<leader>aF"] = {
			function()
				require("neogen").generate({
					type = "file",
				})
			end,
			desc = "File",
		},
		["<leader>ah"] = { "<cmd>AddHeader<Cr>" },

		-- telescope plugin mappings
		["<leader>fB"] = {
			"<cmd>Telescope bibtex<cr>",
			desc = "Find BibTeX",
		},
		["<leader>fe"] = {
			"<cmd>Telescope file_browser<cr>",
			desc = "File explorer",
		},
		["<leader>fp"] = {
			function()
				require("telescope").extensions.projects.projects({})
			end,
			desc = "Find projects",
		},
		["<leader>fT"] = {
			"<cmd>TodoTelescope<cr>",
			desc = "Find TODOs",
		},

		-- octo plugin mappings
		["<leader>G"] = {
			name = " GitHub",
		},
		["<leader>Gi"] = {
			"<cmd>Octo issue list<cr>",
			desc = "Open Issues",
		},
		["<leader>GI"] = {
			"<cmd>Octo issue search<cr>",
			desc = "Search Issues",
		},
		["<leader>Gp"] = {
			"<cmd>Octo pr list<cr>",
			desc = "Open PRs",
		},
		["<leader>GP"] = {
			"<cmd>Octo pr search<cr>",
			desc = "Search PRs",
		},
		["<leader>Gr"] = {
			"<cmd>Octo repo list<cr>",
			desc = "Open Repository",
		},

		-- gopher
		["<leader>Gi"] = { "<cmd>GoInstallDeps<Cr>" },
		["<leader>Gf"] = { "<cmd>GoMod tidy<cr>" },
		["<leader>Ga"] = { "<cmd>GoTestAdd<Cr>" },
		["<leader>GA"] = { "<cmd>GoTestsAll<Cr>" },
		["<leader>Ge"] = { "<cmd>GoTestsExp<Cr>" },
		["<leader>Gg"] = { "<cmd>GoGenerate<Cr>" },
		["<leader>GG"] = { "<cmd>GoGenerate %<Cr>" },
		["<leader>Gc"] = { "<cmd>GoCmt<Cr>" },
		-- ["<leader>Gt"] = { "<cmd>lua require('dap-go').debug_test()<cr>"},

		-- rust
		["<leader>Rr"] = { "<cmd>RustRunnables<Cr>" },
		["<leader>Rt"] = { "<cmd>lua _CARGO_TEST()<cr>" },
		["<leader>Rm"] = { "<cmd>RustExpandMacro<Cr>" },
		["<leader>Rc"] = { "<cmd>RustOpenCargo<Cr>" },
		["<leader>RD"] = { "<cmd>RustOpenExternalDocs<Cr>" },
		["<leader>Rp"] = { "<cmd>RustParentModule<Cr>" },
		["<leader>Rd"] = { "<cmd>RustDebuggables<Cr>" },
		["<leader>Rv"] = { "<cmd>RustViewCrateGraph<Cr>" },
		["<leader>RR"] = { "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>" },
		["<leader>Ro"] = { "<cmd>RustOpenExternalDocs<Cr>" },

		["<leader>x"] = { desc = "�� Trouble" },
		["<leader>xx"] = {
			"<cmd>TroubleToggle document_diagnostics<cr>",
			desc = "Document Diagnostics (Trouble)",
		},
		["<leader>xX"] = {
			"<cmd>TroubleToggle workspace_diagnostics<cr>",
			desc = "Workspace Diagnostics (Trouble)",
		},
		["<leader>xl"] = {
			"<cmd>TroubleToggle loclist<cr>",
			desc = "Location List (Trouble)",
		},
		["<leader>xq"] = {
			"<cmd>TroubleToggle quickfix<cr>",
			desc = "Quickfix List (Trouble)",
		},
		["<leader>xT"] = {
			"<cmd>TodoTrouble<cr>",
			desc = "TODOs (Trouble)",
		},
	},
	i = {
		-- type template string
		["<C-CR>"] = {
			"<++>",
			desc = "Insert template string",
		},
		["<S-Tab>"] = {
			"<C-V><Tab>",
			desc = "Tab character",
		},
		-- date/time input
		["<c-t>"] = {
			desc = "󰃰 Date/Time",
		},
		["<c-t>n"] = {
			"<c-r>=strftime('%Y-%m-%d')<cr>",
			desc = "Y-m-d",
		},
		["<c-t>x"] = {
			"<c-r>=strftime('%m/%d/%y')<cr>",
			desc = "m/d/y",
		},
		["<c-t>f"] = {
			"<c-r>=strftime('%B %d, %Y')<cr>",
			desc = "B d, Y",
		},
		["<c-t>X"] = {
			"<c-r>=strftime('%H:%M')<cr>",
			desc = "H:M",
		},
		["<c-t>F"] = {
			"<c-r>=strftime('%H:%M:%S')<cr>",
			desc = "H:M:S",
		},
		["<c-t>d"] = {
			"<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>",
			desc = "Y/m/d H:M:S -",
		},
	},
	t = {
		-- setting a mapping to false will disable it
		-- ["<esc>"] = false,
	},
	x = {
		-- better increment/decrement
		["+"] = {
			"g<C-a>",
			desc = "Increment number",
		},
		["-"] = {
			"g<C-x>",
			desc = "Descrement number",
		},
		-- line text-objects
		["il"] = {
			"g_o^",
			desc = "Inside line text object",
		},
		["al"] = {
			"$o^",
			desc = "Around line text object",
		},
		-- Easy-Align
		ga = {
			"<Plug>(EasyAlign)",
			desc = "Easy Align",
		},
		-- vim-sandwich
		["s"] = "<Nop>",
	},
	o = {
		-- line text-objects
		["il"] = {
			":normal vil<cr>",
			desc = "Inside line text object",
		},
		["al"] = {
			":normal val<cr>",
			desc = "Around line text object",
		},
	},
}

-- add more text objects for "in" and "around"
for _, char in ipairs({ "_", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" }) do
	for _, mode in ipairs({ "x", "o" }) do
		mappings[mode]["i" .. char] = {
			string.format(":<C-u>silent! normal! f%sF%slvt%s<CR>", char, char, char),
			desc = "between " .. char,
		}
		mappings[mode]["a" .. char] = {
			string.format(":<C-u>silent! normal! f%sF%svf%s<CR>", char, char, char),
			desc = "around " .. char,
		}
	end
end

return mappings
