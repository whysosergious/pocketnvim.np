-- Define the get_script_dir function
function Get_script_dir()
  local str = debug.getinfo(2, "S").source:sub(2)
  return str:match "(.*/)"
end

function Load_highlight_groups(filename)
  -- local file = io.open(filename, "r")
  local script_dir = Get_script_dir()
  local full_path = script_dir .. "/saved/" .. filename .. ".rstr"

  local file = io.open(full_path)

  if file then
    -- local hl_output = file:read "*a"
    file:close()
    -- vim.api.nvim_exec(hl_output, false)
    print("Highlight groups loaded from " .. filename)
  else
    print("Failed to open file: " .. filename)
  end
end

function Load_saved_scheme()
  local script_dir2 = Get_script_dir()
  local full_settings_path = script_dir2 .. "__auto_saved_settings__.rstr"
  local file2 = io.open(full_settings_path)

  print "opening file settings file"
  -- file2 = io.open("./saved/" .. "absent-contrast" .. ".rstr")
  -- print("opened file2:" .. "absent-contrast" .. ".rstr")
  if file2 then
    local settings = file2:read "*a"
    file2:close()

    --
    -- vim("colotscheme " .. setting
    print("loading scheme with name: " .. settings)
  end
end
return {

  --

  "marko-cerovac/material.nvim",
  -- require("newpaper").setup { style = "dark" },
  config = function()
    -- --   --
    vim.cmd [[
        " For Neovim 0.1.3 and 0.1.4
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1

        " Or if you have Neovim >= 0.1.5
        if (has("termguicolors"))
          set termguicolors
        endif

        " Theme
        syntax enable
        " colorscheme OceanicNext

        colorscheme material

        syntax on
        let g:material_style = 'oceanic'
        let g:material_italic_comments = 1

        
        let g:material_italic_keywords = 1
        let g:material_italic_functions = 1
        " let g:material_italic_variables = 1
        let g:material_contrast =  1
        let g:material_borders = 1

        
        " let g:oceanic_next_terminal_bold = 1
        " let g:oceanic_next_terminal_italic = 1
        " colorscheme base16-chalk

        " Highlight clear  
        hi disable_background guibg=NONE ctermbg=NONE
        hi Normal guibg=NONE ctermbg=NONE
        hi LineNr guibg=NONE ctermbg=NONE
        hi SignColumn guibg=NONE ctermbg=NONE
        hi EndOfBuffer guibg=NONE ctermbg=NONE

    ]]
  end,
}
