vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness


-- pf for 'peruse files' .. le horrible
keymap.set("n", "<leader>pf", vim.cmd.Ex)



keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab






keymap.set("n", "§", "$")
keymap.set("v", "§", "$")
keymap.set('n', '<A-h>', 'H')
keymap.set('n', '<A-j>', '<C-d>')
keymap.set('n', '<A-k>', '<C-u>')
keymap.set('n', '<A-l>', 'L')
keymap.set('n', '<A-i>', 'M')
keymap.set('v', '<c-v>', 'c-v>')
keymap.set('n', '<A-v>', '<C-v>')
keymap.set('v', '<A-v>', '<C-v>')



keymap.set('n', '<leader>it', vim.cmd.InspectTree, { desc = "Tree-Sitter - open syntax tree" })

-- ## undotree
keymap.set('n', '<leader>lc', vim.cmd.UndotreeToggle)
keymap.set('n', '<leader>cco', function()
  require("CopilotChat").open({
    selection = require("CopilotChat.select").buffer,  
  })
end,
  { desc = "CopilotChat - open chat -> ctx: buffer" }
  )
  keymap.set('n', '<leader>ccq', 
    function()
      local input = vim.fn.input("Quick Chat: ")
      if input ~= "" then
        require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
      end
    end,
    {  desc = "CopilotChat - Quick chat",
  }
)



-- -- ## telescope
-- local builtin = require('telescope.builtin')
-- keymap.set('n', '<leader>ff', builtin.find_files, {})
-- keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- keymap.set('n', '<C-p>f', builtin.git_files, {})
-- keymap.set('n', '<leader>fb', builtin.buffers, {})
-- keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- keymap.set('n', '<leader>fw', function()
-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)




local M = {}




--- Register queued which-key mappings
function M.which_key_register()
  if M.which_key_queue then
    local wk_avail, wk = pcall(require, "which-key")
    if wk_avail then
      for mode, registration in pairs(M.which_key_queue) do
        wk.register(registration, { mode = mode })
      end
      M.which_key_queue = nil
    end
  end
end


