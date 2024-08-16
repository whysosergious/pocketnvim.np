local M = {}

function M.setup(configColors, configStyle)

    -- stylua: ignore start

    local troubleSyn  = {}
    troubleSyn.colors = configColors
    troubleSyn.style  = configStyle
    local newpaper    = troubleSyn.colors
    local style       = troubleSyn.style

    troubleSyn.loadPlugins = function()
        local plugins = {
            TroubleCount           = { fg = newpaper.orange, bg = newpaper.none, style = style.b_bold },
            TroubleNormal          = { fg = newpaper.trouble_fg,    bg = newpaper.trouble_bg },
            TroubleText            = { fg = newpaper.fg,            bg = newpaper.none },
            TroubleSource          = { fg = newpaper.trouble_fg,    bg = newpaper.none },
            TroubleCode            = { fg = newpaper.trouble_fg,    bg = newpaper.none },
            TroubleFoldIcon        = { fg = newpaper.cursor_nr_fg,  bg = newpaper.none },
            TroubleIndent          = { fg = newpaper.linenumber_fg, bg = newpaper.none },
            TroubleLocation        = { fg = newpaper.teal,          bg = newpaper.none },
            TroubleTextInformation = { fg = newpaper.info_fg,       bg = newpaper.none },
            TroubleSignInformation = { fg = newpaper.info_fg,       bg = newpaper.none },
            TroubleTextError       = { fg = newpaper.error_fg,      bg = newpaper.none },
            TroubleSignError       = { fg = newpaper.error_fg,      bg = newpaper.none },
            TroubleTextWarning     = { fg = newpaper.warn_fg,       bg = newpaper.none },
            TroubleSignWarning     = { fg = newpaper.warn_fg,       bg = newpaper.none },
            TroubleTextHint        = { fg = newpaper.hint_fg,       bg = newpaper.none },
            TroubleSignHint        = { fg = newpaper.hint_fg,       bg = newpaper.none },
        }
        return plugins
    end

    -- stylua: ignore end

    return troubleSyn
end

return M
