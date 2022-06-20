local config = {}

function config.dapui()
  require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    expand_lines = vim.fn.has("nvim-0.7"),
    layouts = {
      {
        elements = {
          -- Elements can be strings or table with id and size keys.
          { id = "scopes", size = 0.25 },
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 40,
        position = "left",
      },
      {
        elements = {
          "repl",
          "console",
        },
        size = 10,
        position = "bottom",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "rounded", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil, -- Can be integer or nil.
    },
  })

  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
  -- for some debug adapter, terminate or exit events will no fire, use disconnect reuest instead
  dap.listeners.before.disconnect["dapui_config"] = function()
    dapui.close()
  end
end

function config.dap()
  require("doodleVim.extend.debugger").load_debuggers({
    "go",
    "python",
  })
  vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "GruvboxRed", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "GruvboxRed", linehl = "", numhl = "" })
  vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "GruvboxRed", linehl = "", numhl = "" })
  vim.fn.sign_define("DapLogPoint", { text = "ﯽ", texthl = "GruvboxYellow", linehl = "", numhl = "" })
  vim.fn.sign_define("DapStopped", { text = "ﭥ", texthl = "GruvboxYellow", linehl = "", numhl = "" })
end

return config
