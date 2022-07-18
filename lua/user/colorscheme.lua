

-- Example config in Lua
--vim.g.gruvbox_baby_function_style = "NONE"
--vim.g.gruvbox_baby_keyword_style = "italic"

--[[
--GRUVBOX BABY PALETTE
dark = "#202020",
foreground = "#ebdbb2",
background = "#282828",
background_dark = "#242424",
bg_light = "#32302f",
medium_gray = "#504945",
comment = "#665c54",
gray = "#DEDEDE",
soft_yellow = "#EEBD35",
soft_green = "#98971a",
bright_yellow = "#fabd2f",
orange = "#d65d0e",
red = "#fb4934",
error_red = "#cc241d",
magenta = "#b16286",
pink = "#D4879C",
light_blue = "#7fa2ac",
dark_gray = "#83a598",
blue_gray = "#458588",
forest_green = "#689d6a",
clean_green = "#8ec07c",
milk = "#E7D7AD",

  gruvbox = [
 (40, 40, 40),  # black
 (146, 131, 116),  # gray1
 (204, 36, 29),  # red1,
 (251, 73, 52),  # red2,
 (152, 151, 26),  # green1
 (184, 187, 38),  # green2
 (215, 153, 33),  # yellow1
 (250, 189, 47),  # yellow2
 (69, 133, 136),  # blue1
 (131, 165, 152),  # blue2
 (177, 98, 134),  # purple1
 (104, 157, 106),  # purple2
 (142, 192, 124),  # aqua1
 (168, 153, 132),  # aqua2
 (235, 219, 178),  # gray2
 (214, 93, 14),  # orange1
 (254, 128, 25),  # orange2
        ]


-- Dark theme changes colors to
["dark"] = {
      dark = "#161616",
      background = "#202020",
      background_dark = "#161616",
    },
--]]
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
    TSParameter = {fg = "#89A499"},
    TSComment = {fg = "#8F8475"},
    TSReturn = {fg = "#F04934", style = "NONE"},
--TSStringEscape = {fg = "#C98B9B"},
    TSOperator = {fg = "#96BF81"},
    TSPunctBracket = {fg = "#A86885"},
    TSFuncBuiltin = {fg = "#EF8C33"},
    TSKeyword = {fg = "#F04934"},
    TSVariable = {fg = "#89A499"},
    TSBoolean = {fg = "#C98B9B"},



-- C 
    cTSInclude = {fg = "#96BF81"},
    cTSConstMacro = {fg = "#96BF81"},
    cTSFuncMacro = {fg = "#C48B9B"},
    cTSType = {fg = "#F04934"},
    cTSCharacter = {fg = "#C98B9B"},
    cTSConstBuiltin = {fg = "#FABD2F"},
    cParen = {fg = "#FABD2F"},
    cTSVariable = {fg = "#89A499"},


-- Python
    pythonAttribute = {fg = "#E8DCB5"},
    pythonTSVariable = {fg = "#E8DCB5"},
    pythonTSField = {fg = "#E8DCB5"},
    pythonTSParameter = {fg = "#89A499"},
    pythonTSMethod = {fg = "#96BF81"},
    pythonTSConstructor = {fg = "#96BF81"},
    pythonTSBoolean = {fg = "#C98B9B"},
    pythonTSFuncBuiltin = {fg = "#EF8C33"},
    pythonTSFunction = {fg = "#89A499"},


-- Rust
 rustTSTypeBuiltin = {fg = "#FABD2F"},
 rustTSVariable = {fg = "#89A499"},
 StorageClass = {fg = "#EF8C33"},
 rustStorage = {fg = "#EF8C33"},
 rustTSFuncMacro = {fg = "#FABD2F", style = "bold"},

    --

    --
}

-- Enable telescope theme
vim.g.gruvbox_baby_telescope_theme = 0

-- take off keyword italics
vim.g.gruvbox_baby_keyword_style = "NONE"


local colorscheme = "gruvbox-baby"


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end


