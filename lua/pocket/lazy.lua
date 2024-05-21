local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'pocket.plugins' },
  { import = 'pocket.plugins.lsp' },

  -- config
  {

    -- 'olimorris/onedarkpro.nvim',
    -- priority = 1000, -- Ensure it loads first

    -- somewhere in your config:
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
      require('tokyonight').setup {
        -- require('onedarkpro').setup {
        options = {
          cursorline = true, -- Use cursorline highlighting?
          transparency = true, -- Use a transparent background?
          terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
          lualine_transparency = true, -- Center bar transparency?
          highlight_inactive_windows = true, -- When the window is out of focus, change the normal background?
        },
        colors = {
          dark = { bg = '#15171C', inlay_hint = '#ff0000' },
        },
        style = 'moon',
        transparent = true,
        -- sidebars = {"qf", "vista_kind", "terminal", "packer", "Mason", "Lazy", "Telescope"},
        dim_inactive = true,
        lualine_bold = true,

        -- on_highlights = function(hl, c)
        -- local prompt = "#2d3149"
        -- local border = "#382938"
        -- hl.TelescopeNormal = {                                  -- ' <<<<---- this worked
        --   bg = c.bg_dark,
        --   fg = c.fg_dark,
        -- }
        -- hl.TelescopeBorder = {
        --   bg = border,
        --   fg = border,
        -- }
        -- hl.TelescopePromptNormal = {
        --   bg = border,
        -- }
        -- hl.TelescopePromptBorder = {
        --   bg = border,
        --   fg = border,
        -- }
        -- hl.TelescopePromptTitle = {

        --   bg = prompt,
        --   fg = prompt,
        -- }
        -- hl.TelescopePreviewTitle = {
        --   bg = c.bg_dark,
        --   fg = c.bg_dark,
        -- }
        -- hl.TelescopeResultsTitle = {
        --   bg = c.bg_dark,
        --   fg = c.bg_dark,
      }
      -- end,
      -- }

      -- load the colorscheme
      vim.cmd [[colorscheme tokyonight]]
      -- vim.cmd 'colorscheme onedark'

      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end,
  },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
