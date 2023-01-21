local M = {}

function M.setup()
  require("lspsaga").setup {
    symbol_in_winbar = {
      in_custom = false,
    },
  }
end

return M
