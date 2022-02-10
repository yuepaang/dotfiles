local tree = {}

tree.toggle = function()
	if (not packer_plugins['barbar.nvim'].loaded) or (not packer_plugins['nvim-tree.lua'].loaded) then
		vim.cmd [[PackerLoad barbar.nvim]]
		vim.cmd [[PackerLoad nvim-tree.lua]]
	end

	local view = require'nvim-tree.view'
	if view.win_open() then
	  require'nvim-tree.view'.close()
	  -- view.close()
	  require'bufferline.state'.set_offset(0)
	else
	  require'bufferline.state'.set_offset(31, 'File Explorer')
	  require'nvim-tree'.find_file(true)
	end
end

return tree
