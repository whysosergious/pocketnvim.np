return {
  { "junegunn/fzf" },
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "junegunn/fzf",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
    },
    config = function()
      local telescope = require "telescope"
      local actions = require "telescope.actions"
      local transform_mod = require("telescope.actions.mt").transform_mod

      local trouble = require "trouble"
      local trouble_telescope = require "trouble.providers.telescope"
      local pickers = require "telescope.pickers"
      local builtin = require "telescope.builtin"
      local themes = require "telescope.themes"
      local finders = require "telescope.finders"
      local sorters = require "telescope.sorters"

      -- or create your custom action
      local custom_actions =
        transform_mod {
          open_trouble_qflist = function(prompt_bufnr)
            trouble.toggle "quickfix"
          end,
        }, require("telescope").setup {
          extensions = {
            ast_grep = {
              command = {
                "sg",
                "--json=stream",
              }, -- must have --json=stream
              grep_open_files = false, -- search in opened files
              lang = nil, -- string value, specify language for ast-grep `nil` for default
            },
          },
        }

      -- local centered_dropdown = themes.get_dropdown {
      --   width = 0.6,
      --   height = 1,
      --   max_width = 800,
      --
      --
      --
      --   -- winblend = 10,
      --   layout_config = {
      --
      --     horizontal = {
      --       height = function(_, _, _)
      --         return vim.o.lines
      --       end,
      --       prompt_position = 'top',
      --       width = 0.6,
      --     },
      --     -- center = {
      --     --   height = 0.6,
      --     --   prompt_position = 'top',
      --     --   width = 0.6,
      --     -- },
      --     -- width = 0.6,
      --     -- max_width = 800,
      --     -- height = 0.6,
      --     -- max_height = 1200,
      --   },
      --
      --   strategy = 'horizontal',
      --   borderchars = {
      --     -- { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      --     -- preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      --     -- results = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      --     -- prompt = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      --
      --     { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      --     prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
      --     results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      --     preview = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      --   },
      --
      -- }

      local cp = function()
        builtin.live_grep(themes.get_dropdown {
          prompt_title = "cp",
          results_title = "cp res",
          preview_title = "Command Preview",
          previewer = false,
          prompt_prefix = "› ",
          hidden = true,

          -- results_height = 10,
          -- max_results = 16,
          top = "20px",
          -- strategy = 'top',
          orientation = "horizontal",
          -- hidden = true,
          --
          top_offset = 0.2,
          prompt_position = "top",
          -- layout_config = {
          --   width = 0.6,
          --   height = 0.6,
          --
          --   cursor = {
          --     height = 0.6,
          --     width = 0.6,
          --   },
          -- },
          finder = finders.new_table {
            "aaa",
            "bbbb",
            "ldbclkdnlck",
            -- builtin.commands(),
            -- builtin.vim_options(),
          },
          finder_command = { "rg" },
          sorter = sorters.get_generic_fuzzy_sorter(),

          --
        })
      end
      -- {
      --
      --   sorting_strategy = 'ascending',
      --   layout_strategy = 'horizontal',
      --   layout_config = {
      --     width = 0.6,
      --     height = 0.6,
      --     prompt_position = 'top',
      --     -- cursor = {
      --     --   height = 0.6,
      --     --   width = 0.6,
      --     -- },
      --   },
      --   finder = finders.new_table {
      --     'aaa',
      --     'bbbb',
      --     'ldbclkdnlck',
      --     -- builtin.commands(),
      --     -- builtin.vim_options(),
      --   },
      --   finder_command = { 'rg' },
      --   sorter = sorters.get_generic_fuzzy_sorter(),
      --   attach_mappings = function(prompt_bufnr, map)
      --     map('i', '<C-t>', function()
      --       local entry = actions.get_selected_entry(prompt_bufnr)
      --       actions.close(prompt_bufnr)
      --       vim.cmd(entry.value)
      --     end)
      --     return true
      --   end,
      -- }
      --
      local o = {
        prompt_title = "cp",
        results_title = "cp res",
        preview_title = "Command Preview",
        previewer = false,
        prompt_prefix = "› ",
        hidden = true,
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.6,
          height = 0.6,
          prompt_position = "top",
          -- cursor = {
          --   height = 0.6,
          --   width = 0.6,
          -- },
        },
        finder = finders.new_table {
          "aaa",
          "bbbb",
          "ldbclkdnlck",
          -- builtin.commands(),
          -- builtin.vim_options(),
        },
        finder_command = { "rg" },
        sorter = sorters.get_generic_fuzzy_sorter(),
        -- attach_mappings = function(prompt_bufnr, map)
        --   map('i', '<C-t>', function()
        --     local entry = actions.get_selected_entry(prompt_bufnr)
        --     actions.close(prompt_bufnr)
        --     vim.cmd(entry.value)
        --   end)
        --   return true
        -- end,
      }
      -- opts

      -- local cmd_prompt = function(opts)
      --   cp:find()
      -- end
      local pthc = function()
        return pickers.new(cp(), o)
      end
      telescope.setup {
        pickers = {
          cmd_prompt = {},
          find_files = {
            theme = "dropdown",
            hidden = true,
          },

          live_grep = {
            theme = "dropdown",

            hidden = true,
          },

          colorscheme = {
            enable_preview = true,
          },
        },
        defaults = {
          path_display = { "smart" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
              ["<C-t>"] = require("trouble.sources.telescope").open,
            },
          },
        },
        extensions = {
          persisted = {
            layout_config = {
              width = 0.6,
              height = 0.6,
              -- cursor = {
              --   height = 0.6,
              --   width = 0.6,
              -- },
            },
          },
          -- fzf = {
          --   override_generic_sorter = true, -- override the generic sorter
          --   override_file_sorter = true, -- override the file sorter
          --   case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- },
        },
      }

      builtin.cp = pthc
      -- builtin.cp = cmd_prompt
      --    telescope.load_extension 'fzf'

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy files in cwd" })
      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy recent files" })
      keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Grep string in cwd" })
      keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Grep string under cursor in cwd" })
      keymap.set("n", "<leader>fj", "<cmd>Telescope jumplist<cr>", { desc = "Search in jumplist" })
      -- uppercase for less common
      keymap.set("n", "<leader>fK", "<cmd>Telescope keymaps<cr>", { desc = "Search in keymaps" })
      keymap.set("n", "<leader>fS", "<cmd>Telescope treesitter<cr>", { desc = "Search with treesitter" })
      keymap.set("n", "<leader>fO", "<cmd>Telescope vim_options<cr>", { desc = "Search in vim options" })
      keymap.set("n", "<leader>fC", "<cmd>Telescope commands<cr>", { desc = "Search in commands" })
      keymap.set("n", "<leader>fA", "<cmd>Telescope autocommands<cr>", { desc = "Search in autocommands" })
      keymap.set("n", "<leader>fB", "<cmd>Telescope builtin<cr>", { desc = "Search in builtin" })
      keymap.set("n", "<leader>fP", "<cmd>Telescope pickers<cr>", { desc = "Search pickers" })
      keymap.set("n", "<leader>fT", "<cmd>TodoTelescope<cr>", { desc = "Search todos" })

      --persisted thing    -- custom pickers
      keymap.set("n", "<c-\\>", function()
        require("telescope.builtin").cp()
      end, { desc = "Builtin & custom cmds/opts" })

      require("telescope").load_extension "persisted"

      vim.keymap.set("n", "<leader>fp", "<cmd>Telescope persisted<cr>", { desc = "Persisted thing" })
    end,
  },
  {
    "olimorris/persisted.nvim",
    lazy = false,

    config = true,

    -- function()
    -- require('persisted').setup()
    --
    --     end,
  },
}
