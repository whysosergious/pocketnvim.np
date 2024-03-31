return {
  -- the colorscheme should be available when starting Neovim
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    
    config = function()
      

      

      
            require("tokyonight").setup({
        style = "moon",
        -- transparent = true,
        sidebars = {"qf", "vista_kind", "terminal", "packer", "Mason", "Lazy", "Telescope"},
        dim_inactive = true,
        lualine_bold = true,

        on_highlights = function(hl, c)
    local prompt = "#2d3149"
    local border = "#382938"
    hl.TelescopeNormal = {                                  -- ' <<<<---- this worked
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = border,
      fg = border,
    }
    hl.TelescopePromptNormal = {
      bg = border,
    }
    hl.TelescopePromptBorder = {
      bg = border,
      fg = border,
    }
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
    -- }
  end,
      })

      -- load the colorscheme
    vim.cmd([[colorscheme tokyonight]])


-- TODO: move to user config
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })



-- vim.api.nvim_exec([[                               -- ' <<<<---- this did not
--   augroup WindowFocus
--     autocmd!
-- autocmd WinEnter * vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--     autocmd WinLeave *  hi Normal guibg=#2c1e2a
--   augroup END
-- ]], false)
      
    end,
    
  },

  -- I have a separate config.mappings file where I require which-key.
  -- With lazy the plugin will be automatically loaded when it is required somewhere
  { "folke/which-key.nvim", lazy = true },

  {
    "nvim-neorg/neorg",
    -- lazy-load on filetype
    ft = "norg",
    -- options for neorg. This will automatically call `require("neorg").setup(opts)`
    opts = {
      load = {
        ["core.defaults"] = {},
      },
    },
  },

  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      -- ...
    end,
  },

  -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- So for api plugins like devicons, we can always set lazy=true
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- you can use the VeryLazy event for things that can
  -- load later and are not important for the initial UI
  { "stevearc/dressing.nvim", event = "VeryLazy" },

  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "monaqa/dial.nvim",
    -- lazy-load on keys
    -- mode is `n` by default. For more advanced options, check the section on key mappings
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },

  -- local plugins need to be explicitly configured with dir
  { dir = "~/projects/secret.nvim" },

  -- you can use a custom url to fetch a plugin
  { url = "git@github.com:folke/noice.nvim.git" },

  -- local plugins can also be configure with the dev option.
  -- This will use {config.dev.path}/noice.nvim/ instead of fetching it from Github
  -- With the dev option, you can easily switch between the local and installed version of a plugin
  { "folke/noice.nvim", dev = true },
  {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                              , branch = '0.1.x',
	  dependencies = { 'nvim-lua/plenary.nvim' }
  },
}


