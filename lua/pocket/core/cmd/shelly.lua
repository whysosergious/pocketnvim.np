Sh = {
  envee = os.getenv "SHELLY_ENVEE",
}

Sh.envee = "test value"

-- sause the focused buffer
vim.api.nvim_command "command! Sause :source %"

-- Define a command to source the init file
vim.api.nvim_command "command! SauseOnStart :source $MYVIMRC"

-- -- Auto-load the focused buffer and init file on start
-- vim.api.nvim_command "autocmd VimEnter * :Sause"
-- vim.api.nvim_command "autocmd VimEnter * :SauseOnStart"

vim.api.nvim_set_keymap("n", "<A-'>", ":Sause<cr>", { noremap = true, desc = "source current file" })

-- Define a command to run commands with Nushell
-- vim.api.nvim_command "command! -nargs=1 Sh lua os.execute('nu -c \"' .. <q-args> .. '\"')"
--
-- -- Map :sh to :Sh
-- vim.cmd [[
--   cnoreabbrev sh Sh
-- ]]

-- Function to create a floating window
local function create_floating_window()
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer
  local width = vim.o.columns
  local height = vim.o.lines
  local win_width = math.ceil(width * 0.4)
  local win_height = math.ceil(height * 0.5)
  local row = height - win_height - 2
  local col = width - win_width - 2

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "single",
  }

  local win = vim.api.nvim_open_win(buf, true, opts)
  return buf, win
end

-- Function to run a Nushell command and display the output in a floating window
local function run_nushell_command(cmd)
  local buf, win = create_floating_window()
  local handle = io.popen('nu -c "' .. cmd .. '"')
  local result = handle:read "*a"
  handle:close()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(result, "\n"))
end

-- Define a command to run Nushell commands and display the output in a floating window
vim.api.nvim_create_user_command("Sh", function(opts)
  run_nushell_command(opts.args)
end, { nargs = 1 })

-- Map :sh to :Sh
vim.cmd [[
  cnoreabbrev sh Sh
]]

-- Function to create an input window at the bottom
local function create_input_window()
  local buf = vim.api.nvim_create_buf(false, true) -- Create a new buffer
  local width = vim.o.columns
  local height = vim.o.lines
  local win_width = math.ceil(width * 0.4)
  local win_height = 3
  local row = height - win_height - 1
  local col = width - win_width - 2

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "single",
  }

  local win = vim.api.nvim_open_win(buf, true, opts)
  return buf, win
end

-- Function to handle input and run commands
local function handle_input()
  local buf, win = create_input_window()
  vim.api.nvim_buf_set_keymap(
    buf,
    "n",
    "<CR>",
    ':lua run_nushell_command(vim.fn.getline("."))<CR>',
    { noremap = true, silent = true }
  )
end

-- Define a command to open the input window
vim.api.nvim_create_user_command("ShInput", function()
  handle_input()
end, {})

-- Map :shi to :ShInput
vim.cmd [[
  cnoreabbrev shi ShInput
]]
