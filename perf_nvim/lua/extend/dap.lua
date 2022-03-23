local debug = {}

debug.debug_toggle = function()
	require('utils.defer').load_immediately('nvim-dap')
	require'dap'.toggle_breakpoint()
end

debug.debug_continue = function()
	require('utils.defer').load_immediately({'nvim-dap', 'nvim-dap-ui'})
	require'dapui'.open()
	require'dap'.continue()
end

debug.debug_step_over = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.step_over()
end

debug.debug_step_into = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.step_into()
end

debug.debug_step_out = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.step_out()
end

debug.debug_set_cond_breakpoint = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end

debug.debug_repl_open = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.repl.open()
end

debug.debug_run_last = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.run_last()
end

debug.debug_pause = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.pause()
end

debug.debug_stop = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.disconnect()
	require'dap'.close()
	require'dapui'.close()
end

debug.debug_run_to_cursor = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.run_to_cursor()
end

debug.debug_restart = function()
	if not packer_plugins['nvim-dap'].loaded then
		vim.notify("`nvim-dap` not loaded", "warn")
		return
	end
	require'dap'.restart()
end

return debug
