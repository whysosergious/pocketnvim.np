vim.keymap.set(
  'n',
  '<leader>he',
  '<cmd>nu -c "rm -rf ~/AppData/Local/nvim-data/shada<CR>"',
  { desc = '[handle error by name (or high explosive)] - {shada: remove the shada folder in nvim-data dir}' }
)
