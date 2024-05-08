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
            url = 'C:/!work/!active/wss/treesitter/parsers/nu', -- local path or git repo
            files = { 'src/parser.c' }, -- note that some parsers also require src/scanner.c or src/scanner.cc
            -- optional entries:
            generate_requires_npm = false, -- if stand-alone parser without npm dependencies
            requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
          },
          filetype = 'nu', -- if filetype does not match the parser name
        },
      },
    }
  end,
}
