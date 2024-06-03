PV = {
    group = os.getenv('PV_GROUP'),
    rnt = os.getenv('PV_RNT'),
}                      

-- N. TODO: 
----- -- N. TODO: 
----- 




--- ##########
--- ########## -- SESSION TODO'S
--- ##########




-- 3. TODO: finish adapting packer cfg for lazy (navigator)
-------- some init code for lazy that is used in playground is cla


-- 4. TODO: changinh the poil --
----- autocommans fail on every  treesitter movement (bet it's thelsp &/dapcpmfog=

-- 5. TODO: colorscheme in  4 minues
-----  or go back to tokyo nich5vMONO





--- ##########


-- if (PV.group == nil) then


  -- PV.config = {
    -- state = 'idle',
    -- changes = {},
    -- subscribers = {},
    -- subscribe = function(subscriber)
      -- print(string.format('subscribed %q', #PV.config.subscribers))
      -- table.insert(PV.config.subscribers, subscriber)
    -- end,
    -- notify = function(changes)
      -- print 'notified'
      -- for _, subscriber in ipairs(PV.config.subscribers) do
        -- subscriber(changes)
      -- end
    -- end,
    -- changed = function(value)
      -- print('changed', value)
      -- table.insert(PV.config.changes, value)
      -- PV.config.notify(value)
    -- end,
  -- }
-- end

---- some mason installations complain for pwsh on win
-- vim.o.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
                                  
-- vim.opt.shell = 'pwsh'
-- vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
-- vim.opt.shellxquote = ''

vim.cmd [[
  set shell=~/.cargo/bin/nu
]]
vim.opt.shell = 'nu'
vim.opt.shellcmdflag = '-c'           
vim.opt.shellquote = ''
vim.opt.shellxquote = ''

require 'pocket.core'
require 'pocket.lazy'

vim.cmd [[                                                
  let g:VM_default_mappings = 0
  let g:VM_maps = {}
]]
