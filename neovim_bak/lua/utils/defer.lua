local handler = {}

local defer_packages = {}

function handler.add(plugin, priority)
	local p = {
		priority = priority,
		plugin = plugin,
	}
	table.insert(defer_packages, p)
end

local do_load = function()
	table.sort(defer_packages, function(a, b) return a.priority > b.priority end)
	for _, item in pairs(defer_packages) do
		require("packer").loader(item.plugin)
	end
end

function handler.load(delay)
	vim.defer_fn(do_load, delay)
end

function handler.packer_defer_load(plugin, timer)
	if plugin then
		timer = timer or 0
		vim.defer_fn(function()
			require("packer").loader(plugin)
		end, timer)
	end
end

return handler
