return {
  "mfussenegger/nvim-lint",
  ft = { "yaml", "yaml.docker-compose", "dockerfile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      yaml = { "yamllint" },
      ["yaml.docker-compose"] = { "yamllint" },
      dockerfile = { "hadolint" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        for _, name in ipairs(lint.linters_by_ft[vim.bo.filetype] or {}) do
          if vim.fn.executable(name) == 1 then
            lint.try_lint(name)
          end
        end
      end,
    })
  end,
}
