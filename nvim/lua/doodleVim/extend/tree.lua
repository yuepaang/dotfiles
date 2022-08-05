local tree = {}

tree.toggle = function()
  require("doodleVim.utils.defer").immediate_load({ "barbar.nvim", "nvim-tree.lua" })
  local api = require("nvim-tree.api")
  api.tree.toggle()
end

return tree
