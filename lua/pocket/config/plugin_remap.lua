-- #### PLUGIN REMAP


-- ## telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<C-p>f', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fw', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)


-- ## undotree
vim.keymap.set('n', '<leader>lc', vim.cmd.UndotreeToggle)


-- ## git : vim-fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
