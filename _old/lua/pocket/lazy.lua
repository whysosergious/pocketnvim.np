-- boostrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



local load_all = require('util.load_all')
local profile_plugins = load_all('plugins')
-- TODO: expose through global (pocketnvim)
local profile_config = load_all('config')

require('config.remap')

require("lazy").setup({
	{ import = "pocket.plugins" },
	{ import = "plugins" },
  -- profile_plugins,
	{ import = "pocket.config.lazy"}
})

