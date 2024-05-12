return {

  'nvim-treesitter/nvim-treesitter-refactor',
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {

    'windwp/nvim-ts-autotag',
    -- "nushell/tree-sitter-nu",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require 'nvim-treesitter.configs'

    -- configure treesitter
    treesitter.setup { -- enable syntax highlighting
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = true,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        'rust',
        'json',
        'javascript',
        'typescript',
        'tsx',
        'yaml',
        'html',
        'css',
        'prisma',
        'markdown',
        'markdown_inline',
        'svelte',
        'graphql',
        'bash',
        'lua',
        'vim',
        'dockerfile',
        'gitignore',
        'query',
        'vimdoc',
        'c',
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<TAB>',
          scope_incremental = '<C-space>',
          node_decremental = '<bs>',
        },
      },

      parsers = {
        nu = {
          install_info = {
            'LhKipp/nvim-nu',
            dependancies = { 'ftplugin/nu.lua' },
            require('nu').setup {
              use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
              all_cmd_names = [[help commands | get name | str join "\n"]],
            },
            -- optional entres:
            -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
          },
          filetype = 'nu', -- if filetype does not match the parser name
        },
      },
    }
  end,
}
