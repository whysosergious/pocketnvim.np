_G.a = vim.ap

function SauseDis()
  local cmd = "source %"
  vim.api.nvim_exec2(cmd)
  print "file `souse'd`"

  -- if sub_cmd ~= nil then
  --   print("runnin' sub - " .. sub_cmd)
  --
  --   local last_cmd = a.nvim_get_namespace "souse"
  --
  --   last_cmd = sub_cmd
  --
  --   cmd = last_cmd
  -- end
end

function Sh()
  if _G.a == a then
    a.nvim_get "souse"
  end
  local last_cmd = a.nvim_get "souse"

  print "runnin"
  vim.api.nvim_exec2(last_cmd)
end

vim.api.nvim_create_user_command("Sause", "SauseDis", { nargs = 1 })
vim.api.nvim_set_keymap("n", "<A-'>", ":lua src_dis_buf()<cr>", { noremap = true, desc = "source current file" })
