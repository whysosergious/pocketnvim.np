return {

  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
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
