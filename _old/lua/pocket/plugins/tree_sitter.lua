
return {
	


	{ 


--    'nvim-treesitter/nvim-treesitter-textobjects',
-- 'nvim-treesitter/nvim-treesitter-refactor',
		'nvim-treesitter/nvim-treesitter', 
		config = function() 
			vim.cmd([[TSUpdate]])

			require'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = { "javascript", "typescript", "rust", "c", "lua", "vim", "vimdoc", "query"  
},
 

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = true,
          indent = {
    enable = true
  },
    textobjects = { enable = true },
 
incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      scope_incremental = '<CR>',
      node_incremental = '<TAB>',
      node_decremental = '<S-TAB>',
    },
  },
  highlight = {

					enable = true,
          

					-- list of language that will be disabled
					-- disable = { "c", "rust" },

					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},

 parsers = {
nu = {
  install_info = {
    url = "C:/!work/!active/wss/treesitter/parsers/nu", -- local path or git repo
    files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "nu", -- if filetype does not match the parser name
}
}
			}
       
	end



	},
	
}
