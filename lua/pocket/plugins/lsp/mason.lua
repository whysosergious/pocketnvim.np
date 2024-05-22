      requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },

        config = function()
          require("sad").setup{}
        end,
      })
    end,
Pvim.lsp.handlers["textDocument/codeAction"] = require'fzf_lsp'.code_action_handler
vim.lsp.handlers["textDocument/definition"] = require'fzf_lsp'.definition_handler
vim.lsp.handlers["textDocument/declaration"] = require'fzf_lsp'.declaration_handler
vim.lsp.handlers["textDocument/typeDefinition"] = require'fzf_lsp'.type_definition_handler
vim.lsp.handlers["textDocument/implementation"] = require'fzf_lsp'.implementation_handler
vim.lsp.handlers["textDocument/references"] = require'fzf_lsp'.references_handler
vim.lsp.handlers["textDocument/documentSymbol"] = require'fzf_lsp'.document_symbol_handler
vim.lsp.handlers["workspace/symbol"] = require'fzf_lsp'.workspace_symbol_handler
vim.lsp.handlers["callHierarchy/incomingCalls"] = require'fzf_lsp'.incoming_calls_handler
vim.lsp.handlers["callHierarchy/outgoingCalls"] = require'fzf_lsp'.outgoing_calls_handler

/usr/local/opt/fzf,/opt/homebrew/opt/fzf,If you have cloned fzf on ~/.fzf directory'
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.coding.copilot" },
  }
})
require("lazy").setup("plugins")
require("lazy").setup({{import = "plugins"}})
opts, dependencies, cmd, event, ft and keys 
With packer wants, requires and after can be u
ddependencies  
ependencies  
   let g:terminal_color_0 = '#4e4e4e'

  let g:terminal_color_1 = '#d68787'
  let g:terminal_color_2 = '#5f865f'
  let g:terminal_color_3 = '#d8af5f'
  let g:terminal_color_4 = '#85add4'
  let g:terminal_color_5 = '#d7afaf'
  let g:terminal_color_6 = '#87afaf'
  let g:terminal_color_7 = '#d0d0d0'
  let g:terminal_color_8 = '#626262'
  let g:terminal_color_9 = '#d75f87'
  let g:terminal_color_10 = '#87af87'
  let g:terminal_color_11 = '#ffd787'
  let g:terminal_color_12 = '#add4fb'
  let g:terminal_color_13 = '#ffafaf'
  let g:terminal_color_14 = '#87d7d7'
  let g:terminal_color_15 = '#e4e4e4'
rg -uuu
  let g:terminal_ansi_colors = [
    \ '#4e4e4e', '#d68787', '#5f865f', '#d8af5f',
    \ '#85add4', '#d7afaf', '#87afaf', '#d0d0d0',
    \ '#626262', '#d75f87', '#87af87', '#ffd787',
    \ '#add4fb', '#ffafaf', '#87d7d7', '#e4e4e4'
        pInstallationRegex syntax
