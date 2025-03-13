return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  config = function()
    require("which-key").setup {
  
    }
  end,d,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
    disable = { filetypes = { "TelescopePrompt" } },
  },
}
