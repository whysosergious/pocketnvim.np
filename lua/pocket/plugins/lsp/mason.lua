return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    -- import mason
    local mason = require 'mason'

    -- import mason-lspconfig
    local mason_lspconfig = require 'mason-lspconfig'

    local mason_tool_installer = require 'mason-tool-installer'

    -- enable mason and configure icons
    mason.setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    mason_lspconfig.setup {
      -- list of servers for mason to install
      ensure_installed = {

        'tsserver',
        'html',
        'cssls',
        'lua_ls',
        -- "pyright",
        'rust_analyzer',
        'vuels',
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        'htmlhint', -- html linter
        'ts-standard', -- typescript linter
        'deno', -- deno runtime
        'codelldb',
        'prettier', -- prettier formatter
        'prettierd',
        'stylua', -- lua formatter

        'stylelint', -- css formatter
        -- "isort", -- python formatter
        -- "black", -- python formatter
        -- "pylint",
        'oxlint', -- javascript formatter
        'eslint_d',
      },
    }
  end,
}
