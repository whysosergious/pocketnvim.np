-- Lua
return {
  'olimorris/persisted.nvim',
  lazy = false, -- make sure the plugin is always loaded at startup
  config = function()
    require('persisted').setup({
      save_dir = vim.fn.expand(vim.fn.stdpath('data') .. '/sessions/'), -- Directory where sessions will be saved
  command = 'VimLeavePre', -- Event to trigger session saving
  autoload = true, -- Automatically load the session for the current directory
  autosave = true, -- Automatically save the session on VimLeavePre
  use_git_branch = true, -- Use the git branch name in the session file name
  follow_cwd = true, -- Change the session file name when changing directories

    })
    require('telescope').load_extension 'persisted'

    vim.keymap.set('n', '<leader>fp', function()
      require('telescope').persisted()
    end, { desc = 'Persisted thing' })
  end,
}  



-- :SessionToggle - Determines whether to load, start or stop a session
-- :SessionStart - Start recording a session. Useful if autosave = false
-- :SessionStop - Stop recording a session
-- :SessionSave - Save the current session
-- :SessionLoad - Load the session for the current directory and current branch (if git_use_branch = true)
-- :SessionLoadLast - Load the most recent session
-- :SessionLoadFromFile - Load a session from a given path
-- :SessionDelete - Delete the current session
