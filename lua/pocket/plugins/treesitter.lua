return {

  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/nvim-treesitter-refactor",
    "windwp/nvim-ts-autotag",
    -- 'nushell/tree-sitter-nu',
  },
  config = function()
    require("nvim-treesitter.install").prefer_git = true
    -- import nvim-treesitter plugin
    local treesitter = require "nvim-treesitter.configs"

    -- configure treesitter
    treesitter.setup {
      ignore_install = {},
      sync_install = false,
      modules = {
        -- textobjects = require "nvim-treesitter-textobjects",
        -- context = require "nvim-treesitter-context",
        -- refactor = require "nvim-treesitter-refactor",
        -- autotag = require "nvim-ts-autotag",
      },
      TSConfig = {
        lua = {
          setup = function()
            require("nvim-treesitter.parsers").get_parser_configs().lua.used_by = "fennel"
          end,
        },
        typescript = {
          setup = function()
            require("nvim-treesitter.parsers").get_parser_configs().typescript.used_by = "javascript"
          end,
        },
      },
      auto_install = true,
      -- enable syntax highlighting
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
        "rust",
        "json",
        "jsonc",
        "javascript",
        "typescript",
        "toml",
        "tsx",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "gitignore",
        "query",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<S-ä>",
          node_incremental = "<S-ä>",
          node_decremental = "<S-_>",
          scope_incremental = "<S-ö>",
        },
      },

      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      },
      {
        parsers = {
          np = {
            install_info = {
              url = "./treesitter/custom_parsers/nushell/tree-sitter-nu",
              dependancies = { "ftplugin/nu.lua", "jose-elias-alvarez/null-ls.nvim", "LhKipp/nvim-nu" },
              require("nu").setup {
                use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
                all_cmd_names = [[help commands | get name | str join "\n"]],
              },
              -- optional entres:
              -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
            },
            filetype = "np", -- if filetype does not match the parser name
          },
        },
      },

      {
        parsers = {
          nu = {
            install_info = {
              url = "./treesitter/custom_parsers/nushell/tree-sitter-nu",
              dependancies = { "ftplugin/nu.lua", "jose-elias-alvarez/null-ls.nvim", "LhKipp/nvim-nu" },
              require("nu").setup {
                use_lsp_features = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
                all_cmd_names = [[help commands | get name | str join "\n"]],
              },
              -- optional entres:
              -- requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c§:
            },

            -- filetype = ["nu", "np"], -- if filetype does not match the parser name
            filetype = { "nu", "np" }, -- if filetype does not match the parser name
          },
        },
      },
    }
  end,
}
