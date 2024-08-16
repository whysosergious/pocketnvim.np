local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup("AutoCommands", { clear = true })

-- HIGHLIGHT YANKING TEXT
-- autocmd('TextYankPost', {
--   group = 'AutoCommands',
--   pattern = '*',
--   callback = function()
--     vim.highlight.on_yank { higroup = 'YankHighlight', timeout = 200 }
--   end,
-- })

local lines_ns = vim.api.nvim_create_namespace "diag_lines"
local hls = {
  "DiagnosticLineError",
  "DiagnosticLineWarn",
  "DiagnosticLineInfo",
  "DiagnosticLineHint",
}

local function update_highlights(_, _, ctx, _)
  local buf = ctx.bufnr or 0
  local diagnostics = vim.diagnostic.get(buf)

  vim.api.nvim_buf_clear_namespace(buf, lines_ns, 0, -1)

  for _, diagnostic in ipairs(diagnostics) do
    vim.api.nvim_buf_set_extmark(buf, lines_ns, diagnostic.lnum, 0, {
      hl_mode = "combine",
      hl_eol = true,
      hl_group = hls[diagnostic.severity],
      end_row = diagnostic.lnum + 1,
      priority = 4 - diagnostic.severity,
    })
  end
end

local default_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(...)
  default_handler(...)
  update_highlights(...)
end

-- vim.api.nvim_create_autocmd("DiagnosticChanged", {
--   callback = function(args)
--     update_highlights(args.buf, args.data.diagnostics)
--   end,
-- })

return group
