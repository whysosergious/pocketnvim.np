vim.keymap.set('n', '<leader>rsi', function()
  local args = vim.fn.input 'args: '

  require('recipe').execute {
    cmd = 'npr shelly ' .. args,
    key = 'shelly_instance[master]',
    kind = 'term',
    restart = false,
    env = {
      SCOPE = 'World',
    },
  }
end, { desc = '[np quick cmd] - start an instance of shelly' })
