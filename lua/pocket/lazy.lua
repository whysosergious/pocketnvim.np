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
    "mhartington/oceanic-next",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme OceanicNext]]

      vim.cmd [[
" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext


  syntax on
  let g:oceanic_next_terminal_bold = 1
  let g:oceanic_next_terminal_italic = 1
  colorscheme OceanicNext

" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE
]]
    end,
  },

  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --
  --   config = function()
  --     require("tokyonight").setup {
  --       style = "moon",
  --     }
  --     vim.cmd [[colorscheme tokyonight]]
  --   end,
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("rose-pine").setup {
  --       variant = "auto", -- auto, main, moon, or dawn
  --       dark_variant = "main", -- main, moon, or dawn
  --       dim_inactive_windows = false,
  --       extend_background_behind_borders = true,
  --
  --       enable = {
  --         terminal = true,
  --         legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
  --         migrations = true, -- Handle deprecated options automatically
  --       },
  --
  --       styles = {
  --         bold = true,
  --         italic = true,
  --         transparency = false,
  --       },
  --
  --       groups = {
  --         border = "muted",
  --         link = "iris",
  --         panel = "surface",
  --
  --         error = "love",
  --         hint = "iris",
  --         info = "foam",
  --         note = "pine",
  --         todo = "rose",
  --         warn = "gold",
  --
  --         git_add = "foam",
  --         git_change = "rose",
  --         git_delete = "love",
  --         git_dirty = "rose",
  --         git_ignore = "muted",
  --         git_merge = "iris",
  --         git_rename = "pine",
  --         git_stage = "iris",
  --         git_text = "rose",
  --         git_untracked = "subtle",
  --
  --         h1 = "iris",
  --         h2 = "foam",
  --         h3 = "rose",
  --         h4 = "gold",
  --         h5 = "pine",
  --         h6 = "foam",
  --       },
  --
  --       highlight_groups = {
  --         -- Comment = { fg = "foam" },
  --         -- VertSplit = { fg = "muted", bg = "muted" },
  --       },
  --
  --       before_highlight = function(group, highlight, palette)
  --         -- Disable all undercurls
  --         -- if highlight.undercurl then
  --         --     highlight.undercurl = false
  --         -- end
  --         --
  --         -- Change palette colour
  --         -- if highlight.fg == palette.pine then
  --         --     highlight.fg = palette.foam
  --         -- end
  --       end,
  -- }

  -- vim.cmd "colorscheme rose-pine-dawn"
  -- vim.cmd "colorscheme rose-pine"
  -- vim.cmd("colorscheme rose-pine-main")
  -- vim.cmd("colorscheme rose-pine-moon")
  -- vim.cmd("colorscheme rose-pine-dawn")
  -- end,
  -- },
}, {
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
})
