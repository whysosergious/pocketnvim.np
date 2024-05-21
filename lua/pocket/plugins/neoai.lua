return {
  'Bryley/neoai.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
 'olimorris/persisted.nvim', -- Add persisted.nvim as a dependency

  },
  cmd = {
    'NeoAI',
    'NeoAIOpen',
    'NeoAIClose',
    'NeoAIToggle',
    'NeoAIContext',
    'NeoAIContextOpen',
    'NeoAIContextClose',
    'NeoAIInject',
    'NeoAIInjectCode',
    'NeoAIInjectContext',
    'NeoAIInjectContextCode',
  },
  keys = {},
  config = function()
    -- Define prompt strings separately for better readability
    local system_prompt = [[
      you are a skilled programmer. Proficient in recursive logic and reactive structures.
      your task is to make the given code and or specification, to behave correctly and do what the user expects from it.
      you are mainly working with typescript, deno, +web, rust, nushell as the main shell, wezterm terminal and nvim.

      The user provided the additional info about how they would like you to respond:

      - If you're unsure don't guess and say you don't know instead.
      - Ask questions if you need clarification to provide a better answer.
      - Think deeply and carefully from first principles step by step.
      - Zoom out first to see the big picture and then zoom in to details.
      - Use Socratic method to improve your thinking and coding skills.
      - Don't elide any code from your output if the answer requires coding.
      - Take a deep breath; You've got this!
    ]]

    local textify_prompt = [[
      Please rewrite the text to make it more readable, clear,
      concise, and fix any grammatical, punctuation, or spelling
      errors
    ]]

    local gitcommit_prompt = function()
      return [[
        Using the following git diff generate a concise and
        clear git commit message, with a short title summary
        that is 75 characters or less:
      ]] .. vim.fn.system 'git diff --cached'
    end

    -- Key mappings for UI navigation
    local mappings = {
      ['select_up'] = '<C-k>',
      ['select_down'] = '<C-j>',
    }

-- Function to retrieve chat history from the current buffer
local function get_chat_history()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local chat_history = {}

  for _, line in ipairs(lines) do
    -- Check if the line contains a user message (starting with 'User:')
    if string.match(line, '^User:') then
      table.insert(chat_history, line)
    end
  end

  return chat_history
end

-- Usage example
local chat_history = get_chat_history()
for _, message in ipairs(chat_history) do
  print(message) -- Output the chat history messages
end

-- Function to save the AI context to a file
local function save_context_to_file(context, filename)
  local file = io.open(filename, "w")
  file:write(context)
  file:close()
end

-- Callback for PersistedSavePre event to save AI context to a file
vim.api.nvim_create_autocmd('User', {
  pattern = 'BufWritePost',
  callback = function()
    local context = get_current_ai_context() -- Implement the function to retrieve AI context
    save_context_to_file(context, '/path/to/save/context.txt')
    vim.notify("PersistedSavePre event triggered. Context saved to file.", vim.log.levels.INFO)
  end,
})

-- Callback for PersistedLoadPost event to save AI context to a file
vim.api.nvim_create_autocmd('User', {
  pattern = 'PersistedLoadPost',
  callback = function()
    local context = get_loaded_ai_context() -- Implement the function to retrieve AI context post load
    save_context_to_file(context, '/path/to/save/context.txt')
    vim.notify("PersistedLoadPost event triggered. Context saved to file.", vim.log.levels.INFO)
  end,
})

    -- Setup neoai.nvim with the defined configuration
    require('neoai').setup {
      ui = {
        output_popup_text = 'Friday',
      }
    }
    -- Setup neoai.nvim with the defined configuration
    require('neoai').setup {
      ui = {
        output_popup_text = 'Friday',
        input_popup_text = '- -- -',
        width = 44, -- As percentage eg. 30%
        output_popup_height = 80, -- As percentage eg. 80%
        submit = '<Enter>', -- Key binding to submit the prompt
      },
      models = {
        {
          name = 'openai',
          model = 'gpt-4o',
          params = {
            -- max_tokens = 100,
            temperature = 0.1,
            top_p = 1,
            frequency_penalty = 0.1,
            presence_penalty = 0,
            -- stop = nil,
          },
        },
      },
      register_output = {
        ['g'] = function(output)
          return output
        end,
        ['c'] = require('neoai.utils').extract_code_snippets,
      },
      inject = {
        cutoff_width = 75,
      },
      prompts = {
        context_prompt = function(context)
          return "Here's the code we're currently working on:\n\n" .. context .. '\n\n'
        end,
        system = system_prompt,
      },
      mappings = mappings,
      open_ai = {
        api_key = {
          env = 'OPENAI_API_KEY',
        },
      },
      shortcuts = {
        {
          name = 'textify',
          key = '<leader>as',
          desc = 'fix text with AI',
          use_context = true,
          prompt = textify_prompt,
          modes = { 'v' },
          strip_function = nil,
        },
        {
          name = 'gitcommit',
          key = '<leader>ag',
          desc = 'generate git commit message',
          use_context = false,
          prompt = gitcommit_prompt,
          modes = { 'n' },
          strip_function = nil,
        },
      },
    }
  end,
}
