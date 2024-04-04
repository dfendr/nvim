local M = {
    autocommands = {
        convert_to_unix_formatting_on_save = false,
    },
    lsp = { show_diagnostic_signs = false },
    -- Possible Borders: [double, none, rounded, shadow, single, solid].
    ui = {
        transparent = false,
        border_style = "rounded",
        cmp = {
            completion_border = "rounded",
            documentation_border = "rounded",
        },
        which_key = { border_style = "rounded" },
        fidget = { border_style = "none" },

        breadcrumbs = false,
        context = true, -- "Sticky scroll"
        winbar_title = false,
    },
}

return M
