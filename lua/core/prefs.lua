local M = {
    lsp = {

        diagnostic_signs = false,
    },
    -- Possible Borders: [double, none, rounded, shadow, single, solid].
    ui = {
        border_style = "rounded",
        cmp = {
            completion_border = "rounded",
            documentation_border = "rounded", -- winhighlight = "Normal:PMenu,CursorLine:Comment,Search:PmenuSel",
            winhighlight = "FloatBorder:FloatBorder"
        },
        fidget = "single",
        navic = false,
        which_key = { border_style = "rounded" },
        winbar_title = false,
    },
}

return M
