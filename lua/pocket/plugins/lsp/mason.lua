return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import mason
    local mason = require "mason"

    -- import mason-lspconfig
    local mason_lspconfig = require "mason-lspconfig"

    local mason_tool_installer = require "mason-tool-installer"

    -- enable mason and configure icons
    mason.setup {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    }

    mason_lspconfig.setup {
      -- list of servers for mason to install
      ensure_installed = {

        "tsserver",
        "html",
        "cssls",
        "lua_ls",
        "rust_analyzer",
        "zls",
        -- "jqls", -- need a global go installation
      },
    }

    mason_tool_installer.setup {
      ensure_installed = {
        "oxlint", -- swc in rust
        "htmlhint", -- html linter
        "ts-standard", -- typescript linter
        -- "deno", -- deno runtime
        "codelldb",
        "ast-grep",
        "stylua", -- lua formatter

        "jq",
        "stylelint", -- css formatter
        -- "isort", -- python formatter
        -- "black", -- python formatter
        -- "pylint",
        -- "oxlint", -- javascript formatter
      },
    }
  end,
}
