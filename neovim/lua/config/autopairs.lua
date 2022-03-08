local M = {}

function M.setup()
  local npairs = require "nvim-autopairs"
  npairs.setup {
    check_ts = true,
    disable_filetype = { "TelescopePrompt", "vim" },
  }
  npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")
end

return M
