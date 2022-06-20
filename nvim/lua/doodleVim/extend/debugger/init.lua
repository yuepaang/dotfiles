local debugger = {}

debugger.load_debuggers = function(opts)
  require("doodleVim.utils.defer").load_immediately("nvim-dap")
  local dap = require("dap")
  for _, v in ipairs(opts) do
    local status_ok, d = pcall(require, "doodleVim.extend.debugger." .. v)
    if status_ok then
      dap.adapters[v] = d.adapters
      dap.configurations[v] = d.configurations
    end
  end
end

debugger.DapToggleBreakpoint = function()
  require("doodleVim.utils.defer").load_immediately("nvim-dap")
  vim.api.nvim_command("DapToggleBreakpoint")
end

return debugger
