local M = {}

M.unload_modules = function(mods)
  for mod in mods:gmatch '%S+' do
    print((mod or 'nil') .. (package.loaded[mod] or ''))
    package.loaded[mod] = nil
  end
end

M.reload_config = function()
  M.print_package_loaded()

  M.unload_modules 'which-key.nvim'
  -- telescope.nvim

  vim.cmd 'source ~/AppData/Local/nvim/lua/pocket/core/keymaps.lua'
  vim.cmd 'source ~/AppData/Local/nvim/lua/pocket/core/options.lua'
end

M.reload_plugins = function(plugins)
  M.unload_modules(plugins)

  vim.cmd 'LazyReload'
end

vim.keymap.set('n', '<leader>rr', function()
  M.reload_config()
end, { desc = 'reload config' })

M.print_package_loaded = function()
  local packages = ''
  for e, p in pairs(package.loaded) do
    if pcall(print, e, p) then
      local s = { 'return {' }
      if type(p) == 'table' then
        for i = 1, #(p or { { 1 } }) do
          s[#s + 1] = '{'
          for j = 1, #p[i] do
            s[#s + 1] = p[i][j]
            s[#s + 1] = ','
          end
          s[#s + 1] = '},'
        end
      else
        s[#s + 1] = string.format('-1 !tbl- %q', p)
      end
      s[#s + 1] = '}'
      local ss = table.concat(s)

      packages = packages .. '\n -2- pc' .. e .. ' ' .. ss
    else
      packages = packages .. '\n -3- !idx' .. 'err ' .. package.path
      -- print('err - ', package.path)
    end
  end
  pcall(PV.out_buf.write, packages)
end

-- if PV.out_buf == nil then
--   local buf = vim.api.nvim_create_buf(false, true)
--   local nr = echo
--   nvim_buf_get_number(buf)
--
--   PV.out_buf = {
--     self = buf,
--     nr = nr,
--   }
-- end

return M
