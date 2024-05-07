return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      require('dap').adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          -- 💀 Make sure to update this path to point to your installation
          args = { '../util/js-debug/src/dapDebugServer.js', '${port}' },
        },
      }

      dap.configurations.typescript = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          runtimeExecutable = 'deno',
          runtimeArgs = {
            'run',
            '--inspect-wait',
            '--allow-all',
          },
          program = '${file}',
          cwd = '${workspaceFolder}',
          attachSimplePort = 9229,
        },
      }
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
  {
    'theHamsta/nvim-dap-virtual-text',
    depends = { 'mfussenegger/nvim-dap', 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local dap_vt = require('nvim-dap-virtual-text').setup()
    end,
  },
}
