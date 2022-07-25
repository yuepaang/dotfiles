return {
  Lua = {
    type = {
      -- weakUnionCheck = true,
      -- weakNilCheck = true,
      -- castNumberToInteger = true,
    },
    format = {
      enable = false,
    },
    hint = {
      enable = true,
      arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
      await = true,
      paramName = "Disable", -- "All", "Literal", "Disable"
      paramType = false,
      semicolon = "Disable", -- "All", "SameLine", "Disable"
      setType = true,
    },
    runtime = {
      version = "LuaJIT",
      special = {
        reload = "require",
      },
    },
    diagnostics = {
      globals = {
        "vim",
        "use",
        "describe",
        "it",
        "assert",
        "before_each",
        "after_each",
        "packer_plugins",
      },
    },
    workspace = {
      library = {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.stdpath("config") .. "/lua"] = true,
        -- [vim.fn.datapath "config" .. "/lua"] = true,
      },
    },
    telemetry = {
      enable = false,
    },
    disable = {
      "lowercase-global",
      "undefined-global",
      "unused-local",
      "unused-function",
      "unused-vararg",
      "trailing-space",
    },
  },
}
