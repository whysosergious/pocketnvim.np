return {
  'nvim-lua/plenary.nvim', -- lua functions that many plugins use

  -- comment
  {
    'numToStr/Comment.nvim',
    -- keys = {
    --   { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
    --   { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    -- },
    opts = function()
      local commentstring_avail, commentstring = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
      return commentstring_avail and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
    end,
    -- config = function()
    --   require('Comment').setup()
    --   vim.keys.n['<leader>/'] = {
    --     function()
    --       require('Comment.api').toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
    --     end,
    --     desc = 'Toggle comment line',
    --   }
    --   vim.keys.v['<leader>/'] = {
    --     "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    --     desc = 'Toggle comment for selection',
    --   }
    -- end,
  },
  -- open terminal inside nvim instance
  {
    'akinsho/toggleterm.nvim',
    cmd = { 'ToggleTerm', 'TermExec' },
    keys = {
      { '<leader>ot', mode = { 'n' }, desc = 'Toggle terminal' },
    },
    opts = {
      highlights = {
        Normal = { link = 'Normal' },
        NormalNC = { link = 'NormalNC' },
        NormalFloat = { link = 'NormalFloat' },
        FloatBorder = { link = 'FloatBorder' },
        StatusLine = { link = 'StatusLine' },
        StatusLineNC = { link = 'StatusLineNC' },
        WinBar = { link = 'WinBar' },
        WinBarNC = { link = 'WinBarNC' },
      },
      size = 10,
      on_create = function()
        vim.opt.foldcolumn = '0'
        vim.opt.signcolumn = 'no'
      end,
      open_mapping = [[<F7>]],
      shading_factor = 2,
      direction = 'float',
      float_opts = { border = 'rounded' },
    },
  },
}
