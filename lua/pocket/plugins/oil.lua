return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
    config = function ()


    vim.keymap.set('n', '-', require('oil').open, { desc = 'fs parent dir (oil)' })
      
      vim.keymap.set("n", "<leader>of", require('oil').open_float, { 



        desc = "oil" })

      require("oil").setup {
        default_file_explorer = true,
        columns = {
          "icon",
          "mtime",
        },
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = true,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        delete_to_trash = false,
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 2000,
        lsp_file_methods = {
          timeout_ms = 1000,
          autosave_changes = false,
        },
        constrain_cursor = "editable",
        experimental_watch_for_changes = false,
        keymaps = {
          ["<C-s>"] = false,
          ["<C-h>"] = false,
          ["<C-t>"] = false,
          ["<C-p>"] = false,
          ["<C-c>"] = false,
          ["<C-l>"] = false,
          ["-"] = false,
          ["_"] = false,
          ["`"] = false,
          ["~"] = false,
          ["gs"] = false,
          ["gx"] = false,
          ["g."] = false,
          ["g\\"] = false,
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['sr'] = 'actions.select_vsplit',
          ['sd'] = 'actions.select_split',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-P>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-r>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
          ['gcc'] = 'actions.cd',
          ['gct'] = 'actions.tcd',
          ['gs'] = 'actions.change_sort',
          ['gct'] = 'actions.toggle_trash',
        },
        use_default_keymaps = true,
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, '.')
          end,
        },
        git = {
          add = function(path)
            return false
          end,
          mv = function(src_path, dest_path)
            return false
          end,
          rm = function(path)
            return false
          end,
        },
        float = { 
          padding = 0,
          max_width = 40,
          min_width = { 30, 0.3 },
          height = 0.9,
          border = "rounded",
          win_options = {
            winblend = -1,
          },
          override = function(conf)
            conf.row = 0
            conf.col = 0
            --conf.width = math.min(40, vim.o.columns * 0.3)  -- Ensure the width is set to the maximum width
            return conf
          end,
        },
        preview = {
          max_width = 0.5,
          min_width = { 40, 0.4 },
          min_height = { 5, 0.1 },
          border = 'rounded',
          win_options = {
            winblend = 0,
          },
          update_on_cursor_moved = true,
        },
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          border = 'rounded',
          win_options = {
            winblend = 0,
          },
        },
        ssh = {
          border = 'rounded',
        },
        keymaps_help = {
          border = 'rounded',
        },
      }
    end,
  },
}
