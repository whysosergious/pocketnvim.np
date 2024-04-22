-- temp
vim.g.mapleader = " "

-- vim.o.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
-- vim.o.shell = vim.fn.executable('nu') and 'nu' or 'nushell.exe'

-- vim.opt.shell = 'pwsh'
-- vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
-- vim.opt.shellxquote = ''

vim.opt.shell = 'nu'
vim.opt.shellcmdflag = '-c'
vim.opt.shellxquote = ""















require("pocket.core.options")
require("pocket.core.keymaps")



vim.cmd([[:set autoindent smartindent]])




