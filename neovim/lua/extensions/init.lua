local extensions = {
	'coc-json',
	'coc-yaml',
	'coc-pairs',
	'coc-tabnine',
	'coc-snippets',
	'coc-pyright',
	'coc-go',
	'coc-rust-analyzer',
	'coc-vimlsp'
}

local function set_extensions()
	vim.g.coc_global_extensions = extensions
	vim.cmd [[command! ExtensionUpdate call coc#util#install_extension(g:coc_global_extensions)]]
end

set_extensions()
