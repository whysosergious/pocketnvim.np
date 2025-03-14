return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
'saghen/blink.cmp',
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },

  },
-- opts = {
--     servers = {
--       lua_ls = {}
--     }
--   },
    config = function(_, opts)

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      require('lspconfig').lua_ls.setup { capabilities = capabilities }
    


    -- local lspconfig = require('lspconfig')
    -- for server, config in pairs(opts.servers) do
    --   -- passing config.capabilities to blink.cmp merges with the capabilities in your
    --   -- `opts[server].capabilities, if you've defined it
    -- end
  -- end

 -- example calling setup directly for each LSP
  -- config = function()
  --   local capabilities = require('blink.cmp').get_lsp_capabilities()
  --   -- local lspconfig = require('lspconfig')
  --
  --   lspconfig['lua-ls'].setup({ capabilities = capabilities })
  -- -- end,

  -- config = function()
    -- import lspconfig plugin
    -- local lspconfig = require "lspconfig"

    -- import mason_lspconfig plugin
    local mason_lspconfig = require "mason-lspconfig"

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require "cmp_nvim_lsp"

    local keymap = vim.keymap -- for conciseness

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),


      callback = function()
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        -- local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>db", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>dl", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
      end,
    })
    -- {
    --   hostInfo = "neovim",
    -- }
    -- used to enable autocompletion (assign to every lsp server config)
    -- local capabilities = cmp_nvim_lsp.default_capabilities()
    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
    mason_lspconfig.setup_handlers {
      -- default handler for installed servers
      -- function(server_name)
      --   lspconfig[server_name].setup {
      --     capabilities = capabilities,
      --   }
      -- end,
      --   -- ["svelte"] = function()
      --   --   -- configure svelte server
      --   --   lspconfig["svelte"].setup({
      --   --     capabilities = capabilities,
      --   --     on_attach = function(client, bufnr)
      --   --       vim.api.nvim_create_autocmd("BufWritePost", {
      --   --         pattern = { "*.js", "*.ts" },
      --   --         callback = function(ctx)
      --   --           -- Here use ctx.match instead of ctx.file
      --   --           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
      --   --         end,
      --   --       })
      --   --     end,
      --   --   })
      --   -- end,
      --   -- ["graphql"] = function()
      --   --   -- configure graphql language server
      --   --   lspconfig["graphql"].setup({
      --   --     capabilities = capabilities,
      --   --     filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
      --   --   })
      --   -- end,
      --   -- ["emmet_ls"] = function()
      --   --   -- configure emmet language server
      --   --   lspconfig["emmet_ls"].setup({
      --   --     capabilities = capabilities,
      --   --     filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      --   --   })
      --   -- end

      -- ["tsserver"] = function()
      --   -- configure tsserver (with special settings)
      --   lspconfig["tsserver"].setup {
      --     capabilities = capabilities,
      --     on_attach = function(client, bufnr)
      --       -- disable tsserver formatting
      --       client.resolved_capabilities.document_formatting = true          
      --     end,
      --   }
      -- end,



      -- ["html"] = function()
      -- 
      --     
      -- lspconfig['html'].setup
      --   { 
      --     capabilities = capabilities ,
      --     -- configure html (with special settings)
      --   
      --     settings = {
      --       html = {
      --         suggest = {
      --           -- enable completion for all tags
      --           completion = {
      --             tagComplete = true,
      --           },
      --         },
      --       },
      --     },
      --   }
      -- end,
      -- ["cssls"] = function()
      --   -- configure cssls (with special settings)
      --   lspconfig["cssls"].setup {
      --     capabilities = capabilities,
      --     settings = {
      --       css = {
      --         validate = true,
      --       },
      --     },
      --   }
      -- end,
      -- ["rust_analyzer"] = function()
      --   -- configure rust_analyzer (with special settings)
      --   lspconfig["rust_analyzer"].setup {
      --     capabilities = capabilities,
      --     settings = {
      --       ["rust-analyzer"] = {
      --         checkOnSave = {
      --           command = "clippy",
      --         },
      --       },
      --     },
      --   }
      -- end,
      -- ["lua_ls"] = function()
      --   -- configure lua server (with special settings)
      --   lspconfig["lua_ls"].setup {
      --     capabilities = capabilities,
      --     settings = {
      --       Lua = {
      --         -- make the language server recognize "vim" global
      --         diagnostics = {
      --           globals = { "vim" },
      --         },
      --         completion = {
      --           callSnippet = "Replace",
      --         },
      --       },
      --     },
      --   }
      -- end,
    

    }
-- local map = keymap
--   -- if client.supports_method "textDocument/implementation" then
--   --   map("n", "gi", function()
--   --     require("telescope.builtin").lsp_implementations {
--   --       reuse_win = true,
--   --     }
--   --   end, { desc = "Goto implementation" })
--   -- end
--
--   map("n", "gd", function()
--     require("telescope.builtin").lsp_definitions { reuse_win = true }
--   end, { desc = "Goto definition" })
--   map("n", "gD", function()
--     vim.lsp.buf.declaration()
--   end, { desc = "Goto declaration" })
--   map("n", "gt", function()
--     require("telescope.builtin").lsp_type_definitions {
--       reuse_win = true,
--     }
--   end, { desc = "Goto type" })
--
--   map("n", "]d", function()
--     vim.diagnostic.goto_next { severity = nil }
--   end, { desc = "Next diagnostic" })
--   map("n", "[d", function()
--     vim.diagnostic.goto_prev { severity = nil }
--   end, { desc = "Previous diagnostic" })
--   map("n", "]e", function()
--     vim.diagnostic.goto_next {
--       severity = vim.diagnostic.severity["ERROR"],
--     }
--   end, { desc = "Next error" })
--   map("n", "[e", function()
--     vim.diagnostic.goto_prev {
--       severity = vim.diagnostic.severity["ERROR"],
--     }
--   end, { desc = "Previous error" })
--   map("n", "]w", function()
--     vim.diagnostic.goto_next {
--       severity = vim.diagnostic.severity["WARN"],
--     }
--   end, { desc = "Next warning" })
--   map("n", "[w", function()
--     vim.diagnostic.goto_prev {
--       severity = vim.diagnostic.severity["WARN"],
--     }
--   end, { desc = "Previous warning" })
--
-- --   -- search
--   map("n", "<leader>sr", function()
--     require("telescope.builtin").lsp_references { jump_type = "vsplit" }
--   end, { desc = "Search references" })
--   map("n", "<leader>ss", function()
--     require("telescope.builtin").lsp_document_symbols()
--   end, { desc = "Search symbols" })
--   map("n", "<leader>sd", function()
--     require("telescope.builtin").diagnostics { bufnr = 0 }
--   end, { desc = "Search diagnostics" })
--   map("n", "<leader>sD", function()
--     require("telescope.builtin").diagnostics { bufnr = nil }
--   end, { desc = "Search diagnostics (all buffers)" })
--
-- --   if client.supports_method "callHierarchy/incomingCalls" then
-- --     map("n", "<leader>sc", function()
-- --       require("telescope.builtin").lsp_incoming_calls()
-- --     end, { desc = "Search incoming calls" })
-- --   end
-- --   if client.supports_method "callHierarchy/outgoingCalls" then
-- --     map("n", "<leader>sC", function()
-- --       require("telescope.builtin").lsp_outgoing_calls()
-- --     end, { desc = "Search outgoing calls" })
-- --   end
--
-- --   -- edits
--   map("n", "<leader>cr", function()
--     vim.lsp.buf.rename()
--   end, { desc = "Rename" })
--   map({ "n", "v" }, "<leader>ca", function()
--     vim.lsp.buf.code_action()
--   end, { desc = "Code action" })
--   map("n", "<leader>cA", function()
--     vim.lsp.buf.code_action {
--       context = { only = { "source" }, diagnostics = {} },
--     }
--   end, { desc = "Source action" })
--   map("n", "<leader>cf", function()
--     require("conform").format()
--   end, { desc = "Format" })
--   map("v", "<leader>cf", function()
--     require("conform").format()
--   end, { desc = "Format selection" })
--
-- --   -- help
--   map("n", "K", function()
--     vim.lsp.buf.hover()
--   end, { desc = "Hover information" })
--   map("n", "gK", function()
--     vim.lsp.buf.signature_help()
--   end, { desc = "Signature help" })
--   map("i", "<c-k>", function()
--     vim.lsp.buf.signature_help()
--   end, { desc = "Signature help" })
--   -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
--
-- --   -- which-key
--   local mappings = {
--     { "<leader>c", group = "code" },
--   }
--   local options = {
--     mode = { "n", "v" },
--   }
--   local wk = require "which-key"
--   wk.add(mappings, options)
--
--
--   -- ["ast_grep"] = function()
--   --   default_config = {
--   --     cmd = { "ast-grep", "lsp" },
--   --     single_file_support = false,
--   --     root_dir = nvim_lsp.util.root_pattern "sgconfig.yml",
--   --   }
--   -- end
--    )

  end
  }


-- -- perform buffer local configurations for LSP
-- local function on_attach(ev)
--   local function map(mode, lhs, rhs, opts)
--     opts = opts or {}
--     opts.buffer = ev.buf
--     vim.keymap.set(mode, lhs, rhs, opts)
--   end
--   local client = vim.lsp.get_client_by_id(ev.data.client_id)

--   -- configure keymaps defined in lspconfig
--   if client.config.keys then
--     for _, keymap in ipairs(client.config.keys) do
--       map(keymap[1], keymap[2], keymap[3], keymap[4])
--     end
--   end

--   -- vim.api.nvim_create_autocmd('CursorHold', {
--   -- 	buffer = ev.buf,
--   -- 	callback = function()
--   -- 		local opts = {
--   -- 			-- open_float
--   -- 			scope = 'cursor',
--   -- 			source = true,
--   -- 			-- open_floating_preview
--   -- 			max_width = 60,
--   -- 			focusable = false,
--   -- 			close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
--   -- 			-- nvim_open_win
--   -- 			border = 'none',
--   -- 		}
--   -- 		vim.diagnostic.open_float(opts)
--   -- 	end,
--   -- })

--   -- goto
  -- return {
--   "neovim/nvim-lspconfig",
--   config = function(_, opts)
--     local lspconfig = require "lspconfig"
--     for server, config in pairs(opts.servers) do
--       lspconfig[server].setup(config)
--     end
--   end,
--   dependencies = {
--     "williamboman/mason-lspconfig.nvim",
--     dependencies = {
--       "williamboman/mason.nvim",
--       config = function(_, opts)
--         require("mason").setup(opts)
--         local mr = require "mason-registry"
--         local function ensure_installed()
--           for _, tool in ipairs(opts.ensure_installed) do
--             local p = mr.get_package(tool)
--             if not p:is_installed() then
--               p:install()
--             end
--           end
--         end
--         if mr.refresh then
--           mr.refresh(ensure_installed)
--         else
--           ensure_installed()
--         end
--       end,
--       opts = {
--         ensure_installed = {},
--         max_concurrent_installers = #vim.loop.cpu_info(),
--         pip = { upgrade_pip = true },
--       },
--       build = ":MasonUpdate",
--     },
--     opts = { ensure_installed = {} },
--   },
  -- init = function()
  --   vim.api.nvim_create_autocmd("LspAttach", {
  --     group = vim.api.nvim_create_augroup("LspConfig", {}),
  --     callback = on_attach,
  --   })

    -- update lsp floating window settings
    -- local max_width = 80


   -- opts = {
   --   servers = {},
   -- }
     -- diagnostics
     -- vim.diagnostic.config {
     --   update_in_insert = false,
     --   virtual_text = false,
     -- }
   -- end
