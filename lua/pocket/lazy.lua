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
  { 'echasnovski/mini.icons',
    version = '*',
    config = function()
      require('mini.icons').setup()
    end
  },
    "LhKipp/nvim-nu",
    config = function()
      require("nu").setup {
        use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvi
        lsp_feature = all_cmd_names, -- is the source for the cmd name completion.
        -- It can be
        --  * a string, which is evaluated by nushell and the returned list is the source for completions (requires plenary.nvim)
        --  * a list, which is the direct source for completions (e.G. all_cmd_names = {"echo", "to csv", ...})
        --  * a function, returning a list of strings and the return value is used as the source for completions
        all_cmd_names = [[help commands | get name | str join "\n"]],
      }
    end,
  },
  {
    "mhartington/oceanic-next",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd [[colorscheme OceanicNext]]
  
      vim.cmd [[
        " For Neovim 0.1.3 and 0.1.4
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  
        " Or if you have Neovim >= 0.1.5
        if (has("termguicolors"))
          set termguicolors
        endif
  
        " Theme
        syntax enable
        " colorscheme OceanicNext
  
  
        syntax on
        let g:oceanic_next_terminal_bold = 1
        let g:oceanic_next_terminal_italic = 1
        " colorscheme OceanicNext
  
        " hi CommentKeyword guifg="#fff666" ctermbg="#fff66a" 6

" hi Normal guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE
  
         hi Normal guibg=NONE ctermbg=NONE
         hi LineNr guibg=NONE ctermbg=NONE
         hi SignColumn guibg=NONE ctermbg=NONE
         hi EndOfBuffer guibg=NONE ctermbg=NONE
      ]]
    end,
  
  -- {
  --   "nyoom-engineering/oxocarbon.nvim",
  --   lazy = false,
  --   priority = 1000,
  
  
  
  
  --   vim.opt.background = "dark",
  --   vim.cmd colorscheme "oxocarbon",
  --   vim.api.nvim_set_hl(0, "Normal", { bg = "none" }),
  --   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }),
  --   config = function()
  --     require("oxocarbon").setup {
  --       theme = "dark", -- or "light" or "mirage"
  --       comments = "italic",
  --       keywords = "bold",
  --       functions = "italic",
  --       -- strings = "NONE",
  --       -- variables = "NONE",
  --               vim.cmd [[colorscheme oxocarbon]],
  --       -- vim.opt.termguicolors = true,
  
  --       -- fg = "#ff9900"
  --       -- })
  --       -- fg = "#ff9900"
  --       -- })
  --     }
  --     --[[ vim.cmd [[colorscheme oxocarbon]] ]]
  --   end,
  -- },
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
   
}, {
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
})
