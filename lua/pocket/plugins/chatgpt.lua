return {

  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    "folke/which-key.nvim",
    },
extra_curl_params = {
    "-H",
    "OpenAI-Beta: assistants=v2"
  },
  config = function()
    local chatgpt = require("chatgpt").setup({
          model = "gpt-4o",
      temperature = 0.14,

      history = true,
      history_size = 1000,
      history_file = vim.fn.stdpath("data") .. "/chatgpt_history.json",
 
      top_p = 1,
      frequency_penalty = 0.12,
     -- max_tokens = 150,
      -- presence_penalty = 0,
      -- stop = nil,
      -- response_time = 5000,
      -- on_complete = nil,
      -- on_error = nil,
      -- on_input = nil,
      -- on_start = nil,
      -- on_stop = nil,
      -- on_history = nil,
      -- on_history_clear = nil,
      -- on_history_save = nil,
      -- on_history_load = nil,
      -- on_history_delete = nil,
      -- on_history_reset = nil,
      -- on_history_push = nil,
      -- on_history_pop = nil,
      -- on_history_shift = nil,
      -- on_history_unshift = nil,
      
    })
       -- note from docs about actions.json
    --The edit strategy consists in showing the output side by side with the input and available for further editing requests. For now, edit strategy is implemented for chat type only.
--
-- The display strategy shows the output in a float window.
--
-- append and replace modify the text directly in the buffer.
 --   ChatGPTEditWithInstructions
  --When the setting window is opened (with <C-o>), settings can be modified by pressing Enter on the related config. Settings are saved across sections
 local wk = require("which-key")
wk.register({
    p = {
        name = "ChatGPT",
        e = {
            function()
                chatgpt.edit_with_instructions()
            end,
            "Edit with instructions",
        },
    },


    c = {
  name = "ChatGPT",
    c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
    e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
    g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
    t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
    k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
    d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
    a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
    o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
    s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
    f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
    x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
    r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
    l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
  },
}, {
    prefix = "<leader>",
    mode = "v",
})



    -- CHECKOUT:
    --ChatGPTActAs
-- ChatGPTActAs command which opens a prompt selection from Awesome ChatGPT Prompts to be used with the gpt-3.5-turbo model.
  end,
}
