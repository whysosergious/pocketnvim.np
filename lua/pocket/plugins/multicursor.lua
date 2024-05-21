return {
  'mg979/vim-visual-multi',
  -- lazy = true,

  -- config = function()
  --   ---- some mason installations complain for pwsh on win
  --
  --   vim.cmd 'let g:VM_default_mappings = 0'
  --   vim.g.VM_maps = {}
  --   vim.g.VM_maps = {
  --     ['Find Under'] = '<M-d>', -- replace C-n
  --     ['Find Subword Under'] = '<C-d>', -- replace visual C-n
  --     ['Select Cursor Down'] = '<M-C-Down>', -- start selecting down
  --     ['Select Cursor Up'] = '<M-C-Up>', -- start selecting up
  --   }
  --   -- require('vim-visual-multi').setup {
  --   --   keymaps = {
  --   --     visual = '<M-C-n>',
  --   --   },
  --   -- }
  -- end,
  -- 'smoka7/multicursors.nvim',
  -- event = 'VeryLazy',
  -- dependencies = {
  --   'smoka7/hydra.nvim',
  -- },
  -- opts = {},
  -- cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
  --
  -- keys = {
  --
  --   {
  --     mode = { 'v', 'n' },
  --     '<Leader>m',
  --     '<cmd>MCstart<cr>',
  --     desc = 'Multicursor - Create a selection for selected text or word under the cursor',
  --   },
  -- },
}
