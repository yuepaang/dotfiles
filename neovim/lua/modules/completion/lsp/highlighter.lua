local M = {}

local function info(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local function warn(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

M.highlight = true

function M.toggle()
  M.highlight = not M.highlight
  if M.highlight then
    info("Enabled document highlight", "Document Highlight")
  else
    warn("Disabled document highlight", "Document Highlight")
  end
end

function M.highlight(client)
  if M.highlight then
    if client.resolved_capabilities.document_highlight then
      local present, illuminate = pcall(require, "illuminate")
      if present then
        illuminate.on_attach(client)
      else
        vim.api.nvim_exec(
          [[
            augroup lsp_document_highlight
              autocmd! * <buffer>
              autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
              autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
          ]],
          false
        )
      end
    end
  end
end

function M.setup(client)
  M.highlight(client)
end

return M
