-- temp
vim.g.mapleader = " "

-- vim.o.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
-- vim.o.shell = vim.fn.executable('nu') and 'nu' or 'nushell.exe'

-- vim.opt.shell = 'pwsh'
-- vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
-- vim.opt.shellxquote = ''

-- TODO: configure packer/package manager to init & install per auto
require("pocket.lazy")


-- load main remaps before anything else
require("pocket.remap")


-- load plugin specific mappings
require("pocket.config.plugin_remap")

-- load default options
require("pocket.options")


vim.cmd([[:set autoindent smartindent]])






require "telescope".setup {
  pickers = {
    colorscheme = {
      enable_preview = true
    }
  }
}




-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.nu = {
--   install_info = {
--     url = "C:/!work/!active/wss/treesitter/parsers/nu", -- local path or git repo
--     files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
--     -- optional entries:
--     generate_requires_npm = false, -- if stand-alone parser without npm dependencies
--     requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
--   },
--   filetype = "nu", -- if filetype does not match the parser name
-- }
--

