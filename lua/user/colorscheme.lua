

-- Example config in Lua
--vim.g.gruvbox_baby_function_style = "NONE"
--vim.g.gruvbox_baby_keyword_style = "italic"

-- Each highlight group must follow the structure:
-- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
-- See also :h highlight-guifg
-- Example:
local colors = require("gruvbox-baby.colors").config()

vim.g.gruvbox_baby_background_color = "dark"
vim.g.gruvbox_baby_highlights = {
                                -- General
                                 TSString =   {fg = "#B6BC41"},
                                 TSConstructor = {fg = "#89A499"},
                                 TSVariableBuiltin = {fg = "#89A499"},
                                 Directory = {fg = "#8EC07C"},
                                 TSNumber = {fg = "#C98B9B"},
                                 TSKeyword = {fg = "#EF8C33"},
                                 TSParameter = {fg = "#89A499"},
                                 TSComment = {fg = "#8F8475"},
                                 TSReturn = {fg = "#E95F3D", style = "NONE"},
                                 TSStringEscape = {fg = "#C98B9B"},
                                 TSOperator = {fg = "#96BF81"},
                                 TSPunctBracket = {fg = "#A86885"},
                                 TSProperty = {fg = "#E8DCB5"},
                                 TSVariable = {fg = "#E8DCB5"},
                                 TSField = {fg = "#E8DCB5"},
                                 TSFuncBuiltin = {fg = "#EF8C33"},
                                 --TSVariable = {fg = "#89A499"},



                                -- C 
                                 cTSInclude = {fg = "#96BF81"},
                                 cTSConstMacro = {fg = "#96BF81"},
                                 cTSFuncMacro = {fg = "#C48B9B"},
                                 cTSType = {fg = "#E95F3D"},
                                 cTSCharacter = {fg = "#C98B9B"},
                                 cTSConstBuiltin = {fg = "#F0C249"},
                                 cParen = {fg = "#F0C249"},
                                 cTSVariable = {fg = "#89A499"},


                                -- Python
                                 pythonAttribute = {fg = "#E8DCB5"},
                                 pythonTSParameter = {fg = "#89A499"},
                                 pythonTSMethod = {fg = "#96BF81"},
                                 pythonTSConstructor = {fg = "#96BF81"},
                                 pythonTSKeyword = {fg = "#E95F3D"},
                                 pythonTSPunctBracket = {fg = "#A86885"},
                                 pythonTSBoolean = {fg = "#C98B9B"},
                                 pythonTSFuncBuiltin = {fg = "#EF8C33"},
                                 pythonTSFunction = {fg = "#89A499"},


                                -- Rust
                                 rustTSTypeBuiltin = {fg = "#F0C249"},
                                 rustTSVariable = {fg = "#89A499"},
                                 rustTSKeyword = {fg = "#F04834"},
                                 StorageClass = {fg = "#EF8C33"},
                                 rustStorage = {fg = "#EF8C33"},
                                 rustTSFuncMacro = {fg = "#F0C249", style = "bold"},

    --

    --
}

-- Enable telescope theme
vim.g.gruvbox_baby_telescope_theme = 0

-- Enable transparent mode
vim.g.gruvbox_baby_transparent_mode = 1
vim.g.gruvbox_baby_keyword_style = "NONE"


local colorscheme = "gruvbox-baby"


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end


