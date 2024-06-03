return {
  {"ckipp01/stylua-nvim"},
  {"ckipp01/stylua-nvim", run = "cargo install stylua"},
    cmd = "stylua",
    args = { "--config-path", vim.fn.stdpath("config") .. "/stylua.toml", "--", vim.api.nvim_buf_get_name(0) },
    stdin = false,

config = function ()

  local lsp_config = require("lspconfig")
  lsp_config.sumneko_lua.setup({
    commands = {
      Format = {
        function()
          require("stylua-nvim").format_file()
        end,
      },
    }
  })
    require("lspconfig").sumneko_lua.setup({   
    cmd = { "lua-language-server" },
    on_attach = require("lsp").common_on_attach,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
        },
      },
    },
  })
  end
}
