return {
  'Bryley/neoai.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
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
  keys = {
    { '<leader>as', desc = 'summarize text' },
    { '<leader>ag', desc = 'generate git message' },
  },
  config = function()
    require('neoai').setup {
      require('neoai').setup {
        -- Below are the default options, feel free to override what you would like changed
        ui = {
          output_popup_text = 'Friday',
          input_popup_text = '- -- -',
          width = 42, -- As percentage eg. 30%
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
          system_default = 'you are a skilled programmer. Proficient in recursive logic and reactive structures. your task is to make the given code and or specification, to behave correctly and do what the user expects from it. you are mainly workin with typescript, deno, +web, rust, nushell as the main shell, wezterm terminal and nvim.\n\n'
            .. 'The user provided the additional info about how they would like you to respond:\n\n'
            .. "- If you're unsure don't guess and say you don't know instead.\n"
            .. '- Ask question if you need clarification to provide better answer.\n'
            .. '- Think deeply and carefully from first principles step by step.\n'
            .. '- Zoom out first to see the big picture and then zoom in to details.\n'
            .. '- Use Socratic method to improve your thinking and coding skills.\n'
            .. "- Don't elide any code from your output if the answer requires coding.\n"
            .. "- Take a deep breath; You've got this!\n",
          context_prompt = function(context)
            return "Hey, I'd like to provide some context for future "
              .. 'messages. Here is the code/text that I want to refer '
              .. 'to in our upcoming conversations:\n\n'
              .. context
          end,
        },
        mappings = {
          ['select_up'] = '<C-k>',
          ['select_down'] = '<C-j>',
        },
        open_ai = {
          api_key = {
            env = 'OPENAI_API_KEY',
            value = nil,
            -- `get` is is a function that retrieves an API key, can be used to override the default method.
            -- get = function() ... end

            -- Here is some code for a function that retrieves an API key. You can use it with
            -- the Linux 'pass' application.
            -- get = function()
            --     local key = vim.fn.system("pass show openai/mytestkey")
            --     key = string.gsub(key, "\n", "")
            --     return key
            -- end,
          },
        },
        shortcuts = {
          {
            name = 'textify',
            key = '<leader>as',
            desc = 'fix text with AI',
            use_context = true,
            prompt = [[
                Please rewrite the text to make it more readable, clear,
                concise, and fix any grammatical, punctuation, or spelling
                errors
            ]],
            modes = { 'v' },
            strip_function = nil,
          },
          {
            name = 'gitcommit',
            key = '<leader>ag',
            desc = 'generate git commit message',
            use_context = false,
            prompt = function()
              return [[
                    Using the following git diff generate a consise and
                    clear git commit message, with a short title summary
                    that is 75 characters or less:
                ]] .. vim.fn.system 'git diff --cached'
            end,
            modes = { 'n' },
            strip_function = nil,
          },
        },
      },
    }
    -- context_prompt = function(context)
    --   return "this code is what we're dealing with:\n\n" .. context
    -- end

    -- vim.keymap.set('n', '<leader>ogc', '<cmd>NeoAIContextOpen<cr>', { desc = 'open gpt context chat' })
    --
    -- vim.keymap.set('n', '<M-Enter>', function()
    --   require('neoai').submit()
    -- end, { desc = 'send message' })
  end,
}

