local a = vim.api
_G.a = a

function save_highlight_groups(name)
  local filename = "./saved/" .. name .. ".rstr"

  print(filename)
  print("saving highlight groups with name: " .. name)

  local hl_output = vim.api.nvim_exec("highlight", true)
  local file = io.open(filename, "w")
  if file then
    file:write(hl_output)
    file:close()
    print("Highlight groups saved to " .. filename)
  else
    print("Failed to open file: " .. filename)
  end
end

function save_active_settings(settings)
  local filename = "./__auto_saved_settings__.rstr"
  local file = io.open(filename, "w")

  print("saving active settings: " .. settings)

  if file then
    file:write(settings)
    file:close()
    print("Active settings saved to " .. filename)
  else
    print("Failed to open file: " .. filename)
  end
end

function do_save_active()
  local cs_name = vim.api.nvim_exec("colorscheme", true)

  print(cs_name)

  vim.cmd("colorscheme " .. cs_name)

  -- vim.cmd("colorscheme " .. cd_name)
  save_highlight_groups(cs_name)
  save_active_settings(cs_name)
end

_G.a = do_save_active
