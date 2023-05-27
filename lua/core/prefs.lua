local M = {
    autocommands = {
        convert_to_unix_formatting_on_save= false,
    },
    lsp = {
        diagnostic_signs = false,
    },
    -- Possible Borders: [double, none, rounded, shadow, single, solid].
    ui = {
        transparent = false,
        border_style = "rounded",
        cmp = {
            completion_border = "rounded",
            documentation_border = "rounded", -- winhighlight = "Normal:PMenu,CursorLine:Comment,Search:PmenuSel",
            -- winhighlight = "FloatBorder:FloatBorder",
        },
        fidget = "none",
        navic = false,
        which_key = { border_style = "rounded" },
        winbar_title = false,
    },
}

return M
