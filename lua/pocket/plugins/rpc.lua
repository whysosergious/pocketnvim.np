return {
  {
    "vim-denops/denops.vim",

    dependencies = {
      "vim-denops/denops-shared-server.vim",
    },
    config = function()
      vim.cmd [[
        let g:denops_server_addr = '127.0.0.1:32123'


      ]]
    end,
  },
  { "whysosergious/pocket-rpc.vim" },
}
