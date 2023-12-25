-- temp
vim.g.mapleader = " "


-- TODO: configure packer/package manager to init & install per auto
require("pocket.lazy")


-- load main remaps before anything else
require("pocket.remap")


-- load plugin specific mappings
require("pocket.config.plugin_remap")

-- load default options
require("pocket.options")


vim.cmd([[:set autoindent smartindent]])
