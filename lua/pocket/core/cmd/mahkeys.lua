function open_floating_window()
  -- Get the editor's maximum width and height
  local width = vim.api.nvim_get_option 'columns'
  local height = vim.api.nvim_get_option 'lines'

  -- Calculate the width and height of the new floating window
  local win_width = math.ceil(width * 0.8)
  local win_height = math.ceil(height * 0.8)

  -- Calculate the position of the new floating window
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  -- Create a new buffer for the floating window
  local buf = vim.api.nvim_create_buf(false, true)

  -- Set the buffer's options
  vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = 'minimal',
  })

  -- Return the buffer and window handles
  return buf, win
end
