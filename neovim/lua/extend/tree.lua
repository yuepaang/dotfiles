local tree = {}

tree.toggle = function()
	if (not packer_plugins['barbar.nvim'].loaded) or (not packer_plugins['nvim-tree.lua'].loaded) then
		vim.cmd [[PackerLoad barbar.nvim]]
		vim.cmd [[PackerLoad nvim-tree.lua]]
	end

	local ntree = require'nvim-tree'
	local view = require'nvim-tree.view'
	local lib = require'nvim-tree.lib'

	if view.win_open() then
		require'bufferline.state'.set_offset(0)
		view.close()
	else
		if vim.g.nvim_tree_follow == 1 then
			require'bufferline.state'.set_offset(31, 'File Explorer')
			ntree.find_files(true)
		end
		if not view.win_open() then
			require'bufferline.state'.set_offset(31, 'File Explorer')
			lib.open()
		end
	end
end

return tree
