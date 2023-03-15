-- setup must be called before loading the colorscheme

local M = {}

function M.config()
    -- Default Palette
    vim.o.background = "dark" -- or "light" for light mode
    require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = false,
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "hard", -- can be "hard", "soft" or empty string
        overrides = {},
        dim_inactive = false,
    })

    local colorscheme = "gruvbox"

    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
        vim.notify("colorscheme " .. colorscheme .. " not found!")
        return
    end

    vim.cmd([[highlight! link SignColumn Normal]])
    vim.cmd([[highlight! link DiagnosticSignError GruvboxRed]])
    vim.cmd([[highlight! link DiagnosticSignWarn GruvboxYellow]])
    vim.cmd([[highlight! link DiagnosticSignInfo GruvboxBlue]])
    vim.cmd([[highlight! link DiagnosticSignHint GruvboxAqua]])

    vim.cmd([[highlight! link GitSignsDelete GruvboxRed]])
    vim.cmd([[highlight! link GitSignsDeleteNr GruvboxRed]])
    vim.cmd([[highlight! link GitSignsChange GruvboxAqua]])
    vim.cmd([[highlight! link GitSignsChangeNr GruvboxAqua]])

    vim.cmd([[highlight! link GitSignsAdd GruvboxGreen]])
    vim.cmd([[highlight! link GitSignsAddNr GruvboxGreen]])
end
return M
