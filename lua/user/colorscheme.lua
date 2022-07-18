-- setup must be called before loading the colorscheme

-- Default Palette
local dark0_hard = "#1d2021"
local dark0 = "#282828"
local dark0_soft = "#32302f"
local dark1 = "#3c3836"
local dark2 = "#504945"
local dark3 = "#665c54"
local dark4 = "#7c6f64"
local light0_hard = "#f9f5d7"
local light0 = "#fbf1c7"
local light0_soft = "#f2e5bc"
local light1 = "#ebdbb2"
local light2 = "#d5c4a1"
local light3 = "#bdae93"
local light4 = "#a89984"
local bright_red = "#fb4934"
local bright_green = "#b8bb26"
local bright_yellow = "#fabd2f"
local bright_blue = "#83a598"
local bright_purple = "#d3869b"
local bright_aqua = "#8ec07c"
local bright_orange = "#fe8019"
local neutral_red = "#cc241d"
local neutral_green = "#98971a"
local neutral_yellow = "#d79921"
local neutral_blue = "#458588"
local neutral_purple = "#b16286"
local neutral_aqua = "#689d6a"
local neutral_orange = "#d65d0e"
local faded_red = "#9d0006"
local faded_green = "#79740e"
local faded_yellow = "#b57614"
local faded_blue = "#076678"
local faded_purple = "#8f3f71"
local faded_aqua = "#427b58"
local faded_orange = "#af3a03"
local gray = "#928374"

require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  overrides = {
        --General
        TSOperator = {fg = bright_aqua},
        TSStringEscape = {fg = bright_purple},
        TSPunctDelimiter = {fg = dark4, bold = true},
        --TSKeyword = {fg = bright_orange},
        TSKeywordReturn = {fg = bright_red},
        TSFunction = {fg = bright_yellow, bold = true},
        --TSVariable = {fg = light0_soft},
        TSFuncMacro = {fg = bright_yellow, bold = true},
        -- C
        cTSFunction = {fg = bright_yellow, bold = true},
        cTSConst = {fg = bright_yellow},
        cTSInclude = {fg = bright_aqua},
        cTSConstMacro = {fg = bright_aqua},
        cTSFuncMacro = {fg = bright_purple},
        cTSType = {fg = bright_red},
        cTSCharacter = {fg = bright_purple},
        cTSConstBuiltin = {fg = bright_yellow},
        cTSParen = {fg = bright_yellow},
        cTSVariable = {fg = bright_blue},

        --Python
        pythonAttribute = {fg = light0_soft},
        pythonTSMethod = {fg = bright_blue, bold = true},
        pythonTSInclude = {fg = bright_red},
        pythonTSVariable = {fg = light0_soft},
        pythonTSVariableBuiltin = {fg = bright_blue},
        pythonTSField = {fg = light0_soft},
        pythonTSFunction = {fg = bright_blue, bold = true},

        --Rust
        rustTSTypeBuiltin = {fg = bright_yellow},
        rustTSStorageClass = {fg = bright_orange},
        rustStorage = {fg = bright_orange},
        rustTSFuncMacro = {fg = bright_yellow, bold = true},
       -- rustTSFunction = {fg = bright_yellow, style = "bold"},
    
        -- Lua
        luaTSKeyword = {fg = bright_red},


    }
})

local colorscheme = "gruvbox"


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end




