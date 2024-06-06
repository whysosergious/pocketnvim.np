-- Function to start the Deno server
local function is_server_running()
  local result = vim.fn.system "http get -e -f http://127.0.0.1:32123 | get status"
  print("Result", result == 200)
  print("Result", result == "200")
  return result == 200
end
local function start_deno_server()
  -- if is_server_running() then
  --   print "Deno server is already running"
  --   return
  -- end

  local job_id = vim.fn.jobstart("nu -c 'source $nu.config-path ; source $nu.env-path ; z shelly ; np'", {
    on_stdout = function(_, data, _)
      if data then
        for _, line in ipairs(data) do
          print(line)
        end
      end
    end,
    -- on_stderr = function(_, data, _)
    --   if data then
    --     for _, line in ipairs(data) do
    --       vim.api.nvim_err_writeln(line)
    --     end
    --   end
    -- end,
    on_exit = function(_, code, _)
      print("Deno server exited with code", code)
    end,
  })

  if job_id <= 0 then
    vim.api.nvim_err_writeln "Failed to start Deno server"
  else
    print("Deno server started with job ID", job_id)
  end
end

-- Start the Deno server when Neovim starts
start_deno_server()

vim.cmd [[
  func! s:ForFS(msg)
    echomsg a:msg
  endfunc
    command! -nargs=1 FFS call s:ForFS(<f-args>)
  ]]

return {

  -- {
  --   "vim-denops/denops.vim",
  --
  --   dependencies = {
  --     "vim-denops/denops-shared-server.vim",
  --   },
  --   config = function()
  --     vim.cmd [[
  --       let g:denops_server_addr = '127.0.0.1:32123'
  --
  --
  --     ]]
  --   end,
  -- },
  -- { "whysosergious/pocket-rpc.vim" },
}
