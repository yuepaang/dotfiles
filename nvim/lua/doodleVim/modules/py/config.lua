local config = {}

function config.leap()
    local leap = require("leap")
    leap.set_default_keymaps()
end

return config
