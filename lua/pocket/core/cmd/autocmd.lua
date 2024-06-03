local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local group = augroup('AutoCommands', { clear = true })

-- HIGHLIGHT YANKING TEXT
-- autocmd('TextYankPost', {
--   group = 'AutoCommands',
--   pattern = '*',
--   callback = function()
--     vim.highlight.on_yank { higroup = 'YankHighlight', timeout = 200 }
--   end,
-- })


return group
