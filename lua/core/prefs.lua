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
            documentation_border = "rounded",
            -- winhighlight = "FloatBorder:FloatBorder",
        },
        fidget = "none",
        breadcrumbs = false, -- winbar_title must be true as well for breadcrumbs to activate.
        which_key = { border_style = "rounded" },
    },
}

return M
