local M = {}

function M.setupStyle(config)
    -- stylua: ignore start

    local style       = {
        -- default styles
        none         = "NONE",
        bold         = "bold",
        italic       = "italic",
        underline    = "underline",
        undercurl    = "undercurl",
        reverse      = "reverse",
        strike       = "strikethrough",

        b_bold       = "NONE", -- editor style bold
        b_italic     = "NONE", -- editor style italic
        b_bold_i     = "NONE", -- editor style bold italic
        b_bold_u     = "NONE", -- editor style bold underline
        c_style      = "NONE", -- comments style
        doc_style    = "NONE", -- comments documenting code style
        c_title      = "NONE", -- magic and tittle comments in VimL, Ruby etc
        o_style      = "NONE", -- operators style
        d_style      = "NONE", -- delimiters style
        br_style     = "NONE", -- brackets style
        d_r_style    = "NONE", -- delimiters rainbow style
        tb_style     = "NONE", -- tags brackets style
        s_style      = "NONE", -- strings style
        v_style      = "NONE", -- variables style
        f_style      = "NONE", -- functions style

        -- Spell style
        error        = "NONE",

        -- Make booleans bold, italic or NONE
        bool_style   = config.booleans,

        -- Make keywords bold, italic or NONE
        k_style      = config.keywords,

        -- Make keywords style in comments documenting code bold, italic or NONE
        doc_k_style  = config.doc_keywords,

        -- Make regex bold, italic or NONE
        regex        = config.regex,

        -- Tex settings
        tex_m_style  = config.tex_major,
        tex_k_style  = config.tex_keywords,
        tex_z_style  = config.tex_zone,
        tex_a_style  = config.tex_arg,
        tex_o_style  = "NONE", -- operators style
        tex_br_style = "NONE", -- brackets style
        tex_md_style = "NONE", -- math delim style

    }
    -- Combine style
    style.bold_i      = style.bold .. "," .. style.italic
    style.bold_u      = style.bold .. "," .. style.underline
    style.italic_u    = style.italic .. "," .. style.underline

    -- HTML tags styles
    style.tags_style  = config.tags
    style.links       = style.italic_u
    style.b_links     = style.bold_u

    -- comments style underline
    style.c_underline = style.underline

    -- strings style underline
    style.s_underline = style.underline

    -- Make bold or italic style for editor groups
    if config.editor_better_view then
        style.b_bold   = style.bold
        style.b_italic = style.italic
        style.b_bold_i = style.bold_i
        style.b_bold_u = style.bold_u
    end

    if config.operators_bold then
        style.o_style = style.bold
    end

    if config.delimiters_bold then
        style.d_style = style.bold
    end

    if config.brackets_bold then
        style.br_style = style.bold
    end

    if config.delim_rainbow_bold then
        style.d_r_style = style.bold
    end

    if config.tags_brackets_bold then
        style.tb_style = style.bold
    end

    -- Tex settings
    if config.tex_operators_bold then
        style.tex_o_style = style.bold
    end

    if config.tex_brackets_bold then
        style.tex_br_style = style.bold
    end

    if config.tex_math_delim_bold then
        style.tex_md_style = style.bold
    end

    -- Error style
    if config.error_highlight == "undercurl" or config.error_highlight == "both" then
        style.error = style.undercurl
    end

    -- Make italic strings
    if config.italic_strings then
        style.s_style = style.italic
        style.s_underline = style.s_style .. "," .. style.underline
    end

    -- Make italic comments
    if config.italic_comments then
        style.c_style = style.italic
        style.c_underline = style.c_style .. "," .. style.underline
    end

    -- Make italic comments documenting code
    if config.italic_doc_comments then
        style.doc_style = style.italic
    end

    -- Make italic functions
    if config.italic_functions then
        style.f_style = style.italic
    end

    -- Make italic variables
    if config.italic_variables then
        style.v_style = style.italic
    end

    -- comments for VimL
    if config.italic_comments and config.keywords then
        style.c_title = style.bold_i
    elseif config.keywords then
        style.c_title = style.k_style
    else
        style.c_title = style.c_style
    end

    return style
end

-- stylua: ignore end

return M
