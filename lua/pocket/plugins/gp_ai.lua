return {
  'Robitx/gp.nvim',
  config = function()
    -- Define the agent configuration
    local agents = {
      {
        name = 'Friday',
        chat = true,
        command = false,
        model = { model = 'gpt-4o', temperature = 0.1, top_p = 1 },
        system_prompt = 'you are a skilled programmer. Proficient in recursive logic and reactive structures. your task is to make the given code and or specification, to behave correctly and do what the user expects from it. you are mainly workin with typescript, deno, +web, rust, nushell as the main shell, wezterm terminal and nvim.\n\n',
      },
    }

    -- Define the configuration
    local config = {
      agents = agents,
      chat_dir = vim.fn.stdpath('data'):gsub('/$', '') .. '/gp/chats',
      chat_user_prefix = '->',
      chat_assistant_prefix = { ' - ', '[{{agent}}]' },
      chat_confirm_delete = true,
      chat_free_cursor = false,
      style_chat_finder_border = 'shadow',
      style_chat_finder_margin_bottom = 8,
      style_chat_finder_margin_left = 1,
      style_chat_finder_margin_right = 2,
      style_chat_finder_margin_top = 2,
      style_chat_finder_preview_ratio = 0.36,
      style_popup_border = 'rounded',
      style_popup_margin_bottom = 8,
      style_popup_margin_left = 1,
      style_popup_margin_right = 2,
      style_popup_margin_top = 2,
      style_popup_max_width = 160,
      command_prompt_prefix_template = '{{agent}}',
      command_auto_select_response = true,
      template_selection = 'I have the following from {{filename}}:\n\n```{{filetype}}\n{{file}}\n```\n\n{{command}}',
      template_rewrite = 'I have the following from {{filename}}:\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}\n\nRespond exclusively with the snippet that should replace the selection above.',
      template_append = 'I have the following from {{filename}}:\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}\n\nRespond exclusively with the snippet that should be appended after the selection above.',
      template_prepend = 'I have the following from {{filename}}:\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}\n\nRespond exclusively with the snippet that should be prepended before the selection above.',
      template_command = '{{command}}',
    }

    -- Function to append the focused buffer content to the system prompt
    local append_focused_buffer = function()
      local prompt = agents[1].system_prompt
        .. '\n\nFocused Content:\n'
        .. table.concat(vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false), '\n')

      return prompt
    end

    -- Define a command to open a new chat with the current buffer as context
    local BufferChatNew = function()
      local gp = require('gp')
      agents[1].system_prompt = append_focused_buffer()
      vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
    end

    -- Set up the plugin with the configuration
    local gp = require('gp')
    gp.BufferChatNew = BufferChatNew

    -- Define key mappings
    vim.api.nvim_set_keymap('n', '<leader>cn', ':lua require("gp").BufferChatNew()<CR>', { noremap = true, silent = true })

    gp.setup(config)
  end

}
-- -- local M = {}
-- --
-- -- local agents = {
-- --   {
-- --     name = 'Friday',
-- --     chat = true,
-- --     command = false,
-- --     -- string with model name or table with model name and parameters
-- --     model = { model = 'gpt-4o', temperature = 0.1, top_p = 1 },
-- --     -- system prompt (use this to specify the persona/role of the AI)
-- --     system_prompt = 'you are a skilled programmer. Proficient in recursive logic and reactive structures. your task is to make the given code and or specification, to behave correctly and do what the user expects from it. you are mainly workin with typescript, deno, +web, rust, nushell as the main shell, wezterm terminal and nvim.\n\n',
-- --   },
-- -- }
-- --
-- -- local new_session_opt = {
-- --   file_content = function()
-- --     vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false)
-- --   end,
-- --
-- --   template = 'I have the following code:' .. '\n\n```{{filetype}}\n{{file_content}}```\n\n',
-- -- }
-- --
-- -- local config = {
-- --   -- optional curl parameters (for proxy, etc.)
-- --   -- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
-- --   curl_params = {
-- --     '-H',
-- --     'OpenAI-Beta: assistants=v2',
-- --   },
-- --
-- --   agents = {
-- --     {
-- --       name = 'Friday',
-- --       chat = true,
-- --       command = false,
-- --       -- string with model name or table with model name and parameters
-- --       model = { model = 'gpt-4o', temperature = 0.1, top_p = 1 },
-- --       -- system prompt (use this to specify the persona/role of the AI)
-- --       system_prompt = 'you are a skilled programmer. Proficient in recursive logic and reactive structures. your task is to make the given code and or specification, to behave correctly and do what the user expects from it. you are mainly workin with typescript, deno, +web, rust, nushell as the main shell, wezterm terminal and nvim.\n\n',
-- --     },
-- --   },
--
-- -- directory for storing chat files
-- -- chat_dir = vim.fn.stdpath('data'):gsub('/$', '') .. '/gp/chats',
-- -- -- chat user prompt prefix
-- -- chat_user_prefix = '->',
-- -- -- chat assistant prompt prefix (static string or a table {static, template})
-- -- -- first string has to be static, second string can contain template {{agent}}
-- -- -- just a static string is legacy and the [{{agent}}] element is added automatically
-- -- -- if you really want just a static string, make it a table with one element { "🤖:" }
-- -- chat_assistant_prefix = { ' - ', '[{{agent}}]' },
-- -- -- chat topic generation prompt
-- -- -- chat_topic_gen_prompt = 'Summarize the topic of our conversation above'
-- -- --   .. ' in two or three words. Respond only with those words.',
-- -- -- chat_topic_model = agents[1],
-- --
-- -- -- -- explicitly confirm deletion of a chat file
-- -- chat_confirm_delete = true,
-- -- -- -- conceal model parameters in chat
-- -- -- chat_conceal_model_params = true,
-- -- -- local shortcuts bound to the chat buffer
-- -- -- (be careful to choose something which will work across specified modes)
-- -- chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<A-Enter>' },
-- -- chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>d' },
-- -- chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>s' },
-- -- chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>c' },
-- -- -- default search term when using :GpChatFinder
-- -- -- chat_finder_pattern = 'topic ',
-- -- -- -- if true, finished ChatResponder won't move the cursor to the end of the buffer
-- -- --
-- -- chat_free_cursor = false,
-- -- -- styling for chatfinder
-- -- -- border can be "single", "double", "rounded", "solid", "shadow", "none"
-- -- style_chat_finder_border = 'shadow',
-- -- -- margins are number of characters or lines
-- -- style_chat_finder_margin_bottom = 8,
-- -- style_chat_finder_margin_left = 1,
-- -- style_chat_finder_margin_right = 2,
-- -- style_chat_finder_margin_top = 2,
-- -- -- how wide should the preview be, number between 0.0 and 1.0
-- -- style_chat_finder_preview_ratio = 0.36,
-- --
-- -- -- styling for popup
-- -- -- border can be "single", "double", "rounded", "solid", "shadow", "none"
-- -- style_popup_border = 'rounded',
-- -- -- margins are number of characters or lines
-- -- style_popup_margin_bottom = 8,
-- -- style_popup_margin_left = 1,
-- -- style_popup_margin_right = 2,
-- -- style_popup_margin_top = 2,
-- -- style_popup_max_width = 160,
--
-- -- -- command config and templates bellow are used by commands like GpRewrite, GpEnew, etc.
-- -- -- command prompt prefix for asking user for input (supports {{agent}} template variable)
-- -- command_prompt_prefix_template = '{{agent}}',
-- -- -- auto select command response (easier chaining of commands)
-- -- -- if false it also frees up the buffer cursor for further editing elsewhere
-- -- command_auto_select_response = true,
--
-- -- -- templates
-- -- template_selection = 'I have the following from {{filename}}:'
-- --   .. '\n\n```{{filetype}}\n{{file}}\n```\n\n{{command}}',
-- -- template_rewrite = 'I have the following from {{filename}}:'
-- --   .. '\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}'
-- --   .. '\n\nRespond exclusively with the snippet that should replace the selection above.',
-- -- template_append = 'I have the following from {{filename}}:'
-- --   .. '\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}'
-- --   .. '\n\nRespond exclusively with the snippet that should be appended after the selection above.',
-- -- template_prepend = 'I have the following from {{filename}}:'
-- --   .. '\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}'
-- --   .. '\n\nRespond exclusively with the snippet that should be prepended before the selection above.',
-- -- template_command = '{{command}}',
--
-- -- example hook functions (see Extend functionality section in the README)
-- -- hooks = {
-- -- InspectPlugin = function(plugin, params)
-- --   local bufnr = vim.api.nvim_create_buf(false, true)
-- --   local copy = vim.deepcopy(plugin)
-- --   local key = copy.config.openai_api_key
-- --   copy.config.openai_api_key = key:sub(1, 3) .. string.rep('*', #key - 6) .. key:sub(-3)
-- --   local plugin_info = string.format('Plugin structure:\n%s', vim.inspect(copy))
-- --   local params_info = string.format('Command params:\n%s', vim.inspect(params))
-- --   local lines = vim.split(plugin_info .. '\n' .. params_info, '\n')
-- --   vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
-- --   vim.api.nvim_win_set_buf(0, bufnr)
-- -- end,
-- --
-- -- -- GpImplement rewrites the provided selection/range based on comments in it
-- -- Implement = function(gp, params)
-- --   local template = 'Having following from {{filename}}:\n\n'
-- --     .. '```{{filetype}}\n{{selection}}\n```\n\n'
-- --     .. 'Please rewrite this according to the contained instructions.'
-- --     .. '\n\nRespond exclusively with the snippet that should replace the selection above.'
-- --
-- --   local agent = gp.get_command_agent()
-- --   gp.info('Implementing selection with agent: ' .. agent.name)
-- --
-- --   gp.Prompt(
-- --     params,
-- --     gp.Target.rewrite,
-- --     nil, -- command will run directly without any prompting for user input
-- --     agent.model,
-- --     template,
-- --     agent.system_prompt
-- --   )
-- -- end,
--
-- -- your own functions can go here, see README for more examples like
-- -- :GpExplain, :GpUnitTests.., :GpTranslator etc.
--
-- -- -- example of making :%GpChatNew a dedicated command which
-- -- -- opens new chat with the entire current buffer as a context
-- -- BufferChatNew = function(gp, _)
-- -- 	-- call GpChatNew command in range mode on whole buffer
-- -- 	vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
-- -- end,
--
-- -- -- example of adding command which opens new chat dedicated for translation
-- -- Translator = function(gp, params)
-- -- 	local agent = gp.get_command_agent()
-- -- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
-- -- 	gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
-- -- end,
--
-- -- -- example of adding command which writes unit tests for the selected code
-- -- UnitTests = function(gp, params)
-- -- 	local template = "I have the following code from {{filename}}:\n\n"
-- -- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
-- -- 		.. "Please respond by writing table driven unit tests for the code above."
-- -- 	local agent = gp.get_command_agent()
-- -- 	gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
-- -- end,
--
-- -- -- example of adding command which explains the selected code
-- -- Explain = function(gp, params)
-- -- 	local template = "I have the following code from {{filename}}:\n\n"
-- -- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
-- -- 		.. "Please respond by explaining the code above."
-- -- 	local agent = gp.get_chat_agent()
-- -- 	gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
-- -- end,
-- -- },
-- -- }
--
-- --[[ config.agents = agents ]]
--
-- local config = require 'pocket.plugins.config.gp_ai'
--
-- local append_focused_buffer = function()
--   local prompt = agents[1].system_prompt
--     .. '\n\nFocused Content:\n'
--     .. table.concat(vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false))
--
--   print(agents[1].name)
--
--   return prompt
-- end
--
-- --------------------------------------------------------------------------------
-- -- Module structure
-- --------------------------------------------------------------------------------
--
-- local _H = {}
-- local M = {
--   _H = _H, -- helper functions
--   _Name = 'Gp', -- plugin name
--   _handles = {}, -- handles for running processes
--   _queries = {}, -- table of latest queries
--   _state = {}, -- table of state variables
--   _deprecated = {}, -- table of deprecated options
--   agents = {}, -- table of agents
--   image_agents = {}, -- table of image agents
--   cmd = {}, -- default command functions
--   config = {}, -- config variables
--   hooks = {}, -- user defined command functions
--   -- spinner = require 'gp.spinner', -- spinner module
-- }
-- -- vim.g.gp_helpers = {
-- --   append_focused_buffer = append_focused_buffer,
-- -- }
-- M.agents = config.agents
-- -- M.config = config
-- --
-- return {
--   'Robitx/gp.nvim',
--
--   config = function()
--     print(M.agents[1].name)
--
--     require('gp').setup(config)
--
--     -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
--     ---- VISUAL mode mappings
--     -- s, x, v modes are handled the same way by which_key
--     -- require('which-key').register({
--     --   -- ...
--     --   ['<C-g>'] = {
--     --     c = { ":<C-u>'<,'>GpChatNew<cr>", 'Visual Chat New' },
--     --     p = { ":<C-u>'<,'>GpChatPaste<cr>", 'Visual Chat Paste' },
--     --     t = { ":<C-u>'<,'>GpChatToggle<cr>", 'Visual Toggle Chat' },
--     --
--     --     ['<C-x>'] = { ":<C-u>'<,'>GpChatNew split<cr>", 'Visual Chat New split' },
--     --     ['<C-v>'] = { ":<C-u>'<,'>GpChatNew vsplit<cr>", 'Visual Chat New vsplit' },
--     --     ['<C-t>'] = { ":<C-u>'<,'>GpChatNew tabnew<cr>", 'Visual Chat New tabnew' },
--     --
--     --     r = { ":<C-u>'<,'>GpRewrite<cr>", 'Visual Rewrite' },
--     --     a = { ":<C-u>'<,'>GpAppend<cr>", 'Visual Append (after)' },
--     --     b = { ":<C-u>'<,'>GpPrepend<cr>", 'Visual Prepend (before)' },
--     --     i = { ":<C-u>'<,'>GpImplement<cr>", 'Implement selection' },
--     --
--     --     g = {
--     --       name = 'generate into new ..',
--     --       p = { ":<C-u>'<,'>GpPopup<cr>", 'Visual Popup' },
--     --       e = { ":<C-u>'<,'>GpEnew<cr>", 'Visual GpEnew' },
--     --       n = { ":<C-u>'<,'>GpNew<cr>", 'Visual GpNew' },
--     --       v = { ":<C-u>'<,'>GpVnew<cr>", 'Visual GpVnew' },
--     --       t = { ":<C-u>'<,'>GpTabnew<cr>", 'Visual GpTabnew' },
--     --     },
--     --
--     --     n = { '<cmd>GpNextAgent<cr>', 'Next Agent' },
--     --     s = { '<cmd>GpStop<cr>', 'GpStop' },
--     --     x = { ":<C-u>'<,'>GpContext<cr>", 'Visual GpContext' },
--     --
--     --     w = {
--     --       name = 'Whisper',
--     --       w = { ":<C-u>'<,'>GpWhisper<cr>", 'Whisper' },
--     --       r = { ":<C-u>'<,'>GpWhisperRewrite<cr>", 'Whisper Rewrite' },
--     --       a = { ":<C-u>'<,'>GpWhisperAppend<cr>", 'Whisper Append (after)' },
--     --       b = { ":<C-u>'<,'>GpWhisperPrepend<cr>", 'Whisper Prepend (before)' },
--     --       p = { ":<C-u>'<,'>GpWhisperPopup<cr>", 'Whisper Popup' },
--     --       e = { ":<C-u>'<,'>GpWhisperEnew<cr>", 'Whisper Enew' },
--     --       n = { ":<C-u>'<,'>GpWhisperNew<cr>", 'Whisper New' },
--     --       v = { ":<C-u>'<,'>GpWhisperVnew<cr>", 'Whisper Vnew' },
--     --       t = { ":<C-u>'<,'>GpWhisperTabnew<cr>", 'Whisper Tabnew' },
--     --     },
--     --   },
--     --   -- ...
--     -- }, {
--     --   mode = 'v', -- VISUAL mode
--     --   prefix = '',
--     --   buffer = nil,
--     --   silent = true,
--     --   noremap = true,
--     --   nowait = true,
--     -- })
--     --
--     -- NORMAL mode mappings
--     -- require('which-key').register({
--     --   -- ...
--     --   ['<C-g>'] = {
--     --     c = {
--     --       function()
--     --         -- vim.cmd '<cmd>GpChatNew<cr>'
--     --
--     --         agents[1].system_prompt = append_focused_buffer()
--     --
--     --         -- file_content = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false)
--     --         --
--     --         -- agents[1].system_prompt = agents[1].system_prompt .. new_session_opt.template
--     --         -- .. vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, -1, false)
--     --       end,
--     --
--     --       'New Chat',
--     --     },
--     --     t = { '<cmd>GpChatToggle<cr>', 'Toggle Chat' },
--     --     f = { '<cmd>GpChatFinder<cr>', 'Chat Finder' },
--     --
--     --     ['<C-x>'] = { '<cmd>GpChatNew split<cr>', 'New Chat split' },
--     --     ['<C-v>'] = { '<cmd>GpChatNew vsplit<cr>', 'New Chat vsplit' },
--     --     ['<C-t>'] = { '<cmd>GpChatNew tabnew<cr>', 'New Chat tabnew' },
--     --
--     --     r = { '<cmd>GpRewrite<cr>', 'Inline Rewrite' },
--     --     a = { '<cmd>GpAppend<cr>', 'Append (after)' },
--     --     b = { '<cmd>GpPrepend<cr>', 'Prepend (before)' },
--     --
--     --     g = {
--     --       name = 'generate into new ..',
--     --       p = { '<cmd>GpPopup<cr>', 'Popup' },
--     --       e = { '<cmd>GpEnew<cr>', 'GpEnew' },
--     --       n = { '<cmd>GpNew<cr>', 'GpNew' },
--     --       v = { '<cmd>GpVnew<cr>', 'GpVnew' },
--     --       t = { '<cmd>GpTabnew<cr>', 'GpTabnew' },
--     --     },
--     --
--     --     n = { '<cmd>GpNextAgent<cr>', 'Next Agent' },
--     --     s = { '<cmd>GpStop<cr>', 'GpStop' },
--     --     x = { '<cmd>GpContext<cr>', 'Toggle GpContext' },
--     --
--     --     w = {
--     --       name = 'Whisper',
--     --       w = { '<cmd>GpWhisper<cr>', 'Whisper' },
--     --       r = { '<cmd>GpWhisperRewrite<cr>', 'Whisper Inline Rewrite' },
--     --       a = { '<cmd>GpWhisperAppend<cr>', 'Whisper Append (after)' },
--     --       b = { '<cmd>GpWhisperPrepend<cr>', 'Whisper Prepend (before)' },
--     --       p = { '<cmd>GpWhisperPopup<cr>', 'Whisper Popup' },
--     --       e = { '<cmd>GpWhisperEnew<cr>', 'Whisper Enew' },
--     --       n = { '<cmd>GpWhisperNew<cr>', 'Whisper New' },
--     --       v = { '<cmd>GpWhisperVnew<cr>', 'Whisper Vnew' },
--     --       t = { '<cmd>GpWhisperTabnew<cr>', 'Whisper Tabnew' },
--     --     },
--     --   },
--     --   -- ...
--     -- }, {
--     --   mode = 'n', -- NORMAL mode
--     --   prefix = '',
--     --   buffer = '.',
--     --   silent = true,
--     --   noremap = true,
--     --   nowait = true,
--     -- })
--
--     -- -- INSERT mode mappings
--     -- require('which-key').register({
--     --   -- ...
--     --   ['<C-g>'] = {
--     --     c = { '<cmd>GpChatNew<cr>', 'New Chat' },
--     --     t = { '<cmd>GpChatToggle<cr>', 'Toggle Chat' },
--     --     f = { '<cmd>GpChatFinder<cr>', 'Chat Finder' },
--     --
--     --     ['<C-x>'] = { '<cmd>GpChatNew split<cr>', 'New Chat split' },
--     --     ['<C-v>'] = { '<cmd>GpChatNew vsplit<cr>', 'New Chat vsplit' },
--     --     ['<C-t>'] = { '<cmd>GpChatNew tabnew<cr>', 'New Chat tabnew' },
--     --
--     --     r = { '<cmd>GpRewrite<cr>', 'Inline Rewrite' },
--     --     a = { '<cmd>GpAppend<cr>', 'Append (after)' },
--     --     b = { '<cmd>GpPrepend<cr>', 'Prepend (before)' },
--     --
--     --     g = {
--     --       name = 'generate into new ..',
--     --       p = { '<cmd>GpPopup<cr>', 'Popup' },
--     --       e = { '<cmd>GpEnew<cr>', 'GpEnew' },
--     --       n = { '<cmd>GpNew<cr>', 'GpNew' },
--     --       v = { '<cmd>GpVnew<cr>', 'GpVnew' },
--     --       t = { '<cmd>GpTabnew<cr>', 'GpTabnew' },
--     --     },
--     --
--     --     x = { '<cmd>GpContext<cr>', 'Toggle GpContext' },
--     --     s = { '<cmd>GpStop<cr>', 'GpStop' },
--     --     n = { '<cmd>GpNextAgent<cr>', 'Next Agent' },
--     --
--     --     w = {
--     --       name = 'Whisper',
--     --       w = { '<cmd>GpWhisper<cr>', 'Whisper' },
--     --       r = { '<cmd>GpWhisperRewrite<cr>', 'Whisper Inline Rewrite' },
--     --       a = { '<cmd>GpWhisperAppend<cr>', 'Whisper Append (after)' },
--     --       b = { '<cmd>GpWhisperPrepend<cr>', 'Whisper Prepend (before)' },
--     --       p = { '<cmd>GpWhisperPopup<cr>', 'Whisper Popup' },
--     --       e = { '<cmd>GpWhisperEnew<cr>', 'Whisper Enew' },
--     --       n = { '<cmd>GpWhisperNew<cr>', 'Whisper New' },
--     --       v = { '<cmd>GpWhisperVnew<cr>', 'Whisper Vnew' },
--     --       t = { '<cmd>GpWhisperTabnew<cr>', 'Whisper Tabnew' },
--     --     },
--     --   },
--     --   -- ...
--     -- }, {
--     --   mode = 'i', -- INSERT mode
--     --   prefix = '',
--     --   buffer = nil,
--     --   silent = true,
--     --   noremap = true,
--     --   nowait = true,
--     -- })
--   end,
-- }
--
-- -- M.o = o
-- -- return o
--
-- ---!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- -- vim.api.nvim_create_autocmd({ "User" }, {
-- --      pattern = {"GpDone"},
-- --      callback = function(event)
-- --          print("event fired:\n", vim.inspect(event))
-- --          -- local b = event.buf
-- --          -- DO something
-- --      end,
-- --  })
--
-- --
-- -- --
-- -- -- Use this example as a convention for helper functions:
-- -- --
-- -- ---@param name string # name of the augroup
-- -- ---@param opts table | nil # options for the augroup
-- -- ---@return number # returns augroup id
-- -- _H.create_augroup = function(name, opts)
-- -- 	...
-- -- end
-- --
-- -- ---@param file_name string # name of the file for which to get buffer
-- -- ---@return number | nil # buffer number
-- -- _H.get_buffer = function(file_name)
-- --     ...
-- -- end
-- -- The function assignment is preferred over:
-- --
-- -- function _H.create_augroup(name, opts)
-- --     ...
-- -- end
-- -- Module has following structure:
-- --
-- -- local _H = {}
-- -- local M = {
-- -- 	_H = _H, -- helper functions
-- -- 	_Name = "Gp", -- plugin name
-- -- 	_handles = {}, -- handles for running processes
-- -- 	_queries = {}, -- table of latest queries
-- -- 	_state = {}, -- table of state variables
-- -- 	agents = {}, -- table of agents
-- -- 	cmd = {}, -- default command functions
-- -- 	config = {}, -- config variables
-- -- 	hooks = {}, -- user defined command functions
-- -- }
