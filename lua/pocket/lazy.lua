local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "pocket.plugins" },
  { import = "pocket.plugins.lsp" },
  { import = "pocket.plugins.lsp.servers" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,

    config = function()
      require("tokyonight").setup {
        style = "moon",
      }
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
}, {
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
})
