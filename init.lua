local opt = vim.opt
opt.shell = 'nu.exe'
opt.shellxquote = ''
opt.shellquote = '"'
opt.shellcmdflag = 'exec'


-- bootstrap pocket
-- TODO: do the whole git thing (ex in laze.lua) 
require("pocket")
