return {
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'

      require('dapui').setup()
      require('nvim-dap-virtual-text').setup()
    end,
  },

  -- {
  --   'rcarriga/nvim-dap-ui',
  --   dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  --   config = function()
  --     require('neodev').setup()
  --     -- {
  --     --   library = { plugins = { 'nvim-dap-ui' }, types = true },
  --     --   -- config
  --     -- }
  --   end,
  -- },
  -- {
  --   'theHamsta/nvim-dap-virtual-text',
  --   depends = { 'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter' },
  --   config = function()
  --     local dap_vt = require('nvim-dap-virtual-text').setup()
  --   end,
  -- },
}
