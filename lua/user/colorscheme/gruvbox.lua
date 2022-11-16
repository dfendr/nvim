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
  contrast = "hard", -- can be "hard", "soft" or empty string
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
        pythonTSMethod = {fg = bright_yellow, bold = true},
        pythonTSMethodCall = {fg = bright_yellow, bold = true},
        pythonTSInclude = {fg = bright_red},
        pythonTSVariable = {fg = light0_soft},
        pythonTSVariableBuiltin = {fg = bright_blue},
        pythonTSField = {fg = light0_soft},
        pythonTSFunction = {fg = bright_yellow, bold = true},

        --Rust
        rustTSTypeBuiltin = {fg = bright_yellow},
        rustTSStorageClass = {fg = bright_orange},
        rustStorage = {fg = bright_orange},
        rustTSFuncMacro = {fg = bright_yellow, bold = true},
       -- rustTSFunction = {fg = bright_yellow, style = "bold"},

        -- Lua
        luaTSKeyword = {fg = bright_red}
  }})
        --TODO Get highlights mapped for Navic
        --NavicIconsFile =          {default = true, bg = "#000000", fg = "#ffffff"})
        --NavicIconsModule =         {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsNamespace=     {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsPackage    =   {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsClass      =  {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsMethod       = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsProperty    = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsField        = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsConstructor  = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsEnum         = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsInterface    = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsFunction    = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsVariable     = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsConstant     = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsString       = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsNumber       = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsBoolean      = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsArray        = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsObject       = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsKey          = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsNull         = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsEnumMember   = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsStruct       = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsEvent        = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsOperator     = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicIconsTypeParameter= {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicText              = {default = true, bg = "#000000", fg = "#ffffff"},
        --NavicSeparator         = {default = true, bg = "#000000", fg = "#ffffff"}}})
  

--TODO: Map out nvim-tree highlight groups:

--7. HIGHLIGHT GROUPS                                     *nvim-tree-highlight*
--
--All the following highlight groups can be configured by hand. Aside from
--`NvimTreeWindowPicker`, it is not advised to colorize the background of these
--groups.
--
--Example (in your `init.vim`):
-->
--    highlight NvimTreeSymlink guifg=blue gui=bold,underline
--<
--You should have 'termguicolors' enabled, otherwise, colors will not be
--applied.
--
--Default linked group follows name.
--
--NvimTreeSymlink
--NvimTreeFolderName          (Directory)
--NvimTreeRootFolder
--NvimTreeFolderIcon
--NvimTreeFileIcon
--NvimTreeEmptyFolderName     (Directory)
--NvimTreeOpenedFolderName    (Directory)
--NvimTreeExecFile
--NvimTreeOpenedFile
--NvimTreeSpecialFile
--NvimTreeImageFile
--NvimTreeIndentMarker
--
--NvimTreeLspDiagnosticsError         (DiagnosticError)
--NvimTreeLspDiagnosticsWarning       (DiagnosticWarn)
--NvimTreeLspDiagnosticsInformation   (DiagnosticInfo)
--NvimTreeLspDiagnosticsHint          (DiagnosticHint)
--
--NvimTreeGitDirty
--NvimTreeGitStaged
--NvimTreeGitMerge
--NvimTreeGitRenamed
--NvimTreeGitNew
--NvimTreeGitDeleted
--NvimTreeGitIgnored      (Comment)
--
--NvimTreeWindowPicker
--
--There are also links to normal bindings to style the tree itself.
--
--NvimTreeNormal
--NvimTreeEndOfBuffer     (NonText)
--NvimTreeCursorLine      (CursorLine)
--NvimTreeVertSplit       (VertSplit)     [deprecated, use NvimTreeWinSeparator]
--NvimTreeWinSeparator    (VertSplit)
--NvimTreeCursorColumn    (CursorColumn)
--
--There are also links for file highlight with git properties, linked to their
--Git equivalent:
--
--NvimTreeFileDirty       (NvimTreeGitDirty)
--NvimTreeFileStaged      (NvimTreeGitStaged)
--NvimTreeFileMerge       (NvimTreeGitMerge)
--NvimTreeFileRenamed     (NvimTreeGitRenamed)
--NvimTreeFileNew         (NvimTreeGitNew)
--NvimTreeFileDeleted     (NvimTreeGitDeleted)
--NvimTreeFileIgnored     (NvimTreeGitIgnored)
--
--There are 2 highlight groups for the live filter feature
--
--NvimTreeLiveFilterPrefix
--NvimTreeLiveFilterValue
--
--Color of the bookmark icon
--
--NvimTreeBookmark

-- Highlight Group 	Defaults to 	Description
-- WhichKey 	Function 	the key
-- WhichKeyGroup 	Keyword 	a group
-- WhichKeySeparator 	DiffAdded 	the separator between the key and its label
-- WhichKeyDesc 	Identifier 	the label of the key
-- WhichKeyFloat 	NormalFloat 	Normal in the popup window
-- WhichKeyValue 	Comment 	used by plugins that provide values

local colorscheme = "gruvbox"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

vim.cmd [[highlight! link SignColumn Normal]]
vim.cmd [[highlight! link DiagnosticSignError GruvboxRed]]
vim.cmd [[highlight! link DiagnosticSignWarn GruvboxYellow]]
vim.cmd [[highlight! link DiagnosticSignInfo GruvboxBlue]]
vim.cmd [[highlight! link DiagnosticSignHint GruvboxAqua]]


vim.cmd [[highlight! link GitSignsDelete GruvboxRed]]
vim.cmd [[highlight! link GitSignsDeleteNr GruvboxRed]]
vim.cmd [[highlight! link GitSignsChange GruvboxAqua]]
vim.cmd [[highlight! link GitSignsChangeNr GruvboxAqua]]

vim.cmd [[highlight! link GitSignsAdd GruvboxGreen]]
vim.cmd [[highlight! link GitSignsAddNr GruvboxGreen]]


