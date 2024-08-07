return {
  "smoka7/hop.nvim",
  version = "*",
  opts = {
    keys = "etovxqpdygfblzhckisuran",
  },
  setup = function()
    require("hop").setup()

    -- place this in one of your configuration file(s)
    local directions = require("hop.hint").HintDirection
    vim.keymap.set("", "f", function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true }
    end, { remap = true })
    vim.keymap.set("", "F", function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true }
    end, { remap = true })
    vim.keymap.set("", "t", function()
      hop.hint_char1 { direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }
    end, { remap = true })
    vim.keymap.set("", "T", function()
      hop.hint_char1 { direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }
    end, { remap = true })
  end,
}

--
-- local M = {}
-- M.opts = {}
--
-- M.hint_nodes = function(opts)
--   local hop = require('hop')
--
--   opts = setmetatable(opts or {}, { __index = M.opts })
--   hop.hint_with(require('hop-treesitter.treesitter').nodes(), opts)
-- end
--
-- function M.register(opts)
--   M.opts = opts
--   vim.api.nvim_create_user_command('HopNodes', function()
--     M.hint_nodes({})
--   end, {})
-- end
--
-- return M
-- if vim.version.lt(vim.version(), { 0, 9, 0 }) then
--   vim.notify('This plugin only works with Neovim >= v0.9.0', vim.log.levels.ERROR)
--   return
-- end
--
-- local user_command = vim.api.nvim_create_user_command
-- local hop = require('hop')
-- local direction = require('hop.hint').HintDirection
--
-- local opts = {}
-- local commands = {
--   HopChar1 = hop.hint_char1,
--   HopChar2 = hop.hint_char2,
--   HopWord = hop.hint_words,
--   HopPattern = hop.hint_patterns,
--   HopAnywhere = hop.hint_anywhere,
--   HopCamelCase = hop.hint_camel_case,
-- }
--
-- for label, hint in pairs(commands) do
--   user_command(label, hint, opts)
--
--   user_command(label .. 'BC', function()
--     hint({ direction = direction.BEFORE_CURSOR })
--   end, opts)
--
--   user_command(label .. 'AC', function()
--     hint({ direction = direction.AFTER_CURSOR })
--   end, opts)
--
--   user_command(label .. 'CurrentLine', function()
--     hint({ current_line_only = true })
--   end, opts)
--
--   user_command(label .. 'CurrentLineBC', function()
--     hint({ direction = direction.BEFORE_CURSOR, current_line_only = true })
--   end, opts)
--
--   user_command(label .. 'CurrentLineAC', function()
--     hint({ direction = direction.AFTER_CURSOR, current_line_only = true })
--   end, opts)
--
--   user_command(label .. 'MW', function()
--     hint({ multi_windows = true })
--   end, opts)
-- end
--
-- local lineCommands = {
--   HopLine = hop.hint_lines,
--   HopVertical = hop.hint_vertical,
--   HopLineStart = hop.hint_lines_skip_whitespace,
-- }
--
-- for label, hint in pairs(lineCommands) do
--   user_command(label, hint, opts)
--
--   user_command(label .. 'BC', function()
--     hint({ direction = direction.BEFORE_CURSOR })
--   end, opts)
--
--   user_command(label .. 'AC', function()
--     hint({ direction = direction.AFTER_CURSOR })
--   end, opts)
--
--   user_command(label .. 'MW', function()
--     hint({ multi_windows = true })
--   end, opts)
-- end
