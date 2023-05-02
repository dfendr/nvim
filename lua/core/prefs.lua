local M = {
    lsp = {

        diagnostic_signs = false,
    },
    -- Possible Borders: [double, none, rounded, shadow, single, solid].
    ui = {
        winbar_title = false,
        navic = false,
        cmp = {
            completion_border = "rounded",
            documentation_border = "rounded",
            -- winhighlight = "Normal:PMenu,CursorLine:Comment,Search:PmenuSel",
        },
        which_key = {
            border_style = "rounded",
        },
        border_style = "rounded",
        -- TODO: Create CMP setting to swap fg/bg on highlight groups
    },
}

return M
