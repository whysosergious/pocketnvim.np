-- local cfg = require 'lazy.core.config'
-- local checker = require 'lazy.manage.checker'

local M = {}

M.write = function(payload)
  print('out_buf.write', payload, M.buf_nr, PV.out_buf.buf_nr)
  vim.api.nvim_buf_set_lines(M.buf_nr, 0, -1, false, { string.format('buf_nr %q', payload) })
end

M.reg_out_buf = function()
  M.buf_nr = vim.api.nvim_get_current_buf()
  PV.config.subscribe(M.write)
end

vim.keymap.set('n', '<leader>rb', function()
  M.reg_out_buf()
  M.write(M.buf_nr)
end, { desc = 'register out buf' })

vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('huh?what_memory?', { clear = true}),
  pattern = 'out_buf.lua',
  callback = function()
   print('kkk')
  end,
})


PV.out_buf = M

return M