--- Get an empty table of mappings with a key for each map mode
---@return table<string,table> # a table with entries for each map mode
function M.empty_map_table()
  local maps = {}
  for _, mode in ipairs { "", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t" } do
    maps[mode] = {}
  end
  if vim.fn.has "nvim-0.10.0" == 1 then
    for _, abbr_mode in ipairs { "ia", "ca", "!a" } do
      maps[abbr_mode] = {}
    end
  end
  return maps
end

--- Table based API for setting keybindings
---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? table A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
  -- iterate over the first keys for each mode
  base = base or {}
  for mode, maps in pairs(map_table) do
    -- iterate over each keybinding set in the current mode
    for keymap, options in pairs(maps) do
      -- build the options for the command accordingly
      if options then
        local cmd = options
        local keymap_opts = base
        if type(options) == "table" then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
          keymap_opts[1] = nil
        end
        if not cmd or keymap_opts.name then -- if which-key mapping, queue it
          if not keymap_opts.name then keymap_opts.name = keymap_opts.desc end
          if not M.which_key_queue then M.which_key_queue = {} end
          if not M.which_key_queue[mode] then M.which_key_queue[mode] = {} end
          M.which_key_queue[mode][keymap] = keymap_opts
        else -- if not which-key mapping, set it
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
  if package.loaded["which-key"] then M.which_key_register() end -- if which-key is loaded already, register
end





--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end


local maps = M.empty_map_table()

-- local icons = require("pocket.icons.nerd_font")

-- local sections = {
--   f = { desc = icons.Search .. "Find" },
--   p = { desc = icons.Package .. "Packages" },
--   l = { desc = icons.ActiveLSP .. "LSP" },
--   u = { desc = icons.Window .. "UI/UX" },
--   b = { desc = icons.Tab .. "Buffers" },
--   bs = { desc = icons.Sort .. "Sort Buffers" },
--   d = { desc = icons.Debugger .. "Debugger" },
--   g = { desc = icons.Git .. "Git" },
--   S = { desc = icons.Session .. "Session" },
--   t = { desc = icons.Terminal .. "Terminal" },
-- }


-- -- setting only 'yank' to use the '+' register .. if 'p' is crowded, use "+p
-- vim.cmd([[:nnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y']])
-- vim.cmd([[:nnoremap <expr> yy (v:register ==# '"' ? '"+' : '') . 'yy']])
-- vim.cmd([[:nnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y']])
-- vim.cmd([[:xnoremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y']])
-- vim.cmd([[:xnoremap <expr> Y (v:register ==# '"' ? '"+' : '') . 'Y']])



-- Navigate tabs
maps.n["öt"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
maps.n["ät"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }


-- -- -- ## git : vim-fugitive
-- -- keymap.set('n', '<leader>gs', vim.cmd.Git)


-- Normal --
-- Standard Operations
maps.n["j"] = { "v:count == 0 ? 'gj' : 'j'", expr = true, desc = "Move cursor down" }
maps.n["k"] = { "v:count == 0 ? 'gk' : 'k'", expr = true, desc = "Move cursor up" }
maps.n["<leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<leader>q"] = { "<cmd>confirm q<cr>", desc = "Quit" }
maps.n["<leader>Q"] = { "<cmd>confirm qall<cr>", desc = "Quit all" }
maps.n["<leader>n"] = { "<cmd>enew<cr>", desc = "New File" }
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-q>"] = { "<cmd>qa!<cr>", desc = "Force quit" }
maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }

-- -- Plugin Manager
-- maps.n["<leader>p"] = sections.p


-- Package Manager
if is_available "mason.nvim" then
  maps.n["<leader>pm"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
  maps.n["<leader>pM"] = { "<cmd>MasonUpdateAll<cr>", desc = "Mason Update" }
end

-- Stay in indent mode
maps.v["<S-Tab>"] = { "<gv", desc = "Unindent line" }
maps.v["<Tab>"] = { ">gv", desc = "Indent line" }




-- Comment
if is_available "Comment.nvim" then
  maps.n["<leader>/"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Toggle comment line",
  }
  maps.v["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    desc = "Toggle comment for selection",
  }
end




-- -- maps.n["<leader>ud"] = { ui.toggle_diagnostics, desc = "Toggle diagnostics" }
-- -- maps.n["<leader>ug"] = { ui.toggle_signcolumn, desc = "Toggle signcolumn" }
-- -- maps.n["<leader>ui"] = { ui.set_indent, desc = "Change indent setting" }
-- -- maps.n["<leader>ul"] = { ui.toggle_statusline, desc = "Toggle statusline" }
-- -- maps.n["<leader>uL"] = { ui.toggle_codelens, desc = "Toggle CodeLens" }
-- -- maps.n["<leader>un"] = { ui.change_number, desc = "Change line numbering" }
-- -- maps.n["<leader>uN"] = { ui.toggle_ui_notifications, desc = "Toggle Notifications" }
-- -- maps.n["<leader>up"] = { ui.toggle_paste, desc = "Toggle paste mode" }
-- -- maps.n["<leader>us"] = { ui.toggle_spell, desc = "Toggle spellcheck" }
-- -- maps.n["<leader>uS"] = { ui.toggle_conceal, desc = "Toggle conceal" }
-- -- maps.n["<leader>ut"] = { ui.toggle_tabline, desc = "Toggle tabline" }
-- -- maps.n["<leader>uu"] = { ui.toggle_url_match, desc = "Toggle URL highlight" }
-- -- maps.n["<leader>uw"] = { ui.toggle_wrap, desc = "Toggle wrap" }
-- -- maps.n["<leader>uy"] = { ui.toggle_syntax, desc = "Toggle syntax highlighting (buffer)" }
-- -- maps.n["<leader>uh"] = { ui.toggle_foldcolumn, desc = "Toggle foldcolumn" }
 

M.set_mappings(maps)



