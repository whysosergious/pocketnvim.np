return {
  'Mofiqul/dracula.nvim',
  priority = 1000,
  config = function()
    require('dracula').setup {
      italic_comment = true,
      show_end_of_buffer = true,
      overrides = {},
      transparent_bg = true,
      colors = {
        --   bg = 'none',
      },
    }
    vim.cmd [[
        colorscheme dracula
      ]]
  end,
}
