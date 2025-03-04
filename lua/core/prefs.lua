local M = {
    autocommands = {
    },
    lsp = { show_diagnostic_signs = false },
    -- Possible Borders: [double, none, rounded, shadow, single, solid].
    ui = {
        transparent = false,
        show_icons = true;
        border_style = "rounded",
        blink_cmp = {
            completion_border = "rounded",
            documentation_border = "rounded",
            signature_border = "rounded",
        },
        which_key = { border_style = "rounded" },
        fidget = { border_style = "none" },

        breadcrumbs = false,
        context = true, -- "Sticky scroll"
        winbar_title = false,
    },
}

return M
